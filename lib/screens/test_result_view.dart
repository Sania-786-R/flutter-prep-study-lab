import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_study_lab/core/constants/app_constants.dart';
import 'package:prep_study_lab/models/models.dart';

class TestResultView extends StatefulWidget {
  final MockAttemptModel attempt;
  final Function(MockAttemptModel) onRetryWrong;
  final VoidCallback onBackToDashboard;

  const TestResultView({
    super.key,
    required this.attempt,
    required this.onRetryWrong,
    required this.onBackToDashboard,
  });

  @override
  State<TestResultView> createState() => _TestResultViewState();
}

class _TestResultViewState extends State<TestResultView> {
  String _filterMode = 'all'; // 'all', 'wrong', 'correct', 'unanswered'

  String _formatDuration(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m}m ${s}s';
  }

  @override
  Widget build(BuildContext context) {
    final att = widget.attempt;
    final hasWrongs = att.wrongCount > 0;

    final filteredItems = att.items.where((it) {
      final isAnswered = it.selectedOptionIndex != null;
      final isCorrect = isAnswered && it.selectedOptionIndex == it.correctOptionIndex;
      final isWrong = isAnswered && it.selectedOptionIndex != it.correctOptionIndex;

      if (_filterMode == 'correct') return isCorrect;
      if (_filterMode == 'wrong') return isWrong;
      if (_filterMode == 'unanswered') return !isAnswered;
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Assessment Result',
          style: GoogleFonts.playfairDisplay(fontSize: 18, color: AppColors.textDark),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: widget.onBackToDashboard,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Scorecard Panel
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(color: AppColors.primary.withValues(alpha: 0.05), blurRadius: 20),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primarySoft,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.border),
                    ),
                    child: const Icon(Icons.emoji_events_outlined, size: 36, color: AppColors.primary),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${att.mode.toUpperCase()} MODE COMPLETED',
                    style: GoogleFonts.jetBrainsMono(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    att.courseName,
                    style: GoogleFonts.playfairDisplay(fontSize: 20, color: AppColors.textDark),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  // Score Readout
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '${att.score}',
                        style: GoogleFonts.playfairDisplay(fontSize: 48, fontWeight: FontWeight.normal, color: AppColors.textDark),
                      ),
                      Text(
                        ' / ${att.totalQuestions}',
                        style: GoogleFonts.playfairDisplay(fontSize: 24, color: AppColors.textMuted),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primarySoft,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Text(
                      '${att.percentage}% ACCURACY',
                      style: GoogleFonts.jetBrainsMono(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Stats row
                  Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    spacing: 16,
                    runSpacing: 12,
                    children: [
                      _buildSummaryStat('Correct', '${att.correctCount}', Icons.check_circle_outline, AppColors.success),
                      _buildSummaryStat('Wrong', '${att.wrongCount}', Icons.cancel_outlined, AppColors.error),
                      _buildSummaryStat('Skipped', '${att.unansweredCount}', Icons.help_outline, AppColors.textMuted),
                      _buildSummaryStat('Duration', _formatDuration(att.timeTakenSeconds), Icons.timer_outlined, AppColors.primary),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Action Buttons
            LayoutBuilder(
              builder: (context, constraints) {
                final isNarrow = constraints.maxWidth < 420;
                final backButton = OutlinedButton.icon(
                  onPressed: widget.onBackToDashboard,
                  icon: const Icon(Icons.dashboard_outlined),
                  label: const Text('BACK TO DASHBOARD'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                );

                Widget? retryButton;
                if (hasWrongs) {
                  retryButton = FilledButton.icon(
                    onPressed: () => widget.onRetryWrong(att),
                    icon: const Icon(Icons.refresh),
                    label: const Text('RETRY WRONG'),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.error,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                  );
                }

                if (isNarrow) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      backButton,
                      if (retryButton != null) ...[
                        const SizedBox(height: 10),
                        retryButton,
                      ],
                    ],
                  );
                }

                return Row(
                  children: [
                    Expanded(child: backButton),
                    if (retryButton != null) ...[
                      const SizedBox(width: 12),
                      Expanded(child: retryButton),
                    ],
                  ],
                );
              },
            ),
            const SizedBox(height: 32),

            // Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ChoiceChip(
                    label: Text('All Questions (${att.items.length})'),
                    selected: _filterMode == 'all',
                    onSelected: (val) => setState(() => _filterMode = 'all'),
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: Text('Correct (${att.correctCount})'),
                    selected: _filterMode == 'correct',
                    onSelected: (val) => setState(() => _filterMode = 'correct'),
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: Text('Wrong (${att.wrongCount})'),
                    selected: _filterMode == 'wrong',
                    onSelected: (val) => setState(() => _filterMode = 'wrong'),
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: Text('Skipped (${att.unansweredCount})'),
                    selected: _filterMode == 'unanswered',
                    onSelected: (val) => setState(() => _filterMode = 'unanswered'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Question playback list
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredItems.length,
              separatorBuilder: (context, _) => const SizedBox(height: 12),
              itemBuilder: (context, idx) {
                final item = filteredItems[idx];
                final isAnswered = item.selectedOptionIndex != null;
                final isCorrect = isAnswered && item.selectedOptionIndex == item.correctOptionIndex;

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: !isAnswered
                          ? AppColors.border
                          : (isCorrect ? AppColors.success.withValues(alpha: 0.4) : AppColors.error.withValues(alpha: 0.4)),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'QUESTION ${item.questionIndex + 1}',
                            style: GoogleFonts.jetBrainsMono(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: !isAnswered
                                  ? AppColors.background
                                  : (isCorrect ? AppColors.successSoft : AppColors.errorSoft),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              !isAnswered ? 'SKIPPED' : (isCorrect ? 'CORRECT' : 'INCORRECT'),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: !isAnswered
                                    ? AppColors.textMuted
                                    : (isCorrect ? AppColors.success : AppColors.error),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(item.questionText, style: const TextStyle(fontSize: 14, color: AppColors.textDark)),
                      const SizedBox(height: 12),

                      // Display exact preserved option order
                      ...List.generate(item.displayedOptions.length, (optIdx) {
                        final letter = String.fromCharCode(65 + optIdx);
                        final isChosen = item.selectedOptionIndex == optIdx;
                        final isAnswer = item.correctOptionIndex == optIdx;

                        Color bg = AppColors.background;
                        Color border = AppColors.border;
                        if (isAnswer) {
                          bg = AppColors.successSoft;
                          border = AppColors.success;
                        } else if (isChosen && !isCorrect) {
                          bg = AppColors.errorSoft;
                          border = AppColors.error;
                        }

                        return Container(
                          margin: const EdgeInsets.only(bottom: 6),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          decoration: BoxDecoration(
                            color: bg,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: border),
                          ),
                          child: Row(
                            children: [
                              Text('$letter: ', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                              Expanded(
                                child: Text(item.displayedOptions[optIdx], style: const TextStyle(fontSize: 12)),
                              ),
                              if (isAnswer)
                                const Text('(Correct)', style: TextStyle(color: AppColors.success, fontSize: 11, fontWeight: FontWeight.bold)),
                              if (isChosen && !isCorrect)
                                const Text('(Your choice)', style: TextStyle(color: AppColors.error, fontSize: 11, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        );
                      }),

                      if (item.explanation != null && item.explanation!.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Explanation: ${item.explanation}',
                          style: const TextStyle(fontSize: 12, color: AppColors.textMuted, fontStyle: FontStyle.italic),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryStat(String title, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
        Text(title, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
      ],
    );
  }
}
