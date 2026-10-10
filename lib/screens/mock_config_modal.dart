import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_study_lab/core/constants/app_constants.dart';
import 'package:prep_study_lab/models/models.dart';
import 'package:prep_study_lab/services/test_service.dart';

class MockConfigModal extends StatefulWidget {
  final List<CourseModel> courses;
  final String? preselectedCourseId;
  final Function(MockConfigModel config) onStartTest;
  final TestService testService;

  const MockConfigModal({
    super.key,
    required this.courses,
    this.preselectedCourseId,
    required this.onStartTest,
    required this.testService,
  });

  @override
  State<MockConfigModal> createState() => _MockConfigModalState();
}

class _MockConfigModalState extends State<MockConfigModal> {
  late String _selectedCourseId;
  List<int> _selectedWeeks = [];
  dynamic _questionCount = 10; // 10, 20, 30, 'all', or custom int
  final String _selectionType = 'random'; // 'random', 'unattempted', 'wrong', 'all'
  String _mode = 'practice'; // 'practice', 'exam'
  int _timeLimitMinutes = 15;
  List<QuestionModel> _questions = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedCourseId = widget.preselectedCourseId ??
        (widget.courses.isNotEmpty ? widget.courses.first.id : '');
    _loadCourseData(_selectedCourseId);
  }

  Future<void> _loadCourseData(String courseId) async {
    setState(() {
      _isLoading = true;
    });
    final qList = await widget.testService.loadQuestions(courseId: courseId, approvedOnly: true);
    final targetCourse = widget.courses.firstWhere(
      (c) => c.id == courseId,
      orElse: () => CourseModel(id: '', code: '', name: ''),
    );

    final Set<int> weeks = {};
    for (final q in qList) {
      if (q.weekNumber > 0) weeks.add(q.weekNumber);
    }
    if (weeks.isEmpty && targetCourse.weeks.isNotEmpty) {
      weeks.addAll(targetCourse.weeks);
    }
    final sortedWeeks = weeks.toList()..sort();

    if (mounted) {
      setState(() {
        _questions = qList;
        _selectedWeeks = sortedWeeks;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentCourse = widget.courses.firstWhere(
      (c) => c.id == _selectedCourseId,
      orElse: () => widget.courses.isNotEmpty
          ? widget.courses.first
          : CourseModel(id: '', code: '', name: ''),
    );

    final availableWeeks = (() {
      final Set<int> weeks = {};
      for (final q in _questions) {
        if (q.weekNumber > 0) weeks.add(q.weekNumber);
      }
      if (weeks.isEmpty && currentCourse.weeks.isNotEmpty) {
        weeks.addAll(currentCourse.weeks);
      }
      return weeks.toList()..sort();
    })();

    final availableCount = _questions.where((q) => _selectedWeeks.contains(q.weekNumber)).length;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 580,
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primarySoft,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(Icons.tune, color: AppColors.primary, size: 20),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'CONFIGURE TEST SIMULATION',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                  color: AppColors.primary,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Customize Your Session',
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.textDark,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.textMuted),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(color: AppColors.border, height: 1),
              const SizedBox(height: 16),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Course Selector Dropdown
                      const Text(
                        'DISCIPLINE / COURSE',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textMuted),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedCourseId.isNotEmpty ? _selectedCourseId : null,
                            isExpanded: true,
                            items: widget.courses.map((c) {
                              return DropdownMenuItem(
                                value: c.id,
                                child: Text(
                                  '${c.code} — ${c.name}',
                                  style: const TextStyle(fontSize: 13, color: AppColors.textDark),
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) {
                                setState(() {
                                  _selectedCourseId = val;
                                });
                                _loadCourseData(val);
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Module / Week Selection Chips (Supports all 11 weeks dynamically)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'SELECT WEEKS / MODULES',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textMuted),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _selectedWeeks = List.from(availableWeeks);
                              });
                            },
                            child: const Text('Select All', style: TextStyle(fontSize: 11)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: availableWeeks.map((wk) {
                          final isSelected = _selectedWeeks.contains(wk);
                          return FilterChip(
                            label: Text('Week $wk'),
                            selected: isSelected,
                            onSelected: (val) {
                              setState(() {
                                if (isSelected) {
                                  if (_selectedWeeks.length > 1) {
                                    _selectedWeeks.remove(wk);
                                  }
                                } else {
                                  _selectedWeeks.add(wk);
                                  _selectedWeeks.sort();
                                }
                              });
                            },
                            selectedColor: AppColors.primary,
                            checkmarkColor: Colors.white,
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : AppColors.textDark,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),

                      // Test Mode (Practice vs Exam)
                      const Text(
                        'EXAMINATION MODE',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textMuted),
                      ),
                      const SizedBox(height: 8),
                      Builder(builder: (ctx) {
                        final isCompact = MediaQuery.of(ctx).size.width < 500;
                        final practiceCard = _buildModeSelector(
                          title: 'Practice Mode',
                          description: 'Immediate correctness feedback and learning hints after each selection.',
                          icon: Icons.auto_awesome_outlined,
                          isSelected: _mode == 'practice',
                          onTap: () => setState(() => _mode = 'practice'),
                        );
                        final examCard = _buildModeSelector(
                          title: 'Exam Mode',
                          description: 'Strict timer simulation. Neutral options with zero correctness revealed.',
                          icon: Icons.shield_outlined,
                          isSelected: _mode == 'exam',
                          onTap: () => setState(() => _mode = 'exam'),
                        );

                        if (isCompact) {
                          return Column(
                            children: [
                              practiceCard,
                              const SizedBox(height: 10),
                              examCard,
                            ],
                          );
                        }
                        return Row(
                          children: [
                            Expanded(child: practiceCard),
                            const SizedBox(width: 12),
                            Expanded(child: examCard),
                          ],
                        );
                      }),
                      const SizedBox(height: 20),

                      // Question Count
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'QUESTION COUNT',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textMuted),
                          ),
                          Text(
                            '$availableCount questions available in selected weeks',
                            style: GoogleFonts.jetBrainsMono(fontSize: 10, color: AppColors.textSubtle),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: [10, 20, 30, 'all'].map((opt) {
                          final isSelected = _questionCount == opt;
                          return ChoiceChip(
                            label: Text(opt == 'all' ? 'All ($availableCount)' : '$opt Questions'),
                            selected: isSelected,
                            onSelected: (val) {
                              setState(() {
                                _questionCount = opt;
                              });
                            },
                            selectedColor: AppColors.primary,
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : AppColors.textDark,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),

                      // Time Limit
                      if (_mode == 'exam') ...[
                        const Text(
                          'TIME LIMIT (MINUTES)',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textMuted),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: [10, 15, 30, 45, 60].map((mins) {
                            final isSelected = _timeLimitMinutes == mins;
                            return ChoiceChip(
                              label: Text('$mins Min'),
                              selected: isSelected,
                              onSelected: (val) {
                                setState(() {
                                  _timeLimitMinutes = mins;
                                });
                              },
                              selectedColor: AppColors.primary,
                              labelStyle: TextStyle(
                                color: isSelected ? Colors.white : AppColors.textDark,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),
              // Submit button
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _isLoading || availableCount == 0
                      ? null
                      : () {
                          final config = MockConfigModel(
                            courseId: currentCourse.id,
                            courseName: currentCourse.name,
                            selectedWeeks: _selectedWeeks,
                            questionCount: _questionCount,
                            selectionType: _selectionType,
                            mode: _mode,
                            timeLimitMinutes: _mode == 'exam' ? _timeLimitMinutes : 0,
                          );
                          Navigator.of(context).pop();
                          widget.onStartTest(config);
                        },
                  icon: const Icon(Icons.play_arrow),
                  label: Text(_isLoading ? 'Loading Questions...' : 'LAUNCH SIMULATION'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModeSelector({
    required String title,
    required String description,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
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
              children: [
                Icon(icon, size: 18, color: isSelected ? AppColors.primary : AppColors.textMuted),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? AppColors.primary : AppColors.textDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              description,
              style: const TextStyle(fontSize: 10, color: AppColors.textMuted, height: 1.3),
            ),
          ],
        ),
      ),
    );
  }
}
