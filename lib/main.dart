import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/app.dart';
import 'package:marketplace/bloc_observer.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  EquatableConfig.stringify = true;
  runApp(App());
}
