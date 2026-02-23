import 'package:flutter/material.dart';
import 'package:usecar_ki_system/routes/app_route_name.dart';
import 'package:usecar_ki_system/shared/widgets/nav_link.dart' show NavLink;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  
  final VoidCallback? onHelp; // Hilfe-Button Callback
  final VoidCallback? onProfile; // Profil-Button Callback

  const CustomAppBar({
    super.key,
    this.onHelp,
    this.onProfile,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,

      /// ---------- TITLE AREA ----------
      title: Row(
        children: [
          Image.asset(
            'assets/images/logo_sfm.png',
            height: 36,
          ),

          const SizedBox(width: 24),

          const _NavItems(),
        ],
      ),

      /// ---------- ACTIONS ----------
      actions: [
        IconButton(
          icon: const Icon(Icons.help_outline, color: Colors.black87),
          onPressed: onHelp,
        ),
        IconButton(
          icon: const Icon(Icons.person_outline, color: Colors.black87),
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
    return Row(
      children: const [
        NavLink(
          label: 'Predict Use Case',
          routeName: predictCarRouterName,
        ),
        SizedBox(width: 20),
        NavLink(
          label: 'Car Recommendation',
          routeName: recommandRouterName,
        ),
      ],
    );
  }
}
