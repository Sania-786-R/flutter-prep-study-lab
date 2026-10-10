import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_study_lab/core/constants/app_constants.dart';
import 'package:prep_study_lab/models/models.dart';

class ProgressView extends StatelessWidget {
  final UserModel? currentUser;
  final UserProgressModel progress;
  final VoidCallback onStartPracticing;
  final VoidCallback onOpenAuth;

  const ProgressView({
    super.key,
    required this.currentUser,
    required this.progress,
    required this.onStartPracticing,
    required this.onOpenAuth,
  });

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Center(
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
                  child: const Icon(Icons.bar_chart_outlined, size: 36, color: AppColors.primary),
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
                  'Performance Analytics',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 28,
                    fontWeight: FontWeight.normal,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Please sign in with your Registration Number to view your module-by-module accuracy, longitudinal progress matrix, and performance insights.',
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
        ),
      );
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 768;

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 32.0 : 16.0,
        vertical: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDesktop) const SizedBox(height: 52),

          // Header
          Text(
            'PERFORMANCE INTELLIGENCE',
            style: GoogleFonts.jetBrainsMono(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "${currentUser!.name}'s Progress & Analytics",
            style: GoogleFonts.playfairDisplay(
              fontSize: isDesktop ? 28 : 22,
              fontWeight: FontWeight.normal,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'LONGITUDINAL ACCURACY TRACKING AND MODULE-BY-MODULE MASTERY',
            style: GoogleFonts.jetBrainsMono(
              fontSize: 10,
              color: AppColors.textMuted,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 20),

          // Hero Stats Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final avail = constraints.maxWidth;
              final cardWidth = avail > 700
                  ? (avail - 36) / 4
                  : (avail > 360
                      ? (avail - 12) / 2
                      : avail);

              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildProgressHeroCard('Questions Attempted', '${progress.totalAttempted}', 'Across ${progress.testsCompleted} sessions', Icons.track_changes, AppColors.primary, cardWidth),
                  _buildProgressHeroCard('Overall Accuracy', '${progress.accuracy}%', '${progress.totalCorrect} correct answers', Icons.trending_up, AppColors.success, cardWidth),
                  _buildProgressHeroCard('Total Tests', '${progress.testsCompleted}', '${progress.examCompleted} Exam / ${progress.practiceCompleted} Practice', Icons.emoji_events_outlined, AppColors.warning, cardWidth),
                  _buildProgressHeroCard('Best Score', '${progress.bestScore}', 'Top individual result', Icons.auto_awesome_outlined, AppColors.primary, cardWidth),
                ],
              );
            },
          ),
          const SizedBox(height: 28),

          // Week-wise Performance Matrix
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 4,
            children: [
              Text(
                'WEEK-WISE PROGRESS MATRIX',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: AppColors.textMuted,
                ),
              ),
              Text(
                'MODULE ACCURACY BREAKDOWN',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 10,
                  color: AppColors.textSubtle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          if (progress.weekWise.isEmpty) ...[
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
                  const Icon(Icons.bar_chart_outlined, size: 40, color: AppColors.primaryLight),
                  const SizedBox(height: 12),
                  const Text('No Weekly Activity Recorded Yet', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 6),
                  const Text(
                    'Start practicing or testing questions to populate your week-by-week competency indicators.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: onStartPracticing,
                    style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
                    child: const Text('Launch Simulation'),
                  ),
                ],
              ),
            ),
          ] else ...[
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: progress.weekWise.length,
              separatorBuilder: (context, _) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final wk = progress.weekWise[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primarySoft,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Text(
                          'WEEK ${wk.week}',
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              wk.courseName,
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${wk.attempted} Attempted • ${wk.correct} Correct',
                              style: GoogleFonts.jetBrainsMono(fontSize: 11, color: AppColors.textMuted),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${wk.accuracy}%',
                            style: GoogleFonts.jetBrainsMono(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: wk.accuracy >= 75
                                  ? AppColors.primary
                                  : (wk.accuracy >= 50 ? AppColors.warning : AppColors.error),
                            ),
                          ),
                          const SizedBox(height: 4),
                          SizedBox(
                            width: 80,
                            child: LinearProgressIndicator(
                              value: (wk.accuracy / 100).clamp(0.0, 1.0),
                              backgroundColor: AppColors.border,
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(4),
                              minHeight: 5,
                            ),
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

  Widget _buildProgressHeroCard(String title, String value, String subtitle, IconData icon, Color color, double width) {
    return Container(
      width: width,
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
              Expanded(
                child: Text(
                  title.toUpperCase(),
                  style: GoogleFonts.jetBrainsMono(fontSize: 10, color: AppColors.textMuted, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 4),
              Icon(icon, size: 18, color: color),
            ],
          ),
          const SizedBox(height: 10),
          Text(value, style: GoogleFonts.playfairDisplay(fontSize: 26, color: color, fontWeight: FontWeight.normal)),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.jetBrainsMono(fontSize: 10, color: AppColors.textSubtle),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
