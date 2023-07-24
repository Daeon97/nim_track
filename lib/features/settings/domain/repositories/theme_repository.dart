// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

abstract interface class ThemeRepository {
  Color get seedColor;

  Brightness get brightness;

  ColorScheme get colorScheme;
}
