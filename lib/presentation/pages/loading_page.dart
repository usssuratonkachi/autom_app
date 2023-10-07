import 'package:autom_app_registration/presentation/widgets/load_page_widgets/animated_logo.dart';
import 'package:autom_app_registration/presentation/widgets/load_page_widgets/animated_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ui/colors.dart';
import '../blocs/app_bloc/app_bloc.dart';


class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: LoadingPage());

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            color: UIColors.red,
            child: Stack(alignment: AlignmentDirectional.center, children: [
              SizedBox(
                width: double.infinity,
                height: 625,
                child: Image.asset('assets/images/Wheel.png', fit: BoxFit.cover,),
              ),
              const SizedBox(
                height: 303,
                child: Column(
                  children: [
                    AnimatedLogo(),
                    SizedBox(
                      height: 38,
                    ),
                    AnimatedText()
                  ],
                ),
              )
            ]),
          ),
        );
      },
    );
  }
}
