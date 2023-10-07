import 'package:autom_app_registration/domain/repositories/authentication_repository.dart';
import 'package:autom_app_registration/presentation/blocs/app_bloc/app_bloc.dart';
import 'package:autom_app_registration/presentation/pages/home_page.dart';
import 'package:autom_app_registration/presentation/pages/loading_page.dart';
import 'package:autom_app_registration/presentation/pages/registration_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App(
      {required AuthenticationRepository authenticationRepository, super.key})
      : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: _authenticationRepository,
        child: BlocProvider(
          create: (_) =>
              AppBloc(authenticationRepository: _authenticationRepository)..add(const AppInitialEvent()),
          child: const AppView(),
        ));
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            // switch (AppState) {
            //   case AppAuthenticated:
            //     return const HomePage();
            //   case AppUnauthenticated:
            //     print(124124214);
            //     return const RegistrationPage();
            //   case AppInitial:
            //     return const LoadingPage();
            //   default:
            //     return const LoadingPage();
            // }
            if (state is AppAuthenticated){
              return const HomePage();
            }
            if (state is AppUnauthenticated){
              print(123124);
              return const RegistrationPage();
            }
            return const LoadingPage();

          },
        ));
  }
}
