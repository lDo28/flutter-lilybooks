import 'package:cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:lily_books/lily.app.dart';
import 'package:lily_books/observer/logger.observer.dart';
import 'package:lily_books/ui/screens/splash/authorization_cubit.dart';

import 'ui/screens/loading_state/loading_state_cubit.dart';

void main() {
  Cubit.observer = LoggerObserver();
  runApp(
    MultiCubitProvider(
      providers: [
        CubitProvider(create: (_) => AuthorizationCubit()),
        CubitProvider(create: (_) => LoadingStateCubit()),
      ],
      child: LilyApp(),
    ),
  );
}
