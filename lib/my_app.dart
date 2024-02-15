import 'package:flutter/material.dart';
import 'package:g_pass/app_localization.dart';
import 'package:g_pass/auth_wdget_builder.dart';
import 'package:g_pass/constants/app_themes.dart';
import 'package:g_pass/environment.dart';
import 'package:g_pass/models/user_model.dart';
import 'package:g_pass/providers/language_provider.dart';
import 'package:g_pass/providers/theme_provider.dart';
import 'package:g_pass/providers/user_provider.dart';
import 'package:g_pass/routes.dart';
import 'package:g_pass/screens/home/home.dart';
import 'package:g_pass/screens/user/sign_in.dart';
import 'package:g_pass/services/firestore_database.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MainApp extends StatelessWidget {
  const MainApp({required Key key, required this.databaseBuilder})
      : super(key: key);

  // Expose builders for 3rd party services at the root of the widget tree
  // This is useful when mocking services while testing
  final FirestoreDatabase Function(BuildContext context, String uid)
      databaseBuilder;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, themeProviderRef, __) {
        //{context, data, child}
        return Consumer<LanguageProvider>(
          builder: (_, languageProviderRef, __) {
            return AuthWidgetBuilder(
              databaseBuilder: databaseBuilder,
              builder: (BuildContext context,
                  AsyncSnapshot<UserModel> userSnapshot) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  locale: languageProviderRef.appLocale,
                  //List of all supported locales
                  supportedLocales: const [Locale('en', 'US')],
                  //These delegates make sure that the localization data for the proper language is loaded
                  localizationsDelegates: const [
                    //A class which loads the translations from JSON files
                    AppLocalizations.delegate,
                    //Built-in localization of basic text for Material widgets (means those default Material widget such as alert dialog icon text)
                    GlobalMaterialLocalizations.delegate,
                    //Built-in localization for text direction LTR/RTL
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  //return a locale which will be used by the app
                  localeResolutionCallback: (locale, supportedLocales) {
                    //check if the current device locale is supported or not
                    for (var supportedLocale in supportedLocales) {
                      if (supportedLocale.languageCode ==
                              locale?.languageCode ||
                          supportedLocale.countryCode == locale?.countryCode) {
                        return supportedLocale;
                      }
                    }
                    //if the locale from the mobile device is not supported yet,
                    //user the first one from the list (in our case, that will be English)
                    return supportedLocales.first;
                  },
                  title: Provider.of<Environment>(context).toString(),
                  routes: Routes.routes,
                  theme: AppThemes.lightTheme,
                  darkTheme: AppThemes.darkTheme,
                  themeMode: themeProviderRef.isDarkModeOn
                      ? ThemeMode.dark
                      : ThemeMode.light,
                  home: Consumer<UserProvider>(
                    builder: (_, authProviderRef, __) {
                      if (userSnapshot.connectionState ==
                          ConnectionState.active) {
                        return userSnapshot.hasData
                            ? const SignInScreen()
                            : const SignInScreen();
                      }

                      return const Material(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                );
              },
              key: const Key('AuthWidget'),
            );
          },
        );
      },
    );
  }
}
