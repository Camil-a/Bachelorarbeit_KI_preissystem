import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:usecar_ki_system/shared/constants/colors.dart';
import 'package:usecar_ki_system/shared/constants/sizes.dart';

class NavLink extends StatelessWidget {
  final String label;
  final String routeName;

  const NavLink({super.key, required this.label, required this.routeName});

  @override
  Widget build(BuildContext context) {
    final current = GoRouterState.of(context).name;
    final isActive = current == routeName;

    return InkWell(
      onTap: () => context.go(routeName),
      borderRadius: BorderRadius.circular(Sizes.radiusSmall),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? AppColors.primary : AppColors.sectionLabel,
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(height: 4),
            // Animated bottom indicator — grows when active
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              height: 2,
              width: isActive ? 28.0 : 0.0,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(Sizes.radiusTick),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
