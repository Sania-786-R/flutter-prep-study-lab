import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_study_lab/core/constants/app_constants.dart';

class HeroView extends StatelessWidget {
  final VoidCallback onStartPracticing;
  final VoidCallback onViewTests;
  final int totalCourses;
  final int totalQuestions;
  final bool canInstallApp;
  final VoidCallback onInstallApp;
  final VoidCallback onDownloadApk;

  const HeroView({
    super.key,
    required this.onStartPracticing,
    required this.onViewTests,
    required this.totalCourses,
    required this.totalQuestions,
    required this.canInstallApp,
    required this.onInstallApp,
    required this.onDownloadApk,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48.0 : 20.0,
        vertical: 32.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 48),

          // Optional Install App Banner when in web browser
          if (canInstallApp) ...[
            Container(
              margin: const EdgeInsets.only(bottom: 24),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.primarySoft,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColors.primaryLight.withValues(alpha: 0.5)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 8,
                children: [
                  const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.get_app_rounded, color: AppColors.primary, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Install Prep Study Lab App for instant access',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryDark,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FilledButton(
                        onPressed: onInstallApp,
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          visualDensity: VisualDensity.compact,
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: const Text('INSTALL APP', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton(
                        onPressed: onDownloadApk,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primaryDark,
                          visualDensity: VisualDensity.compact,
                          side: const BorderSide(color: AppColors.primaryLight),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: const Text('DOWNLOAD APK', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],

          // Brand Pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  AppConstants.appName.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.0,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Main Headline (Playfair Display)
          Text(
            'PREPARE',
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              fontSize: isDesktop ? 64 : 38,
              fontWeight: FontWeight.normal,
              color: AppColors.textDark,
              letterSpacing: -0.5,
              height: 1.1,
            ),
          ),
          Text(
            'WITH PRECISION',
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              fontSize: isDesktop ? 64 : 38,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w300,
              color: AppColors.primary,
              letterSpacing: -0.5,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 18),

          // Subtitle
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 580),
            child: Text(
              AppConstants.subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: isDesktop ? 16 : 14,
                fontWeight: FontWeight.w300,
                color: AppColors.textMuted,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 36),

          // Action Buttons
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            runSpacing: 12,
            children: [
              FilledButton.icon(
                onPressed: onStartPracticing,
                icon: const Icon(Icons.arrow_outward, size: 16),
                label: const Text('START PRACTICING'),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 2,
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              OutlinedButton.icon(
                onPressed: onViewTests,
                icon: const Icon(Icons.menu_book_outlined, size: 16),
                label: const Text('BROWSE TESTS'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textDark,
                  side: const BorderSide(color: AppColors.border),
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),

          // Live Metadata / Course & Question Counts
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 24,
              runSpacing: 8,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.circle, size: 8, color: AppColors.primaryLight),
                    const SizedBox(width: 8),
                    Text(
                      '$totalCourses COURSES',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMuted,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
                Container(height: 12, width: 1, color: AppColors.border),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.circle, size: 8, color: AppColors.primaryLight),
                    const SizedBox(width: 8),
                    Text(
                      '$totalQuestions CURATED QUESTIONS',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMuted,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
                Container(height: 12, width: 1, color: AppColors.border),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.menu_book, size: 14, color: AppColors.primary),
                    const SizedBox(width: 6),
                    Text(
                      'EXAM SIMULATOR',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMuted,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 64),

          // Clean Academic Footer
          Container(
            padding: const EdgeInsets.only(top: 24),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppConstants.appName,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark,
                          ),
                        ),
                        const Text(
                          'Academic Performance Suite',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Text(
                          'Practice Suite',
                          style: TextStyle(fontSize: 11, color: AppColors.textMuted),
                        ),
                        SizedBox(width: 8),
                        Text('•', style: TextStyle(color: AppColors.textSubtle)),
                        SizedBox(width: 8),
                        Text(
                          'Exam Simulation',
                          style: TextStyle(fontSize: 11, color: AppColors.textMuted),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // Creator Signature Badge matching exact visual design
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: const Color(0xFFBAE6FD)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF38BDF8).withValues(alpha: 0.16),
                        blurRadius: 24,
                        offset: const Offset(0, 6),
                      ),
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.9),
                        blurRadius: 1,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'BUILD AND DEVELOPED BY',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2.2,
                              color: const Color(0xFF38BDF8),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'SANIA',
                            style: GoogleFonts.rubikWetPaint(
                              fontSize: 22,
                              color: const Color(0xFF38BDF8),
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.auto_awesome,
                            size: 14,
                            color: const Color(0xFFBAE6FD).withValues(alpha: 0.9),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
