import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lily_books/lily.app.dart';
import 'package:lily_books/observer/logger.observer.dart';
import 'package:lily_books/repositories/auth.repo.dart';
import 'package:lily_books/ui/screens/auth/authentication_bloc.dart';
import 'package:lily_books/ui/screens/loading_state/loading_state_bloc.dart';

void main() {
  Bloc.observer = LoggerObserver();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthenticationBloc(AuthRepo())),
        BlocProvider(create: (_) => LoadingStateBloc()),
      ],
      child: LilyApp(),
    ),
  );
}
