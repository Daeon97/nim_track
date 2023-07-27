// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/features/settings/presentation/widgets/theme_section.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            settingsLiteral,
          ),
          actions: [
            IconButton(
              onPressed: () => _onAboutClicked(
                context: context,
              ),
              icon: const Icon(
                Icons.info,
              ),
            ),
          ],
        ),
        body: const SingleChildScrollView(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: spacing,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: spacing,
              ),
              ThemeSection(),
              SizedBox(
                height: spacing,
              ),
            ],
          ),
        ),
      );

  void _onAboutClicked({
    required BuildContext context,
  }) {
    showAboutDialog(
      context: context,
      applicationName: applicationNameLiteral,
      applicationLegalese: applicationShortDescriptionLiteral,
    );
  }
}
