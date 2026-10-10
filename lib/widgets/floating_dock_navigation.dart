import 'package:flutter/material.dart';
import 'package:prep_study_lab/core/constants/app_constants.dart';
import 'package:prep_study_lab/models/models.dart';

class FloatingDockNavigation extends StatelessWidget {
  final int activeIndex;
  final Function(int) onTabSelected;
  final UserModel? currentUser;
  final VoidCallback onOpenAuth;
  final VoidCallback onLogout;
  final VoidCallback? onNameClick;

  const FloatingDockNavigation({
    super.key,
    required this.activeIndex,
    required this.onTabSelected,
    required this.currentUser,
    required this.onOpenAuth,
    required this.onLogout,
    this.onNameClick,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isCompact = screenWidth < 600;

    final navItems = [
      {'label': 'Home', 'icon': Icons.home_outlined, 'activeIcon': Icons.home},
      {'label': 'Tests', 'icon': Icons.description_outlined, 'activeIcon': Icons.description},
      {'label': 'Courses', 'icon': Icons.menu_book_outlined, 'activeIcon': Icons.menu_book},
      {'label': 'Progress', 'icon': Icons.bar_chart_outlined, 'activeIcon': Icons.bar_chart},
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 12.0, right: 12.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(50.0),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...List.generate(navItems.length, (index) {
                  final item = navItems[index];
                  final isSelected = activeIndex == index;
                  return InkWell(
                    onTap: () => onTabSelected(index),
                    borderRadius: BorderRadius.circular(40),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(
                        horizontal: isCompact ? 9.0 : 14.0,
                        vertical: 7.0,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primarySoft : Colors.transparent,
                        borderRadius: BorderRadius.circular(40),
                        border: isSelected ? Border.all(color: AppColors.primaryLight.withValues(alpha: 0.5)) : null,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isSelected ? item['activeIcon'] as IconData : item['icon'] as IconData,
                            size: 18,
                            color: isSelected ? AppColors.primary : AppColors.textMuted,
                          ),
                          if (isSelected && !isCompact) ...[
                            const SizedBox(width: 6),
                            Text(
                              item['label'] as String,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }),
                Container(
                  height: 20,
                  width: 1,
                  color: AppColors.border,
                  margin: const EdgeInsets.symmetric(horizontal: 6.0),
                ),
                if (currentUser != null) ...[
                  InkWell(
                    onTap: onNameClick,
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.primarySoft,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(
                        currentUser!.name,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    icon: const Icon(Icons.logout, size: 16, color: AppColors.textMuted),
                    onPressed: onLogout,
                    tooltip: 'Sign Out',
                    visualDensity: VisualDensity.compact,
                  ),
                ] else ...[
                  if (isCompact)
                    InkWell(
                      onTap: onOpenAuth,
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primarySoft,
                          border: Border.all(color: AppColors.border),
                        ),
                        child: const Icon(Icons.person_outline, size: 16, color: AppColors.primary),
                      ),
                    )
                  else
                    FilledButton.icon(
                      onPressed: onOpenAuth,
                      icon: const Icon(Icons.person_outline, size: 14),
                      label: const Text(
                        'SIGN IN',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.8),
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        visualDensity: VisualDensity.compact,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
