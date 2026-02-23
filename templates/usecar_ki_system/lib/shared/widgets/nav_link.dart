

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavLink extends StatelessWidget {
  final String label;
  final String routeName;

  const NavLink({
    super.key,
    required this.label,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    final current = GoRouterState.of(context).name;
    final isActive = current == routeName;

    return TextButton(
      onPressed: () => context.go(routeName),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.blue : Colors.black,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          decoration:
              isActive ? TextDecoration.underline : TextDecoration.none,
        ),
      ),
    );
  }
}
