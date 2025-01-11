import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_quest/features/auth/data/datasources/auth_firebase.dart';
import 'package:habit_quest/features/auth/data/datasources/auth_objectbox.dart';
import 'package:habit_quest/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:habit_quest/features/auth/domain/usecases/reset_pwd.dart';
import 'package:habit_quest/features/auth/domain/usecases/sign_in.dart';
import 'package:habit_quest/features/auth/domain/usecases/sign_up.dart';
import 'package:habit_quest/features/auth/presentation/blocs/reset_pwd_bloc/reset_pwd_bloc.dart';
import 'package:habit_quest/features/auth/presentation/blocs/signin_bloc/signin_bloc.dart';
import 'package:habit_quest/features/auth/presentation/blocs/signup_bloc/signup_bloc.dart';
import 'package:habit_quest/features/habit/data/datasources/habit_firebase.dart';
import 'package:habit_quest/features/habit/data/datasources/habit_objectbox.dart';
import 'package:habit_quest/features/habit/data/repositories/habit_repository_impl.dart';
import 'package:habit_quest/features/habit/domain/usecases/create_habit.dart';
import 'package:habit_quest/features/habit/domain/usecases/create_progress.dart';
import 'package:habit_quest/features/habit/domain/usecases/delete_habit.dart';
import 'package:habit_quest/features/habit/domain/usecases/fetch_habits.dart';
import 'package:habit_quest/features/habit/domain/usecases/fetch_progress.dart';
import 'package:habit_quest/features/habit/domain/usecases/sync_habit.dart';
import 'package:habit_quest/features/habit/domain/usecases/sync_progress.dart';
import 'package:habit_quest/features/habit/domain/usecases/update_habit.dart';
import 'package:habit_quest/features/habit/presentation/blocs/habit_bloc/habit_bloc.dart';
import 'package:habit_quest/features/network/data/repository/network_repository.dart';
import 'package:habit_quest/features/network/presentation/bloc/network_bloc.dart';
import 'package:habit_quest/features/profile/data/datasources/profile_firebase.dart';
import 'package:habit_quest/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:habit_quest/features/profile/presentation/blocs/signout_bloc/signout_bloc.dart';
import 'package:habit_quest/features/profile/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:habit_quest/firebase_options.dart';
import 'package:habit_quest/main_production.dart';
import 'package:habit_quest/shared/helpers/objectbox.dart';
import 'package:habit_quest/shared/services/notification_service.dart';
//import 'package:habit_quest/shared/services/sync_service.dart';
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

  // Initialize Firebase (Backend-as-a-Service)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  // Create ObjectBox
  objectbox = await ObjectBox.create();

  // Initialize authFirebase and authObjectBox
  final firebaseAuth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final authFirebase = AuthFirebase(
    firebaseAuth: firebaseAuth,
    firestore: firestore,
  );
  final authObjectBox = AuthObjectBox(objectBox: objectbox);
  final habitObjectBox = HabitObjectbox(objectBox: objectbox);

  // Initialze profileFirebase
  final profileFirebase = ProfileFirebase(
    firebaseAuth: firebaseAuth,
  );

  final habitFirebase = HabitFirebase(
    firebaseAuth: firebaseAuth,
    firestore: firestore,
  );

  // Initialize the authRepository
  final authRepository = AuthRepositoryImpl(
    authFirebase: authFirebase,
    authObjectBox: authObjectBox,
  );

  // Initialize the ProfileRepository
  final profileRepository = ProfileRepositoryImpl(
    profileFirebase: profileFirebase,
  );

  // Initialize the HabitRepository
  final habitRepository = HabitRepositoryImpl(
    habitFirebase: habitFirebase,
    habitObjectbox: habitObjectBox,
    networkBloc: NetworkBloc(
      networkCheckRepository: NetworkRepository(),
    ),
  );

  // Initialize use cases
  final signUpUseCase = SignUp(repository: authRepository);
  final signInUseCase = SignIn(repository: authRepository);
  final resetPwdUseCase = ResetPassword(repository: authRepository);
  final createHabitUseCase = CreateHabit(repository: habitRepository);
  final updateHabitUseCase = UpdateHabit(repository: habitRepository);
  final deleteHabitUseCase = DeleteHabit(repository: habitRepository);
  final fetchHabitsUseCase = FetchHabits(repository: habitRepository);
  final syncHabitUseCase = SyncHabit(repository: habitRepository);
  final createProgressUseCase = CreateProgress(repository: habitRepository);
  final fetchProgressUseCase = FetchProgress(repository: habitRepository);
  final syncProgressUseCase = SyncProgress(repository: habitRepository);

  // Restrict app to portrait orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Initialize NotificationService
  await NotificationService().initialize();

  // Initialize SyncService
  //await SyncService.initialize();

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
        // Signup Bloc
        BlocProvider(
          create: (context) => SignUpBloc(
            signUp: signUpUseCase,
          ),
        ),
        // Signin Bloc
        BlocProvider(
          create: (context) => SignInBloc(
            signIn: signInUseCase,
            authRepository: authRepository,
          ),
        ),
        // ResetPwd Bloc
        BlocProvider(
          create: (context) => ResetPwdBloc(
            resetPassword: resetPwdUseCase,
          ),
        ),
        // SignOut Bloc
        BlocProvider(
          create: (context) => SignOutBloc(
            profileRepository: profileRepository,
          ),
        ),
        // Habit Bloc
        BlocProvider(
          create: (context) => HabitBloc(
            createHabit: createHabitUseCase,
            updateHabit: updateHabitUseCase,
            deleteHabit: deleteHabitUseCase,
            fetchHabits: fetchHabitsUseCase,
            createProgress: createProgressUseCase,
            fetchProgress: fetchProgressUseCase,
            syncHabit: syncHabitUseCase,
            syncProgress: syncProgressUseCase,
          ),
        ),
      ],
      child: await builder(),
    ),
  );
}
