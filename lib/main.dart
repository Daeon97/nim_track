import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nim_track/app.dart';
import 'package:nim_track/injection_container.dart';

void main() {
  _init().then(
    (_) => runApp(
      const App(),
    ),
  );
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  initDependencyInjection();
}
