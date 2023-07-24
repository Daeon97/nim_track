// ignore_for_file: public_member_api_docs

import 'package:nim_track/features/settings/data/models/theme_model.dart';

abstract interface class ThemeLocalDataSource {
  ThemeModel get theme;
}

class ThemeLocalDataSourceImplementation implements ThemeLocalDataSource {
  @override
  ThemeModel get theme => throw UnimplementedError();
}
