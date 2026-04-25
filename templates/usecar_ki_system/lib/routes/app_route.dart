
import 'package:usecar_ki_system/home.dart';
import 'package:usecar_ki_system/routes/app_route_name.dart';
import '../features/recommand_system/recommand_system.dart';
import 'package:go_router/go_router.dart';




GoRouter appRouter = GoRouter(
  initialLocation: '/predictcar',
  routes: <RouteBase>[

  ///signin
    GoRoute(
      path: '/predictcar',
      name: predictCarRouterName,
      builder: (context, state) => const CarSalesFormPages(),
    ),

    ///register
    // GoRoute(
    //   path: '/recommand',
    //   name: recommandRouterName,
    //   builder: (context, state) => const RecommandSystemScreen(),
    // ),

   ///car
    GoRoute(
      path: '/recommand',
      name: recommandRouterName,
      builder: (context, state) => const RecommandCarApp(),
    ),
  
  ],
);
