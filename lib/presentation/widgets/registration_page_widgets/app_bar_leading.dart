
import 'package:flutter/material.dart';

import '../../../ui/colors.dart';
import '../../../ui/font_styles.dart';

class AppBarLeading extends StatefulWidget {
  const AppBarLeading({super.key});

  @override
  State<AppBarLeading> createState() => _AppBarState();
}

class _AppBarState extends State<AppBarLeading> {
  bool isActivated = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          child: Container(
              height: double.infinity,
              width: MediaQuery.of(context).size.width / 2,
              color: Colors.white,
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      'Вход',
                      style: isActivated
                          ? UIFontStyles.registrationPageLeadingFontStyleRed
                          : UIFontStyles.registrationPageLeadingFontStyle,
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: isActivated ? UIColors.red : Colors.white,
                        height: 2,
                      ))
                ],
              )),
          onTap: () {
            setState(() {
              isActivated = !isActivated;
            });
          },
        ),
        GestureDetector(
          child: Container(
            height: double.infinity,
            width: MediaQuery.of(context).size.width / 2,
            color: Colors.white,
            alignment: Alignment.center,
            child: Stack(
              children: [
                Center(
                  child: Text(
                    'Регистрация',
                    style: isActivated
                        ? UIFontStyles.registrationPageLeadingFontStyle
                        : UIFontStyles.registrationPageLeadingFontStyleRed,
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: isActivated ? Colors.white : UIColors.red,
                      height: 2,
                    ))
              ],
            ),
          ),
          onTap: () {
            setState(() {
              isActivated = !isActivated;
            });
          },
        ),
      ],
    );
  }
}
