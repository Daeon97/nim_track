// ignore_for_file: public_member_api_docs

part of 'theme_bloc.dart';

final class ThemeEvent extends Equatable {
  const ThemeEvent({
    required this.fakeSeedColor,
    required this.fakeBrightness,
  });

  final enums.SeedColor fakeSeedColor;
  final enums.Brightness fakeBrightness;

  @override
  List<Object?> get props => [
        fakeSeedColor,
        fakeBrightness,
      ];
}
