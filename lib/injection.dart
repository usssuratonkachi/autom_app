import 'package:autom_app_registration/domain/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<Widget> injection(Widget app) async {

  final authenticationRepository = AuthenticationRepository();

  return MultiRepositoryProvider(
      providers: [RepositoryProvider<AuthenticationRepository>(create: (_) => authenticationRepository)],
      child: app);
}