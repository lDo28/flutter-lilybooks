import 'package:flutter/material.dart';
import 'package:lily_books/bloc/blocs.dart';
import 'package:lily_books/lily.app.dart';
import 'package:lily_books/observer/logger.observer.dart';
import 'package:lily_books/repositories/auth.repo.dart';

void main() {
  Bloc.observer = LoggerObserver();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthenticationBloc(AuthRepo())),
        BlocProvider(create: (_) => LoadingStateBloc()),
        BlocProvider(create: (_) => HidePasswordBloc()),
      ],
      child: LilyApp(),
    ),
  );
}
