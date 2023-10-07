import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/app_bloc/app_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Page<void> page() =>
      const MaterialPage<void>(child: HomePage());



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Scaffold(
          body: Container(
            color: Colors.greenAccent,
            child: MaterialButton(
              onPressed: () {
                context.read<AppBloc>().add(AppLogoutRequested());
              },
              child: Text('выйти'),
            ),
          ),
        );
      },
    );
  }
}
