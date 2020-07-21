import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lily_books/bloc/blocs.dart';
import 'package:lily_books/bloc/theme_mode/theme_mode_bloc.dart';
import 'package:lily_books/constants.dart';
import 'package:lily_books/lily.app.dart';
import 'package:lily_books/models/user.model.dart';
import 'package:lily_books/observer/logger.observer.dart';
import 'package:lily_books/repositories/auth.repo.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init logger observer for Bloc
  Bloc.observer = LoggerObserver();

  // init Hive
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);
  await Hive.openBox(BOX_USER);
  await Hive.openBox(BOX_CONFIG);
  Hive.registerAdapter(UserAdapter());

  runApp(
    RepositoryProvider(
      create: (_) => AuthRepo(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeModeBloc()),
          BlocProvider(create: (_) => LanguageBloc()),
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
