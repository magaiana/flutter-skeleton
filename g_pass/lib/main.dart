import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_pass/environment.dart';
import 'package:g_pass/my_app.dart';
import 'package:g_pass/providers/language_provider.dart';
import 'package:g_pass/providers/theme_provider.dart';
import 'package:g_pass/providers/user_provider.dart';
import 'package:g_pass/services/firestore_database.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    runApp(
      /*
      * MultiProvider for top services that do not depends on any runtime values
      * such as user uid/email.
       */
      MultiProvider(
        providers: [
          Provider<Environment>.value(value: Environment.dev),
          ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider(),
          ),
          ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider(),
          ),
          ChangeNotifierProvider<LanguageProvider>(
            create: (context) => LanguageProvider(),
          ),
        ],
        child: MainApp(
          databaseBuilder: (_, uid) => FirestoreDatabase(uid: uid),
          key: const Key('MainApp'),
        ),
      ),
    );
  });
}
