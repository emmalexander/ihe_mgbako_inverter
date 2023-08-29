import 'package:flutter/material.dart';
import 'package:ihe_mgbako_inverter/screens/backup_calculator.dart';
import 'package:ihe_mgbako_inverter/screens/load_calculator_screen.dart';
import 'package:ihe_mgbako_inverter/screens/modes_screen.dart';
import 'package:ihe_mgbako_inverter/screens/splash_screen.dart';
import 'package:ihe_mgbako_inverter/screens/summary_screen.dart';
import 'package:ihe_mgbako_inverter/screens/welcome_screen.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    /* '/': (context) => const SplashScreen(),*/
    '/': (context) => const WelcomeScreen(),
    '/modes': (context) => const ModesScreen(),
    '/loadCalculator': (context) => const LoadCalculatorScreen(),
    '/summary': (context) => const SummaryScreen(),
    '/backupCalculator': (context) => const BackupCalculatorScreen(),
  };
}
