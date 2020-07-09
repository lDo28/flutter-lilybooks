import 'package:cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:lily_books/lily.app.dart';
import 'package:lily_books/observer/logger.observer.dart';
import 'package:lily_books/ui/screens/splash/authorization_cubit.dart';

void main() {
  Cubit.observer = LoggerObserver();
  runApp(
    CubitProvider(
      create: (_) => AuthorizationCubit(),
      child: LilyApp(),
    ),
  );
}
