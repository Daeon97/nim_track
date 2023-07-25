// ignore_for_file: public_member_api_docs

part of 'theme_bloc.dart';

final class ThemeEvent extends Equatable {
  const ThemeEvent({
    required this.seedColor,
    required this.brightness,
  });

  final enums.SeedColor seedColor;
  final enums.Brightness brightness;

  @override
  List<Object?> get props => [
        seedColor,
        brightness,
      ];
}
