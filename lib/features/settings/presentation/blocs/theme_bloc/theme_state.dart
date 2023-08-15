// ignore_for_file: public_member_api_docs

part of 'theme_bloc.dart';

final class ThemeState extends Equatable {
  const ThemeState({
    required this.themeEntity,
  });

  final ThemeEntity themeEntity;

  @override
  List<Object?> get props => [
        themeEntity,
      ];
}
