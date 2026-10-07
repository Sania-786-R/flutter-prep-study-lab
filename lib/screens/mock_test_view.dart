import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_study_lab/core/constants/app_constants.dart';
import 'package:prep_study_lab/models/models.dart';
import 'package:prep_study_lab/services/test_service.dart';

class MockTestView extends StatefulWidget {
  final ActiveTestSessionModel session;
  final UserModel? currentUser;
  final Function(MockAttemptModel) onFinishTest;
  final VoidCallback onExitTest;
  final TestService testService;

  const MockTestView({
    super.key,
    required this.session,
    required this.currentUser,
    required this.onFinishTest,
    required this.onExitTest,
    required this.testService,
  });

  @override
  State<MockTestView> createState() => _MockTestViewState();
}

class _MockTestViewState extends State<MockTestView> {
  late ActiveTestSessionModel _session;
  Timer? _timer;
  bool _isPaletteOpen = false;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _session = widget.session;
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;

      setState(() {
        _session.secondsElapsed++;
        if (_session.secondsRemaining != null) {
          _session.secondsRemaining = _session.secondsRemaining! - 1;
          if (_session.secondsRemaining! <= 0) {
            _timer?.cancel();
            _autoSubmit();
            return;
          }
        }
        if (_session.items.isNotEmpty && _session.currentIndex < _session.items.length) {
          _session.items[_session.currentIndex].timeSpentSeconds++;
        }
      });

      // Auto-save periodically
      if (_session.secondsElapsed % 5 == 0) {
        widget.testService.saveActiveSession(_session, widget.currentUser?.id);
      }
    });
  }

  Future<void> _autoSubmit() async {
    if (_isSubmitting) return;
    setState(() => _isSubmitting = true);
    final res = await widget.testService.submitAttempt(_session, widget.currentUser);
    if (res['success'] == true && res['attempt'] != null) {
      widget.onFinishTest(res['attempt'] as MockAttemptModel);
    }
  }

  Future<void> _manualSubmit() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        final answered = _session.items.where((i) => i.selectedOptionIndex != null).length;
        final unanswered = _session.items.length - answered;
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: const Text('Submit Examination?', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('You have answered $answered of ${_session.items.length} questions.'),
              if (unanswered > 0) ...[
                const SizedBox(height: 8),
                Text(
                  '$unanswered questions remain unanswered.',
                  style: const TextStyle(color: AppColors.error, fontWeight: FontWeight.bold),
                ),
              ],
              const SizedBox(height: 12),
              const Text('Are you sure you want to finish and record your test attempt?'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Review Answers'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
              child: const Text('Confirm & Finish'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      _timer?.cancel();
      setState(() => _isSubmitting = true);
      final res = await widget.testService.submitAttempt(_session, widget.currentUser);
      if (res['success'] == true && res['attempt'] != null) {
        widget.onFinishTest(res['attempt'] as MockAttemptModel);
      }
    }
  }

  String _formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    final h = m ~/ 60;
    if (h > 0) {
      final remM = m % 60;
      return '$h:${remM.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
    }
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    if (_session.items.isEmpty) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.info_outline, size: 48, color: AppColors.primary),
              const SizedBox(height: 16),
              const Text('No questions available in this test configuration.'),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: widget.onExitTest,
                child: const Text('Back to Dashboard'),
              ),
            ],
          ),
        ),
      );
    }

    final isExam = _session.config.mode == 'exam';
    final currentItem = _session.items[_session.currentIndex];
    final answeredCount = _session.items.where((i) => i.selectedOptionIndex != null).length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 16,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: isExam ? AppColors.errorSoft : AppColors.primarySoft,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isExam ? AppColors.error.withValues(alpha: 0.3) : AppColors.border),
              ),
              child: Row(
                children: [
                  Icon(isExam ? Icons.shield_outlined : Icons.auto_awesome, size: 14, color: isExam ? AppColors.error : AppColors.primary),
                  const SizedBox(width: 6),
                  Text(
                    isExam ? 'EXAM MODE' : 'PRACTICE MODE',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                      color: isExam ? AppColors.error : AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _session.config.courseName,
                style: const TextStyle(fontSize: 13, color: AppColors.textMuted),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          // Timer
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primarySoft,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.timer_outlined,
                  size: 16,
                  color: isExam && _session.secondsRemaining != null && _session.secondsRemaining! <= 180
                      ? AppColors.error
                      : AppColors.primary,
                ),
                const SizedBox(width: 6),
                Text(
                  isExam && _session.secondsRemaining != null
                      ? _formatTime(_session.secondsRemaining!)
                      : _formatTime(_session.secondsElapsed),
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isExam && _session.secondsRemaining != null && _session.secondsRemaining! <= 180
                        ? AppColors.error
                        : AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Palette drawer toggle
          IconButton(
            icon: const Icon(Icons.grid_view, color: AppColors.textMuted),
            tooltip: 'Question Palette',
            onPressed: () => setState(() => _isPaletteOpen = !_isPaletteOpen),
          ),

          // Finish Test
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: OutlinedButton(
              onPressed: _manualSubmit,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.error,
                side: const BorderSide(color: AppColors.border),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text('FINISH TEST', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Question Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'QUESTION ${_session.currentIndex + 1} OF ${_session.items.length}',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        color: AppColors.primary,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          currentItem.isMarkedForReview = !currentItem.isMarkedForReview;
                        });
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: currentItem.isMarkedForReview ? AppColors.warningSoft : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: currentItem.isMarkedForReview ? AppColors.warning : AppColors.border,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              currentItem.isMarkedForReview ? Icons.bookmark : Icons.bookmark_border,
                              size: 16,
                              color: currentItem.isMarkedForReview ? AppColors.warning : AppColors.textMuted,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              currentItem.isMarkedForReview ? 'Marked for Review' : 'Mark for Review',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: currentItem.isMarkedForReview ? AppColors.warning : AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Question Text
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentItem.questionText,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 22,
                            fontWeight: FontWeight.normal,
                            color: AppColors.textDark,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Options
                        ...List.generate(currentItem.displayedOptions.length, (optIdx) {
                          final optText = currentItem.displayedOptions[optIdx];
                          final letter = String.fromCharCode(65 + optIdx);
                          final isSelected = currentItem.selectedOptionIndex == optIdx;
                          final hasAnswered = currentItem.selectedOptionIndex != null;
                          final isOptionCorrect = currentItem.correctOptionIndex == optIdx;

                          Color containerColor = Colors.white;
                          Color borderColor = AppColors.border;
                          Widget? statusBadge;

                          if (isExam) {
                            // Exam Mode: Strictly neutral selection
                            if (isSelected) {
                              containerColor = AppColors.primarySoft;
                              borderColor = AppColors.primary;
                            }
                          } else {
                            // Practice Mode: Immediate correct/wrong feedback
                            if (hasAnswered) {
                              if (isOptionCorrect) {
                                containerColor = AppColors.successSoft;
                                borderColor = AppColors.success;
                                statusBadge = Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.success,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text('CORRECT', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                );
                              } else if (isSelected) {
                                containerColor = AppColors.errorSoft;
                                borderColor = AppColors.error;
                                statusBadge = Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.error,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text('WRONG', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                );
                              }
                            } else if (isSelected) {
                              containerColor = AppColors.primarySoft;
                              borderColor = AppColors.primary;
                            }
                          }

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  if (currentItem.selectedOptionIndex == optIdx) {
                                    currentItem.selectedOptionIndex = null;
                                  } else {
                                    currentItem.selectedOptionIndex = optIdx;
                                  }
                                });
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: containerColor,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: borderColor, width: isSelected ? 1.5 : 1.0),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: isSelected ? AppColors.primary : AppColors.background,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: isSelected ? AppColors.primary : AppColors.border),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        letter,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: isSelected ? Colors.white : AppColors.textMuted,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Text(
                                        optText,
                                        style: const TextStyle(fontSize: 14, color: AppColors.textDark),
                                      ),
                                    ),
                                    ?statusBadge,
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),

                        // Practice Mode Explanation / Hints Banner
                        if (!isExam && currentItem.selectedOptionIndex != null) ...[
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: currentItem.isCorrect ? AppColors.successSoft : AppColors.errorSoft,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: currentItem.isCorrect ? AppColors.success.withValues(alpha: 0.3) : AppColors.error.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      currentItem.isCorrect ? Icons.check_circle : Icons.cancel,
                                      size: 18,
                                      color: currentItem.isCorrect ? AppColors.success : AppColors.error,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      currentItem.isCorrect ? 'Correct Answer!' : 'Incorrect Answer',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: currentItem.isCorrect ? AppColors.success : AppColors.error,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                                if (currentItem.explanation != null && currentItem.explanation!.isNotEmpty) ...[
                                  const SizedBox(height: 8),
                                  Text(
                                    currentItem.explanation!,
                                    style: const TextStyle(fontSize: 12, color: AppColors.textDark, height: 1.4),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                // Bottom Navigation controls
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton.icon(
                      onPressed: _session.currentIndex > 0
                          ? () => setState(() => _session.currentIndex--)
                          : null,
                      icon: const Icon(Icons.arrow_back, size: 16),
                      label: const Text('PREVIOUS'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${_session.currentIndex + 1} / ${_session.items.length}',
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                    FilledButton.icon(
                      onPressed: _session.currentIndex < _session.items.length - 1
                          ? () => setState(() => _session.currentIndex++)
                          : _manualSubmit,
                      icon: Icon(
                        _session.currentIndex < _session.items.length - 1
                            ? Icons.arrow_forward
                            : Icons.check,
                        size: 16,
                      ),
                      label: Text(
                        _session.currentIndex < _session.items.length - 1 ? 'NEXT' : 'SUBMIT',
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Palette Side Drawer
          if (_isPaletteOpen)
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              width: 280,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  border: Border(left: BorderSide(color: AppColors.border)),
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 20),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'QUESTION PALETTE',
                          style: GoogleFonts.jetBrainsMono(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textMuted),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, size: 18),
                          onPressed: () => setState(() => _isPaletteOpen = false),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text('$answeredCount of ${_session.items.length} Answered', style: const TextStyle(fontSize: 12, color: AppColors.textDark, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: _session.items.length,
                        itemBuilder: (context, idx) {
                          final it = _session.items[idx];
                          final isAnswered = it.selectedOptionIndex != null;
                          final isCurrent = idx == _session.currentIndex;
                          final isMarked = it.isMarkedForReview;

                          Color bgColor = AppColors.background;
                          Color textColor = AppColors.textDark;

                          if (isCurrent) {
                            bgColor = AppColors.primary;
                            textColor = Colors.white;
                          } else if (isAnswered) {
                            bgColor = AppColors.primarySoft;
                            textColor = AppColors.primary;
                          }

                          return InkWell(
                            onTap: () {
                              setState(() {
                                _session.currentIndex = idx;
                                _isPaletteOpen = false;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: isMarked ? AppColors.warning : AppColors.border,
                                  width: isMarked ? 2.0 : 1.0,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${idx + 1}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
