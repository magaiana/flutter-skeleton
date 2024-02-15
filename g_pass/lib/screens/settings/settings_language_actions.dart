import 'package:flutter/material.dart';
import 'package:g_pass/app_localization.dart';
import 'package:g_pass/providers/language_provider.dart';
import 'package:provider/provider.dart';

enum LanguagesActions { english, chinese }

class SettingLanguageActions extends StatelessWidget {
  const SettingLanguageActions({super.key});

  @override
  Widget build(BuildContext context) {
    LanguageProvider languageProvider = Provider.of(context);
    Locale appCurrentLocale = languageProvider.appLocale;

    return PopupMenuButton<LanguagesActions>(
      icon: const Icon(Icons.language),
      onSelected: (LanguagesActions result) {
        switch (result) {
          case LanguagesActions.english:
            languageProvider.updateLanguage("en");
            break;
          case LanguagesActions.chinese:
            languageProvider.updateLanguage("zh");
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<LanguagesActions>>[
        PopupMenuItem<LanguagesActions>(
          value: LanguagesActions.english,
          enabled: appCurrentLocale == const Locale("en") ? false : true,
          child: Text(AppLocalizations.of(context)
              .translate("settingPopUpToggleEnglish")),
        ),
        PopupMenuItem<LanguagesActions>(
          value: LanguagesActions.chinese,
          enabled: appCurrentLocale == const Locale("zh") ? false : true,
          child: Text(AppLocalizations.of(context)
              .translate("settingPopUpToggleChinese")),
        ),
      ],
    );
  }
}
