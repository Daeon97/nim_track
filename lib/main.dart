import 'package:flutter/material.dart';
import 'package:nim_track/app.dart';

void main() {
  _init().then(
    (_) => runApp(
      const App(),
    ),
  );
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
}
