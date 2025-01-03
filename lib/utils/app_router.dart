import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/utils/app_routes.dart';
import 'package:shop_online/view_models/prudact_details_cubit/prudact_details_cubit.dart';
import 'package:shop_online/views/pages/checkout_page.dart';
import 'package:shop_online/views/pages/custtom_bottom_navBar.dart';
import 'package:shop_online/views/pages/prudact_details_page.dart';

class AppRouter {
  static Route<dynamic> onGenariteRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homeRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => CusttomBottomNavbarPage(),
        );
      case AppRoutes.checkoutRour:
        return MaterialPageRoute(
          builder: (_) => CheckoutPage(),
          settings: settings,
        );
      case AppRoutes.prudactaDetailsRoute:
        final String prudactId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = PrudactDetailsCubit();
              cubit.getPrudactDetails(prudactId);
              return cubit;
            },
            child: PrudactDetailsPage(
              prudactId: prudactId,
            ),
          ),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'No Route defined for ${settings.name}',
              ),
            ),
          ),
        );
    }
  }
}
