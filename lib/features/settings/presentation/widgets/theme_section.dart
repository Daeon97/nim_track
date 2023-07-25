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
          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(
                smallSpacing,
              ),
            ),
            leading: Icon(
              Icons.color_lens,
              color: Theme.of(context).dividerColor,
            ),
            title: Text(
              colorLiteral + tabSpace + verticalBar + tabSpace + blueLiteral,
              style: TextStyle(
                color: Theme.of(context).dividerColor,
              ),
            ),
            subtitle: Text(
              colorExplanationLiteral,
              style: TextStyle(
                color: Theme.of(context).dividerColor,
              ),
            ),
            trailing: Container(
              width: largeSpacing + tinySpacing + tinySpacing,
              height: largeSpacing + tinySpacing + tinySpacing,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: baseColorBlue,
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                ),
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
              onTap: () {
                switch (themeState.themeEntity.brightness) {
                  case Brightness.light:
                    themeContext.read<ThemeBloc>().add(
                          const ThemeEvent(
                            seedColor: enums.SeedColor.blue,
                            brightness: enums.Brightness.dark,
                          ),
                        );
                  case Brightness.dark:
                    themeContext.read<ThemeBloc>().add(
                          const ThemeEvent(
                            seedColor: enums.SeedColor.blue,
                            brightness: enums.Brightness.light,
                          ),
                        );
                }
              },
              title: Text(
                brightnessLiteral +
                    tabSpace +
                    verticalBar +
                    tabSpace +
                    switch (themeState.themeEntity.brightness) {
                      Brightness.light => lightLiteral,
                      Brightness.dark => darkLiteral
                    },
              ),
              subtitle: Text(
                switch (themeState.themeEntity.brightness) {
                  Brightness.light => lightThemeExplanationLiteral,
                  Brightness.dark => darkThemeExplanationLiteral
                },
              ),
              leading: Icon(
                switch (themeState.themeEntity.brightness) {
                  Brightness.light => Icons.light_mode,
                  Brightness.dark => Icons.dark_mode
                },
              ),
              trailing: Switch(
                value: themeState.themeEntity.brightness == Brightness.dark,
                onChanged: (_) {
                  switch (themeState.themeEntity.brightness) {
                    case Brightness.light:
                      themeContext.read<ThemeBloc>().add(
                            const ThemeEvent(
                              seedColor: enums.SeedColor.blue,
                              brightness: enums.Brightness.dark,
                            ),
                          );
                    case Brightness.dark:
                      themeContext.read<ThemeBloc>().add(
                            const ThemeEvent(
                              seedColor: enums.SeedColor.blue,
                              brightness: enums.Brightness.light,
                            ),
                          );
                  }
                },
              ),
            ),
          ),
        ],
      );
}
