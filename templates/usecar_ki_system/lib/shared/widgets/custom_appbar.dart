import 'package:flutter/material.dart';
import 'package:usecar_ki_system/routes/app_route_name.dart';
import 'package:usecar_ki_system/shared/constants/colors.dart';
import 'package:usecar_ki_system/shared/widgets/nav_link.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onHelp;
  final VoidCallback? onProfile;

  const CustomAppBar({super.key, this.onHelp, this.onProfile});

  // Extra 1 px for the bottom divider
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBarBackground,
      elevation: 0,
      centerTitle: false,
      surfaceTintColor: Colors.transparent,

      // Subtle separator between AppBar and page content
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(
          height: 1,
          thickness: 1,
          color: AppColors.sectionDivider,
        ),
      ),

      // ── Logo + Nav tabs ──────────────────────────────────────────────────
      title: Row(
        children: [
          Image.asset('assets/images/logo_sfm.png', height: 34),
          
          const SizedBox(width: 28),
          // const Flexible(child: _NavItems()),

             Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: _NavItems(),
      ),
    ),
        ],
      ),

      // ── Action icons ─────────────────────────────────────────────────────
      actions: [
        IconButton(
          tooltip: 'Help',
          icon: const Icon(Icons.help_outline, size: 22),
          color: AppColors.sectionLabel,
          onPressed: onHelp,
        ),
        IconButton(
          tooltip: 'Profile',
          icon: const Icon(Icons.person_outline, size: 22),
          color: AppColors.sectionLabel,
          onPressed: onProfile,
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}

class _NavItems extends StatelessWidget {
  const _NavItems();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        NavLink(label: 'Predict Use Case',   routeName: predictCarRouterName),
        SizedBox(width: 4),
        NavLink(label: 'Car Recommendation', routeName: recommandRouterName),
      ],
    );
  }
}
