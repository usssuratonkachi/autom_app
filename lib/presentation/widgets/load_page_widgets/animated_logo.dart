import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedLogo extends StatefulWidget {
  const AnimatedLogo({super.key});

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo> {
  double turns = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      turns += 1 / 2;
      if(mounted){
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {});
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 180,
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              width: 159,
              height: 159,
              child: AnimatedRotation(
                  turns: turns,
                  duration: const Duration(milliseconds: 580),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Image.asset('assets/images/arrow.png'))),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset('assets/images/Union.png'),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset('assets/images/red_circle.png'),
          ),
        ],
      ),
    );
  }
}