-- Prep Study Lab Database Schema
-- Supabase PostgreSQL Schema with Row Level Security (RLS)
-- Role-based architecture: Admin vs Student

-- 1. User Roles Table (Admin vs Student)
CREATE TABLE IF NOT EXISTS public.user_roles (
    user_id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    role TEXT NOT NULL DEFAULT 'student' CHECK (role IN ('admin', 'student')),
    created_at TIMESTAMPTZ DEFAULT now() NOT NULL
);

-- Helper function to check if requesting user is administrator
CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS BOOLEAN AS $$
BEGIN
    -- 1. Check user_roles table
    IF EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role = 'admin'
    ) THEN
        RETURN TRUE;
    END IF;

    -- 2. Check JWT metadata
    IF (auth.jwt() -> 'user_metadata' ->> 'role' = 'admin') OR
       (auth.jwt() -> 'app_metadata' ->> 'role' = 'admin') OR
       (auth.jwt() ->> 'email' LIKE '%admin%') THEN
        RETURN TRUE;
    END IF;

    RETURN FALSE;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 2. Courses Table with Test Lifecycle (draft, review, published)
CREATE TABLE IF NOT EXISTS public.courses (
    id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
    code TEXT NOT NULL,
    name TEXT NOT NULL,
    description TEXT DEFAULT '',
    status TEXT NOT NULL DEFAULT 'draft' CHECK (status IN ('draft', 'review', 'published')),
    total_questions INTEGER NOT NULL DEFAULT 0,
    weeks JSONB NOT NULL DEFAULT '[]'::jsonb,
    published_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT now() NOT NULL
);

-- Idempotent column migrations for existing instances
ALTER TABLE public.courses ADD COLUMN IF NOT EXISTS total_questions INTEGER NOT NULL DEFAULT 0;
ALTER TABLE public.courses ADD COLUMN IF NOT EXISTS weeks JSONB NOT NULL DEFAULT '[]'::jsonb;

-- 3. PDF Documents Table
CREATE TABLE IF NOT EXISTS public.pdf_documents (
    id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
    course_id TEXT REFERENCES public.courses(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    filename TEXT NOT NULL,
    storage_path TEXT DEFAULT '',
    week_number INTEGER NOT NULL DEFAULT 1,
    extracted_questions_count INTEGER NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT now() NOT NULL
);

-- 4. Questions Table with Authoritative Answer Source & Approval Gate
CREATE TABLE IF NOT EXISTS public.questions (
    id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
    course_id TEXT REFERENCES public.courses(id) ON DELETE CASCADE,
    week_number INTEGER NOT NULL DEFAULT 1,
    source_pdf_id TEXT REFERENCES public.pdf_documents(id) ON DELETE SET NULL,
    source_pdf_name TEXT DEFAULT '',
    question_text TEXT NOT NULL,
    options JSONB NOT NULL, -- Array of 4 strings: ["Option A", "Option B", "Option C", "Option D"]
    correct_answer_index INTEGER CHECK (correct_answer_index IS NULL OR (correct_answer_index >= 0 AND correct_answer_index <= 3)),
    answer_source TEXT NOT NULL DEFAULT 'Not Available' CHECK (answer_source IN ('Answer Key', 'PDF', 'Manually Verified', 'Not Available')),
    is_approved BOOLEAN NOT NULL DEFAULT false,
    explanation TEXT DEFAULT '',
    created_at TIMESTAMPTZ DEFAULT now() NOT NULL
);

-- 5. Mock Attempts Table (Immutable historical snapshot preservation)
CREATE TABLE IF NOT EXISTS public.mock_attempts (
    id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
    user_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
    student_name TEXT DEFAULT 'Student',
    course_id TEXT,
    course_name TEXT NOT NULL,
    mode TEXT NOT NULL CHECK (mode IN ('practice', 'exam')),
    total_questions INTEGER NOT NULL,
    score INTEGER NOT NULL,
    percentage NUMERIC(5,2) NOT NULL,
    correct_count INTEGER NOT NULL,
    wrong_count INTEGER NOT NULL,
    unanswered_count INTEGER NOT NULL,
    time_taken_seconds INTEGER NOT NULL,
    time_limit_seconds INTEGER,
    is_completed BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT now() NOT NULL,
    completed_at TIMESTAMPTZ DEFAULT now() NOT NULL
);

-- 6. Attempt Items Table (Faithfully stores exact displayed question and randomized option order)
CREATE TABLE IF NOT EXISTS public.attempt_items (
    id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
    attempt_id TEXT REFERENCES public.mock_attempts(id) ON DELETE CASCADE NOT NULL,
    question_id TEXT,
    question_index INTEGER NOT NULL,
    question_text TEXT NOT NULL,
    displayed_options JSONB NOT NULL, -- Exact 4 strings in randomized order as shown during attempt
    selected_option_index INTEGER, -- 0-3 index in displayed_options, or NULL if skipped
    correct_option_index INTEGER, -- 0-3 index in displayed_options, or NULL
    is_correct BOOLEAN NOT NULL DEFAULT false,
    is_marked_for_review BOOLEAN NOT NULL DEFAULT false,
    time_spent_seconds INTEGER NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT now() NOT NULL
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_questions_course_week ON public.questions(course_id, week_number);
CREATE INDEX IF NOT EXISTS idx_attempts_created ON public.mock_attempts(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_attempt_items_order ON public.attempt_items(attempt_id, question_index ASC);
CREATE INDEX IF NOT EXISTS idx_courses_status ON public.courses(status);

-- Enable Row Level Security (RLS) on all tables
ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.courses ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.pdf_documents ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.mock_attempts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.attempt_items ENABLE ROW LEVEL SECURITY;

-- User Roles Policies
DROP POLICY IF EXISTS "Users can read own role" ON public.user_roles;
CREATE POLICY "Users can read own role" 
    ON public.user_roles FOR SELECT 
    USING (auth.uid() = user_id OR public.is_admin());

DROP POLICY IF EXISTS "Admins and users can insert user role" ON public.user_roles;
CREATE POLICY "Admins and users can insert user role" 
    ON public.user_roles FOR INSERT 
    WITH CHECK (auth.uid() = user_id OR public.is_admin());

DROP POLICY IF EXISTS "Admins can update user role" ON public.user_roles;
CREATE POLICY "Admins can update user role" 
    ON public.user_roles FOR UPDATE 
    USING (public.is_admin());

-- Courses Policies: Students can ONLY view published courses; Admins can manage all
DROP POLICY IF EXISTS "Students view published courses, Admins view all" ON public.courses;
CREATE POLICY "Students view published courses, Admins view all" 
    ON public.courses FOR SELECT 
    USING (status = 'published' OR public.is_admin());

DROP POLICY IF EXISTS "Admins can insert courses" ON public.courses;
CREATE POLICY "Admins can insert courses" 
    ON public.courses FOR INSERT 
    WITH CHECK (public.is_admin());

DROP POLICY IF EXISTS "Admins can update courses" ON public.courses;
CREATE POLICY "Admins can update courses" 
    ON public.courses FOR UPDATE 
    USING (public.is_admin());

DROP POLICY IF EXISTS "Admins can delete courses" ON public.courses;
CREATE POLICY "Admins can delete courses" 
    ON public.courses FOR DELETE 
    USING (public.is_admin());

-- PDF Documents Policies: Strictly Admin
DROP POLICY IF EXISTS "Admins manage PDF documents" ON public.pdf_documents;
CREATE POLICY "Admins manage PDF documents" 
    ON public.pdf_documents FOR ALL 
    USING (public.is_admin());

-- Questions Policies: Students can only view approved questions from published courses
DROP POLICY IF EXISTS "Students view published approved questions" ON public.questions;
CREATE POLICY "Students view published approved questions" 
    ON public.questions FOR SELECT 
    USING (
        is_approved = true AND 
        EXISTS (SELECT 1 FROM public.courses WHERE courses.id = questions.course_id AND courses.status = 'published')
        OR public.is_admin()
    );

DROP POLICY IF EXISTS "Admins insert questions" ON public.questions;
CREATE POLICY "Admins insert questions" 
    ON public.questions FOR INSERT 
    WITH CHECK (public.is_admin());

DROP POLICY IF EXISTS "Admins update questions" ON public.questions;
CREATE POLICY "Admins update questions" 
    ON public.questions FOR UPDATE 
    USING (public.is_admin());

DROP POLICY IF EXISTS "Admins delete questions" ON public.questions;
CREATE POLICY "Admins delete questions" 
    ON public.questions FOR DELETE 
    USING (public.is_admin());

-- Mock Attempts Policies: Students read/insert own attempts; Admins can monitor recent attempts
DROP POLICY IF EXISTS "Users can read own attempts and admins can read all" ON public.mock_attempts;
CREATE POLICY "Users can read own attempts and admins can read all" 
    ON public.mock_attempts FOR SELECT 
    USING (auth.uid() = user_id OR public.is_admin());

DROP POLICY IF EXISTS "Users can insert own attempts" ON public.mock_attempts;
CREATE POLICY "Users can insert own attempts" 
    ON public.mock_attempts FOR INSERT 
    WITH CHECK (auth.uid() = user_id OR user_id IS NULL);

DROP POLICY IF EXISTS "Attempt items access" ON public.attempt_items;
CREATE POLICY "Attempt items access" 
    ON public.attempt_items FOR ALL 
    USING (
        EXISTS (
            SELECT 1 FROM public.mock_attempts 
            WHERE mock_attempts.id = attempt_items.attempt_id 
            AND (mock_attempts.user_id = auth.uid() OR mock_attempts.user_id IS NULL OR public.is_admin())
        )
    );

-- Enable Supabase Realtime for instant synchronization across clients
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_publication WHERE pubname = 'supabase_realtime') THEN
        ALTER PUBLICATION supabase_realtime ADD TABLE public.courses;
        ALTER PUBLICATION supabase_realtime ADD TABLE public.questions;
    END IF;
EXCEPTION WHEN OTHERS THEN
    NULL;
END;
$$;

