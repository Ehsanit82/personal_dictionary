import 'package:flutter/material.dart';
import 'package:your_dictionary/src/presentation/detail_page/detail_screen.dart';
import 'package:your_dictionary/src/presentation/settings_page/settings_screen.dart';

import '../add_page/add_screen.dart';
import '../edit_page/edit_screen.dart';
import '../home/home_screen.dart';
import '../on_boarding/on_boarding_screen.dart';
import '../splash/splash_screen.dart';

class Routes {
  static const String splashRoute = '/';
  static const String onBoardingRoute = '/onBoarding';
  static const String homeRoute = '/home';
  static const String addWordRoute = '/add-word';
  static const String editWordRoute = '/edit-word';
  static const String wordDetailRoute = '/word-detail';
  static const String settingsRoute = '/settings';
}

class RouteGenerator {
  static Route getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => OnBoardingScreen());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case Routes.addWordRoute:
        return MaterialPageRoute(builder: (_) => AddScreen());
      case Routes.wordDetailRoute:
        return MaterialPageRoute(
            builder: (_) => const DetailScreen(),
            settings: RouteSettings(arguments: routeSettings.arguments));
      case Routes.editWordRoute:
        return MaterialPageRoute(
          builder: (_) => const EditWordScreen(),
          settings: RouteSettings(arguments: routeSettings.arguments),
        );
        case Routes.settingsRoute:
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }
}
