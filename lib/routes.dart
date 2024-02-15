import 'package:flutter/material.dart';
import 'package:g_pass/screens/home/home.dart';
import 'package:g_pass/screens/settings/settings_screen.dart';
import 'package:g_pass/screens/splash/splash_screen.dart';
import 'package:g_pass/screens/user/sign_in.dart';
import 'package:g_pass/screens/user/sign_up.dart';

class Routes {
  Routes._(); //this is to prevent anyone from instantiate this object

  static const String home = '/home';
  static const String login = '/login';
  static const String splash = '/splash';
  static const String setting = '/setting';
  static const String register = '/register';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => const SplashScreen(),
    home: (BuildContext context) => const HomeScreen(),
    login: (BuildContext context) => const SignInScreen(),
    register: (BuildContext context) => const RegisterScreen(),
    setting: (BuildContext context) => const SettingScreen(),
  };
}
