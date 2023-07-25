import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:nim_track/app.dart';
import 'package:nim_track/injection_container.dart';
import 'package:path_provider/path_provider.dart';

void main() => _init().then(
      (_) => runApp(
        const App(),
      ),
    );

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  initDependencyInjection();
  // await _configureAmplify();
}

// Future<void> _configureAmplify() async {
//   try {
//     if (!Amplify.isConfigured) {
//       await Amplify.addPlugin(
//         AmplifyAPI(),
//       );
//     }
//   } on AmplifyAlreadyConfiguredException catch (e) {
//     safePrint(e.message);
//   }
// }
