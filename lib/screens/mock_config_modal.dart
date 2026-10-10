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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primarySoft,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(Icons.tune, color: AppColors.primary, size: 22),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'CONFIGURE MOCK TEST',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                  color: AppColors.textDark,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Set up your custom practice session',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textMuted,
                                ),
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
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Divider(color: AppColors.border, height: 1),
              const SizedBox(height: 14),

              Expanded(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. SELECT TEST
                      const Text(
                        '1. SELECT TEST',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          color: AppColors.textMuted,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedCourseId.isNotEmpty ? _selectedCourseId : null,
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textMuted),
                            items: widget.courses.map((c) {
                              return DropdownMenuItem(
                                value: c.id,
                                child: Text(
                                  '${c.code} — ${c.name} (${_questions.length} questions)',
                                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textDark),
                                  overflow: TextOverflow.ellipsis,
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

                      // 2. SELECT WEEKS
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '2. SELECT WEEKS',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                              color: AppColors.textMuted,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.primarySoft,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${_questions.length} questions',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Preset Pills
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildPresetPill('All Weeks', () {
                              setState(() => _selectedWeeks = List.from(availableWeeks));
                            }, _selectedWeeks.length == availableWeeks.length && availableWeeks.isNotEmpty),
                            const SizedBox(width: 6),
                            _buildPresetPill('Week 1-3', () {
                              setState(() => _selectedWeeks = availableWeeks.where((w) => w >= 1 && w <= 3).toList());
                            }, _isPresetActive(availableWeeks, 1, 3)),
                            const SizedBox(width: 6),
                            _buildPresetPill('Week 4-6', () {
                              setState(() => _selectedWeeks = availableWeeks.where((w) => w >= 4 && w <= 6).toList());
                            }, _isPresetActive(availableWeeks, 4, 6)),
                            const SizedBox(width: 6),
                            _buildPresetPill('Week 7-9', () {
                              setState(() => _selectedWeeks = availableWeeks.where((w) => w >= 7 && w <= 9).toList());
                            }, _isPresetActive(availableWeeks, 7, 9)),
                            const SizedBox(width: 6),
                            _buildPresetPill('Week 10-12', () {
                              setState(() => _selectedWeeks = availableWeeks.where((w) => w >= 10 && w <= 12).toList());
                            }, _isPresetActive(availableWeeks, 10, 12)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // 3-column Grid of Week Cards
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: availableWeeks.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 2.1,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (context, index) {
                          final wk = availableWeeks[index];
                          final isSelected = _selectedWeeks.contains(wk);
                          final count = _questions.where((q) => q.weekNumber == wk).length;

                          return InkWell(
                            onTap: () {
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
                            borderRadius: BorderRadius.circular(12),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.primarySoft : AppColors.background,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected ? AppColors.primary : AppColors.border,
                                  width: isSelected ? 1.5 : 1.0,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    isSelected ? Icons.check_circle : Icons.circle_outlined,
                                    size: 15,
                                    color: isSelected ? AppColors.primary : AppColors.textSubtle,
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Week $wk',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: isSelected ? AppColors.primary : AppColors.textDark,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          count > 0 ? '$count Qs' : '0 Qs',
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: isSelected ? AppColors.primaryDark : AppColors.textMuted,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),

                      // 3. TEST ENVIRONMENT
                      const Text(
                        '3. TEST ENVIRONMENT',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          color: AppColors.textMuted,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Builder(builder: (ctx) {
                        final isCompact = MediaQuery.of(ctx).size.width < 500;
                        final practiceCard = _buildModeSelector(
                          title: 'Practice Mode',
                          description: 'Instant feedback, explanations, and hints after each question.',
                          icon: Icons.auto_awesome_outlined,
                          isSelected: _mode == 'practice',
                          onTap: () => setState(() => _mode = 'practice'),
                        );
                        final examCard = _buildModeSelector(
                          title: 'Exam Mode',
                          description: 'Timed exam conditions, no feedback until completion.',
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

                      // 4. QUESTION COUNT
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '4. QUESTION COUNT',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                              color: AppColors.textMuted,
                            ),
                          ),
                          Text(
                            '$availableCount Qs available',
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
                            label: Text(opt == 'all' ? 'All ($availableCount)' : '$opt Qs'),
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

                      // Time Limit (for Exam Mode)
                      if (_mode == 'exam') ...[
                        const Text(
                          'TIME LIMIT',
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
              // Bottom action bar
              Row(
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.textMuted,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    child: const Text(
                      'CANCEL',
                      style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FilledButton(
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
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _isLoading ? 'LOADING...' : 'START TEST SIMULATION',
                            style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward, size: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isPresetActive(List<int> availableWeeks, int start, int end) {
    final expected = availableWeeks.where((w) => w >= start && w <= end).toList();
    if (expected.isEmpty || _selectedWeeks.length != expected.length) return false;
    return expected.every((w) => _selectedWeeks.contains(w));
  }

  Widget _buildPresetPill(String label, VoidCallback onTap, bool isActive) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isActive ? AppColors.primary : AppColors.border),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : AppColors.textDark,
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
