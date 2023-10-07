import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../ui/colors.dart';
import '../../../ui/font_styles.dart';

class PhoneTextField extends StatefulWidget {
  const PhoneTextField({required this.phoneController, super.key});

  final TextEditingController phoneController;

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  late FocusNode focusNode;

  var maskFormatter = MaskTextInputFormatter(
      mask: '###) ###-##-##', type: MaskAutoCompletionType.lazy);

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
          inputFormatters: [maskFormatter],
          controller: widget.phoneController,
          focusNode: focusNode,
          cursorColor: UIColors.black,
          cursorWidth: 1,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: 'Номер телефона',
            labelStyle: focusNode.hasFocus
                ? UIFontStyles.registrationPageFocusTextFieldFontStyle
                : UIFontStyles.registrationPageEnabledTextFieldFontStyle,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            prefixText: '+ 7 (',
            prefixStyle:
                UIFontStyles.registrationPagePhoneNumberPrefixFontStyle,
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
