import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:g_pass/app_localization.dart';
import 'package:g_pass/providers/theme_provider.dart';
import 'package:g_pass/providers/user_provider.dart';
import 'package:g_pass/routes.dart';
import 'package:g_pass/screens/settings/settings_language_actions.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("settingAppTitle")),
      ),
      body: _buildLayoutSection(context),
    );
  }

  Widget _buildLayoutSection(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text(
              AppLocalizations.of(context).translate("settingThemeListTitle")),
          subtitle: Text(AppLocalizations.of(context)
              .translate("settingThemeListSubTitle")),
          trailing: Switch(
            activeColor: Theme.of(context).appBarTheme.backgroundColor,
            activeTrackColor: Theme.of(context).textTheme.titleLarge!.color,
            value: Provider.of<ThemeProvider>(context).isDarkModeOn,
            onChanged: (booleanValue) {
              Provider.of<ThemeProvider>(context, listen: false)
                  .updateTheme(booleanValue);
            },
          ),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)
              .translate("settingLanguageListTitle")),
          subtitle: Text(AppLocalizations.of(context)
              .translate("settingLanguageListSubTitle")),
          trailing: const SettingLanguageActions(),
        ),
        ListTile(
          title: Text(
              AppLocalizations.of(context).translate("settingLogoutListTitle")),
          subtitle: Text(AppLocalizations.of(context)
              .translate("settingLogoutListSubTitle")),
          trailing: ElevatedButton(
              onPressed: () {
                _confirmSignOut(context);
              },
              child: Text(AppLocalizations.of(context)
                  .translate("settingLogoutButton"))),
        )
      ],
    );
  }

  _confirmSignOut(BuildContext context) {
    showPlatformDialog(
        context: context,
        builder: (_) => PlatformAlertDialog(
              material: (_, PlatformTarget target) => MaterialAlertDialogData(
                  backgroundColor:
                      Theme.of(context).appBarTheme.backgroundColor),
              title: Text(
                  AppLocalizations.of(context).translate("alertDialogTitle")),
              content: Text(
                  AppLocalizations.of(context).translate("alertDialogMessage")),
              actions: <Widget>[
                PlatformDialogAction(
                  child: PlatformText(AppLocalizations.of(context)
                      .translate("alertDialogCancelBtn")),
                  onPressed: () => Navigator.pop(context),
                ),
                PlatformDialogAction(
                  child: PlatformText(AppLocalizations.of(context)
                      .translate("alertDialogYesBtn")),
                  onPressed: () {
                    final authProvider =
                        Provider.of<UserProvider>(context, listen: false);

                    authProvider.signOut();

                    Navigator.pop(context);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.login, ModalRoute.withName(Routes.login));
                  },
                )
              ],
            ));
  }
}
