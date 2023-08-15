// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nim_track/core/resources/colors.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/core/utils/enums.dart' as enums;
import 'package:nim_track/features/settings/presentation/blocs/theme_bloc/theme_bloc.dart';

class ThemeSection extends StatelessWidget {
  const ThemeSection({super.key});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                themeSettingsLiteral,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Expanded(
                child: Divider(
                  indent: spacing,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: smallSpacing,
          ),
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (themeContext, themeState) => ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(
                  smallSpacing,
                ),
              ),
              leading: const Icon(
                Icons.color_lens,
              ),
              title: Text(
                colorLiteral +
                    tabSpace +
                    verticalBar +
                    tabSpace +
                    switch (themeState.themeEntity.fakeSeedColor) {
                      enums.SeedColor.blue => blueLiteral,
                      enums.SeedColor.yellow => yellowLiteral,
                      enums.SeedColor.purple => purpleLiteral,
                      enums.SeedColor.orange => orangeLiteral
                    },
              ),
              subtitle: const Text(
                colorExplanationLiteral,
              ),
              trailing: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    margin: const EdgeInsetsDirectional.only(
                      end: spacing + smallSpacing,
                    ),
                    width: largeSpacing + tinySpacing + tinySpacing,
                    height: largeSpacing + tinySpacing + tinySpacing,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: themeState.themeEntity.actualSeedColor,
                      border: Border.all(
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(
                        spacing,
                      ),
                      items: List<DropdownMenuItem<String>>.generate(
                        tinySpacing.toInt() + tinySpacing.toInt(),
                        (index) => DropdownMenuItem<String>(
                          value: index == nil.toInt()
                              ? blueLiteral
                              : index == veryTinySpacing.toInt()
                                  ? yellowLiteral
                                  : index == tinySpacing.toInt()
                                      ? purpleLiteral
                                      : orangeLiteral,
                          child: Text(
                            index == nil.toInt()
                                ? blueLiteral
                                : index == veryTinySpacing.toInt()
                                    ? yellowLiteral
                                    : index == tinySpacing.toInt()
                                        ? purpleLiteral
                                        : orangeLiteral,
                          ),
                        ),
                      ),
                      onChanged: (value) => _onColorClicked(
                        themeContext: themeContext,
                        value: value ?? blueLiteral,
                        themeState: themeState,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (themeContext, themeState) => ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(
                  smallSpacing,
                ),
              ),
              title: Text(
                brightnessLiteral +
                    tabSpace +
                    verticalBar +
                    tabSpace +
                    switch (themeState.themeEntity.fakeBrightness) {
                      enums.Brightness.light => lightLiteral,
                      enums.Brightness.dark => darkLiteral
                    },
              ),
              subtitle: Text(
                switch (themeState.themeEntity.fakeBrightness) {
                  enums.Brightness.light => lightThemeExplanationLiteral,
                  enums.Brightness.dark => darkThemeExplanationLiteral
                },
              ),
              leading: Icon(
                switch (themeState.themeEntity.fakeBrightness) {
                  enums.Brightness.light => Icons.light_mode,
                  enums.Brightness.dark => Icons.dark_mode
                },
              ),
              trailing: Switch(
                value: themeState.themeEntity.fakeBrightness ==
                    enums.Brightness.dark,
                onChanged: (_) => _onBrightnessClicked(
                  themeContext: themeContext,
                  themeState: themeState,
                ),
              ),
            ),
          ),
        ],
      );

  void _onBrightnessClicked({
    required BuildContext themeContext,
    required ThemeState themeState,
  }) {
    switch (themeState.themeEntity.fakeBrightness) {
      case enums.Brightness.light:
        themeContext.read<ThemeBloc>().add(
              ThemeEvent(
                fakeSeedColor: themeState.themeEntity.fakeSeedColor,
                fakeBrightness: enums.Brightness.dark,
              ),
            );
      case enums.Brightness.dark:
        themeContext.read<ThemeBloc>().add(
              ThemeEvent(
                fakeSeedColor: themeState.themeEntity.fakeSeedColor,
                fakeBrightness: enums.Brightness.light,
              ),
            );
    }
  }

  void _onColorClicked({
    required BuildContext themeContext,
    required String value,
    required ThemeState themeState,
  }) {
    final fakeSeedColor = switch (value) {
      yellowLiteral => enums.SeedColor.yellow,
      purpleLiteral => enums.SeedColor.purple,
      orangeLiteral => enums.SeedColor.orange,
      _ => enums.SeedColor.blue,
    };
    themeContext.read<ThemeBloc>().add(
          ThemeEvent(
            fakeSeedColor: fakeSeedColor,
            fakeBrightness: themeState.themeEntity.fakeBrightness,
          ),
        );
  }
}
