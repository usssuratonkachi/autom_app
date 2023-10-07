import 'package:autom_app_registration/utils/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'domain/repositories/authentication_repository.dart';
import 'injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final authenticationRepository = AuthenticationRepository();

  await authenticationRepository.user.first;

  final injectionContainer = await injection(App(
    authenticationRepository: authenticationRepository,
  ));

  runApp(injectionContainer);
}
