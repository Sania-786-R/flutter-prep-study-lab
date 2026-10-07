import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_study_lab/core/constants/app_constants.dart';
import 'package:prep_study_lab/models/models.dart';
import 'package:prep_study_lab/services/test_service.dart';

class CoursesView extends StatefulWidget {
  final List<CourseModel> courses;
  final Function(String courseId) onStartCourseTest;
  final TestService testService;

  const CoursesView({
    super.key,
    required this.courses,
    required this.onStartCourseTest,
    required this.testService,
  });

  @override
  State<CoursesView> createState() => _CoursesViewState();
}

class _CoursesViewState extends State<CoursesView> {
  String? _selectedCourseId;
  int? _selectedWeekTab; // null means 'All Weeks'
  List<QuestionModel> _courseQuestions = [];
  bool _isLoadingQuestions = false;

  @override
  void initState() {
    super.initState();
    if (widget.courses.isNotEmpty) {
      _selectedCourseId = widget.courses.first.id;
      _loadQuestionsForCourse(_selectedCourseId!);
    }
  }

  Future<void> _loadQuestionsForCourse(String courseId) async {
    setState(() {
      _isLoadingQuestions = true;
    });
    final questions = await widget.testService.loadQuestions(
      courseId: courseId,
      approvedOnly: true,
    );
    if (mounted) {
      setState(() {
        _courseQuestions = questions;
        _isLoadingQuestions = false;
      });
    }
  }

  List<int> _deriveAvailableWeeks(List<QuestionModel> questions, CourseModel? course) {
    final Set<int> weeks = {};
    for (final q in questions) {
      if (q.weekNumber > 0) weeks.add(q.weekNumber);
    }
    if (weeks.isEmpty && course != null && course.weeks.isNotEmpty) {
      weeks.addAll(course.weeks);
    }
    final sorted = weeks.toList()..sort();
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;

    final selectedCourse = widget.courses.firstWhere(
      (c) => c.id == _selectedCourseId,
      orElse: () => widget.courses.isNotEmpty
          ? widget.courses.first
          : CourseModel(id: '', code: '', name: ''),
    );

    final availableWeeks = _deriveAvailableWeeks(_courseQuestions, selectedCourse);

    final displayedQuestions = _courseQuestions.where((q) {
      if (_selectedWeekTab == null) return true;
      return q.weekNumber == _selectedWeekTab;
    }).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 48),

          // Header
          Text(
            'ACADEMIC CURRICULUM',
            style: GoogleFonts.jetBrainsMono(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Published Courses & Tests',
            style: GoogleFonts.playfairDisplay(
              fontSize: 28,
              fontWeight: FontWeight.normal,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'VERIFIED QUESTION ARCHIVES AVAILABLE FOR SIMULATION',
            style: GoogleFonts.jetBrainsMono(
              fontSize: 10,
              color: AppColors.textMuted,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 24),

          if (widget.courses.isEmpty) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(48),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.border),
              ),
              child: const Column(
                children: [
                  Icon(Icons.menu_book_outlined, size: 48, color: AppColors.primaryLight),
                  SizedBox(height: 16),
                  Text('No tests available yet', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 8),
                  Text(
                    'New question banks will appear here once published by an administrator.',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 13),
                  ),
                ],
              ),
            ),
          ] else ...[
            Flex(
              direction: isDesktop ? Axis.horizontal : Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left: Courses List
                SizedBox(
                  width: isDesktop ? 340 : double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AVAILABLE DISCIPLINES (${widget.courses.length})',
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textMuted,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.courses.length,
                        separatorBuilder: (context, _) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final c = widget.courses[index];
                          final isSelected = c.id == _selectedCourseId;

                          return InkWell(
                            onTap: () {
                              setState(() {
                                _selectedCourseId = c.id;
                                _selectedWeekTab = null;
                              });
                              _loadQuestionsForCourse(c.id);
                            },
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.primarySoft : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isSelected ? AppColors.primaryLight : AppColors.border,
                                  width: isSelected ? 1.5 : 1.0,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                        decoration: BoxDecoration(
                                          color: AppColors.primarySoft,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: AppColors.border),
                                        ),
                                        child: Text(
                                          c.code,
                                          style: GoogleFonts.jetBrainsMono(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '${c.totalQuestions} Questions',
                                        style: GoogleFonts.jetBrainsMono(
                                          fontSize: 10,
                                          color: AppColors.textMuted,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    c.name,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textDark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                if (isDesktop) const SizedBox(width: 24),
                if (!isDesktop) const SizedBox(height: 24),

                // Right: Selected Course Details & Questions Browser
                Expanded(
                  flex: isDesktop ? 1 : 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Active Course Banner
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      selectedCourse.code,
                                      style: GoogleFonts.jetBrainsMono(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    Text(
                                      selectedCourse.name,
                                      style: GoogleFonts.playfairDisplay(
                                        fontSize: 22,
                                        fontWeight: FontWeight.normal,
                                        color: AppColors.textDark,
                                      ),
                                    ),
                                  ],
                                ),
                                FilledButton.icon(
                                  onPressed: () => widget.onStartCourseTest(selectedCourse.id),
                                  icon: const Icon(Icons.play_arrow, size: 16),
                                  label: const Text('LAUNCH TEST'),
                                  style: FilledButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Divider(color: AppColors.border, height: 1),
                            const SizedBox(height: 12),

                            // Weeks Filter Chips (dynamic from 1..11 weeks in database)
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ChoiceChip(
                                    label: Text('All Weeks (${_courseQuestions.length})'),
                                    selected: _selectedWeekTab == null,
                                    onSelected: (val) {
                                      setState(() {
                                        _selectedWeekTab = null;
                                      });
                                    },
                                    selectedColor: AppColors.primary,
                                    labelStyle: TextStyle(
                                      color: _selectedWeekTab == null ? Colors.white : AppColors.textMuted,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  ...availableWeeks.map((wk) {
                                    final count = _courseQuestions.where((q) => q.weekNumber == wk).length;
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: ChoiceChip(
                                        label: Text('Week $wk ($count)'),
                                        selected: _selectedWeekTab == wk,
                                        onSelected: (val) {
                                          setState(() {
                                            _selectedWeekTab = val ? wk : null;
                                          });
                                        },
                                        selectedColor: AppColors.primary,
                                        labelStyle: TextStyle(
                                          color: _selectedWeekTab == wk ? Colors.white : AppColors.textMuted,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Questions count
                      Text(
                        '${displayedQuestions.length} QUESTIONS IN CURRENT VIEW',
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textMuted,
                        ),
                      ),
                      const SizedBox(height: 12),

                      if (_isLoadingQuestions) ...[
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(32.0),
                            child: CircularProgressIndicator(color: AppColors.primary),
                          ),
                        ),
                      ] else ...[
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: displayedQuestions.length,
                          separatorBuilder: (context, _) => const SizedBox(height: 12),
                          itemBuilder: (context, idx) {
                            final q = displayedQuestions[idx];
                            return Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'WEEK ${q.weekNumber} • Q${idx + 1}',
                                        style: GoogleFonts.jetBrainsMono(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      if (q.sourcePdfName != null && q.sourcePdfName!.isNotEmpty)
                                        Text(
                                          q.sourcePdfName!,
                                          style: GoogleFonts.jetBrainsMono(fontSize: 10, color: AppColors.textSubtle),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    q.questionText,
                                    style: const TextStyle(fontSize: 14, color: AppColors.textDark, height: 1.4),
                                  ),
                                  const SizedBox(height: 12),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: List.generate(q.options.length, (optIdx) {
                                      final isCorrect = optIdx == q.correctAnswerIndex;
                                      final letter = String.fromCharCode(65 + optIdx);
                                      return Container(
                                        width: isDesktop ? 280 : double.infinity,
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: isCorrect ? AppColors.successSoft : AppColors.background,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                            color: isCorrect ? AppColors.success.withValues(alpha: 0.4) : AppColors.border,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              '$letter: ',
                                              style: GoogleFonts.jetBrainsMono(
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                                color: isCorrect ? AppColors.success : AppColors.textMuted,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                q.options[optIdx],
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: isCorrect ? AppColors.textDark : AppColors.textMuted,
                                                  fontWeight: isCorrect ? FontWeight.w600 : FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}
