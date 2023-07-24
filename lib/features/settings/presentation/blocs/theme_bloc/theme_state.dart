// ignore_for_file: public_member_api_docs

part of 'theme_bloc.dart';

final class ThemeState extends Equatable {
  const ThemeState({
    this.themeData,
  });

  final ThemeData? themeData;

  @override
  List<Object?> get props => [
        themeData,
      ];
}
