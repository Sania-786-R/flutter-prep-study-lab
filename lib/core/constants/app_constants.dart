import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'Prep Study Lab';
  static const String tagline = 'ACADEMIC PERFORMANCE SUITE';
  static const String subtitle =
      'Practice verified academic test questions. Test your understanding under strict simulated exam conditions.';

  // Supabase production configuration
  static const String supabaseUrl = 'https://kbebriigrnkgzzzsqymk.supabase.co';
  static const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtiZWJyaWlncm5rZ3p6enNxeW1rIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODk2NTI0NjksImV4cCI6MjEwNTIyODQ2OX0.9CBS8W5yGpWoHCssRR6uGFCMQR19ZlDes6Pa5DAPZzU';

  // Shared preferences keys
  static const String keyUserSession = 'prep_studylab_auth_user_v2';
  static const String keyLocalUsers = 'prep_studylab_local_users_v2';
  static const String keyActiveTest = 'prep_studylab_active_test_v2';
  static const String keyCachedCourses = 'prep_studylab_courses_v2';
  static const String keyCachedQuestions = 'prep_studylab_questions_v2';
  static const String keyCachedAttempts = 'prep_studylab_attempts_v2';

  // Release APK download URL
  static const String apkDownloadUrl = 'https://prepstudylab.com/download/prep-study-lab.apk';
}

class AppColors {
  static const Color background = Color(0xFFF8FBFF);
  static const Color surface = Colors.white;
  static const Color primary = Color(0xFF0284C7); // Sky blue 600
  static const Color primaryDark = Color(0xFF0369A1); // Sky blue 700
  static const Color primaryLight = Color(0xFF38BDF8); // Sky blue 400
  static const Color primarySoft = Color(0xFFEFF8FF); // Sky blue 50
  static const Color border = Color(0xFFDCEAF5);
  static const Color textDark = Color(0xFF0F172A); // Slate 900
  static const Color textMuted = Color(0xFF64748B); // Slate 500
  static const Color textSubtle = Color(0xFF94A3B8); // Slate 400
  static const Color success = Color(0xFF10B981); // Emerald 500
  static const Color successSoft = Color(0xFFECFDF5);
  static const Color error = Color(0xFFF43F5E); // Rose 500
  static const Color errorSoft = Color(0xFFFFF1F2);
  static const Color warning = Color(0xFFF59E0B); // Amber 500
  static const Color warningSoft = Color(0xFFFFFBEB);
}
