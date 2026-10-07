import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prep_study_lab/core/constants/app_constants.dart';
import 'package:prep_study_lab/models/models.dart';
import 'package:prep_study_lab/services/test_service.dart';

class TestsView extends StatelessWidget {
  final UserModel? currentUser;
  final List<MockAttemptModel> attempts;
  final ActiveTestSessionModel? activeSession;
  final UserProgressModel progress;
  final VoidCallback onOpenConfig;
  final VoidCallback onOpenAuth;
  final Function(ActiveTestSessionModel) onResumeTest;
  final Function(MockAttemptModel) onViewAttemptResult;
  final Function(MockAttemptModel) onRetryAttemptWrong;

  const TestsView({
    super.key,
    required this.currentUser,
    required this.attempts,
    required this.activeSession,
    required this.progress,
    required this.onOpenConfig,
    required this.onOpenAuth,
    required this.onResumeTest,
    required this.onViewAttemptResult,
    required this.onRetryAttemptWrong,
  });

  String _formatDuration(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m}m ${s}s';
  }

  String _formatDate(String isoString) {
    try {
      final dt = DateTime.parse(isoString);
      return DateFormat('MMM d, y • h:mm a').format(dt);
    } catch (_) {
      return isoString;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 64.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primarySoft,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Icon(Icons.description_outlined, size: 36, color: AppColors.primary),
              ),
              const SizedBox(height: 20),
              Text(
                'AUTHENTICATION REQUIRED',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Personal Dashboard',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 28,
                  fontWeight: FontWeight.normal,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Please sign in with your Registration Number to access your test history, review past attempts, and monitor individual accuracy metrics.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: AppColors.textMuted, height: 1.5),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: onOpenAuth,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('Sign In with Registration Number'),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 48),

          // Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ACADEMIC SUITE',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${currentUser!.name}'s Dashboard",
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 26,
                      fontWeight: FontWeight.normal,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'TEST DRILLS, HISTORICAL PLAYBACK, AND INDIVIDUAL ACCURACY',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 10,
                      color: AppColors.textMuted,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
              FilledButton.icon(
                onPressed: onOpenConfig,
                icon: const Icon(Icons.tune, size: 16),
                label: const Text('NEW TEST'),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Performance Metrics Grid
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildMetricCard('Tests Taken', '${progress.testsCompleted}', 'Completed sessions', Icons.description_outlined, AppColors.primary),
              _buildMetricCard('Attempted', '${progress.totalAttempted}', 'Questions answered', Icons.track_changes, AppColors.primary),
              _buildMetricCard('Correct', '${progress.totalCorrect}', 'Confirmed answers', Icons.check_circle_outline, AppColors.success),
              _buildMetricCard('Accuracy', '${progress.accuracy}%', 'Overall rate', Icons.trending_up, AppColors.primary),
              _buildMetricCard('Best Score', '${progress.bestScore}', 'Top marks reached', Icons.emoji_events_outlined, AppColors.warning),
            ],
          ),
          const SizedBox(height: 24),

          // Resume Incomplete Session Banner (if present)
          if (activeSession != null) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primarySoft,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.primaryLight.withValues(alpha: 0.6)),
                boxShadow: [
                  BoxShadow(color: AppColors.primary.withValues(alpha: 0.08), blurRadius: 16),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.play_arrow, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'INCOMPLETE TEST SESSION DETECTED',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary),
                        ),
                        Text(
                          '${activeSession!.config.courseName} • Question ${activeSession!.currentIndex + 1} of ${activeSession!.items.length}',
                          style: const TextStyle(fontSize: 12, color: AppColors.textDark),
                        ),
                      ],
                    ),
                  ),
                  FilledButton.icon(
                    onPressed: () => onResumeTest(activeSession!),
                    icon: const Icon(Icons.arrow_forward, size: 14),
                    label: const Text('RESUME'),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],

          // Recorded Attempts
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'RECORDED ATTEMPTS (${attempts.length})',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: AppColors.textMuted,
                ),
              ),
              Text(
                'STRICT PLAYBACK OF DISPLAYED OPTION ORDER',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 10,
                  color: AppColors.textSubtle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          if (attempts.isEmpty) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(36),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  const Icon(Icons.description_outlined, size: 40, color: AppColors.primaryLight),
                  const SizedBox(height: 12),
                  const Text('No Previous Test Attempts', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 6),
                  const Text(
                    'Launch a practice or exam simulation to test your mastery.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: onOpenConfig,
                    style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
                    child: const Text('Start First Test'),
                  ),
                ],
              ),
            ),
          ] else ...[
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: attempts.length,
              separatorBuilder: (context, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final att = attempts[index];
                final isExam = att.mode == 'exam';
                final hasWrongs = att.wrongCount > 0;

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border),
                    boxShadow: [
                      BoxShadow(color: AppColors.primary.withValues(alpha: 0.03), blurRadius: 10),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: isExam ? AppColors.errorSoft : AppColors.primarySoft,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: isExam ? AppColors.error.withValues(alpha: 0.3) : AppColors.border),
                                  ),
                                  child: Text(
                                    att.mode.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: isExam ? AppColors.error : AppColors.primary,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _formatDate(att.completedAt),
                                  style: GoogleFonts.jetBrainsMono(fontSize: 11, color: AppColors.textMuted),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              att.courseName,
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark),
                            ),
                            const SizedBox(height: 6),
                            Wrap(
                              spacing: 12,
                              children: [
                                Text('${att.correctCount} Correct', style: const TextStyle(fontSize: 11, color: AppColors.success, fontWeight: FontWeight.w600)),
                                Text('${att.wrongCount} Wrong', style: const TextStyle(fontSize: 11, color: AppColors.error, fontWeight: FontWeight.w600)),
                                Text(_formatDuration(att.timeTakenSeconds), style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: '${att.score}',
                              style: GoogleFonts.playfairDisplay(fontSize: 24, fontWeight: FontWeight.normal, color: AppColors.textDark),
                              children: [
                                TextSpan(text: ' / ${att.totalQuestions}', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textMuted)),
                              ],
                            ),
                          ),
                          Text(
                            '${att.percentage}%',
                            style: GoogleFonts.jetBrainsMono(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: att.percentage >= 75 ? AppColors.primary : AppColors.warning,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              if (hasWrongs) ...[
                                IconButton(
                                  icon: const Icon(Icons.refresh, size: 18, color: AppColors.error),
                                  onPressed: () => onRetryAttemptWrong(att),
                                  tooltip: 'Retry incorrect questions',
                                  visualDensity: VisualDensity.compact,
                                ),
                              ],
                              OutlinedButton.icon(
                                onPressed: () => onViewAttemptResult(att),
                                icon: const Icon(Icons.visibility_outlined, size: 14),
                                label: const Text('RESULT'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.primary,
                                  side: const BorderSide(color: AppColors.border),
                                  visualDensity: VisualDensity.compact,
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
          const SizedBox(height: 48),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, String subtitle, IconData icon, Color color) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
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
              Text(title.toUpperCase(), style: GoogleFonts.jetBrainsMono(fontSize: 9, color: AppColors.textMuted, fontWeight: FontWeight.w600)),
              Icon(icon, size: 16, color: color),
            ],
          ),
          const SizedBox(height: 8),
          Text(value, style: GoogleFonts.playfairDisplay(fontSize: 24, color: color, fontWeight: FontWeight.normal)),
          const SizedBox(height: 4),
          Text(subtitle, style: GoogleFonts.jetBrainsMono(fontSize: 9, color: AppColors.textSubtle)),
        ],
      ),
    );
  }
}
