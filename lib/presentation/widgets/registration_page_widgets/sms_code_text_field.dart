import 'package:flutter/material.dart';

import '../../../ui/colors.dart';
import '../../../ui/font_styles.dart';

class SmsCodeTextField extends StatefulWidget {
  const SmsCodeTextField({required this.smsCodeController, super.key});

  final TextEditingController smsCodeController;

  @override
  State<SmsCodeTextField> createState() => _SmsCodeTextFieldState();
}

class _SmsCodeTextFieldState extends State<SmsCodeTextField> {
  late FocusNode focusNode;



  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 210,
        child: TextField(
          controller: widget.smsCodeController,
          focusNode: focusNode,
          cursorColor: UIColors.black,
          cursorWidth: 1,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Код из SMS',
            labelStyle: focusNode.hasFocus
                ? UIFontStyles.registrationPageFocusTextFieldFontStyle
                : UIFontStyles.registrationPageEnabledTextFieldFontStyle,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(width: 1, color: UIColors.gray80)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(width: 2, color: UIColors.black)),
          ),
        ));
  }
}
