import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_quest/features/network/data/repository/network_repository.dart';
import 'package:habit_quest/features/network/presentation/bloc/network_bloc.dart';
import 'package:habit_quest/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:habit_quest/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  // Cross-flavor configuration
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase (Backend-as-a-Service)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  // Restrict app to portrait orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Instantiate and provide Blocs
  runApp(
    MultiBlocProvider(
      providers: [
        // Network Bloc
        BlocProvider(
          create: (context) => NetworkBloc(
            networkCheckRepository: NetworkRepository(),
          ),
        ),
        // Theme Bloc
        BlocProvider(
          create: (context) => ThemeBloc(
            sharedPreferences: prefs,
          ),
        ),
      ],
      child: await builder(),
    ),
  );
}
