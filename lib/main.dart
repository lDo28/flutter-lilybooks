import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lily_books/bloc/blocs.dart';
import 'package:lily_books/bloc/theme_mode/theme_mode_bloc.dart';
import 'package:lily_books/constants.dart';
import 'package:lily_books/lily.app.dart';
import 'package:lily_books/observer/logger.observer.dart';
import 'package:lily_books/repositories/auth.repo.dart';

void main() async {
  // Init logger observer for Bloc
  Bloc.observer = LoggerObserver();

  // init Hive
  await Hive.initFlutter();
  await Hive.openBox(PREFS_BOX);

  runApp(
    RepositoryProvider(
      create: (_) => AuthRepo(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeModeBloc()),
          BlocProvider(
            create: (context) => AuthenticationBloc(
              context.repository<AuthRepo>(),
            ),
          ),
          BlocProvider(create: (_) => LoadingStateBloc()),
          BlocProvider(create: (_) => HidePasswordBloc()),
        ],
        child: LilyApp(),
      ),
    ),
  );
}
