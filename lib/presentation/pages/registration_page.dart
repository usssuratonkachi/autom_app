import 'package:autom_app_registration/presentation/pages/loading_page.dart';
import 'package:autom_app_registration/presentation/widgets/registration_page_widgets/app_bar_leading.dart';
import 'package:autom_app_registration/presentation/widgets/registration_page_widgets/custom_check_box.dart';
import 'package:autom_app_registration/presentation/widgets/registration_page_widgets/phone_text_field.dart';
import 'package:autom_app_registration/presentation/widgets/registration_page_widgets/sms_code_text_field.dart';
import 'package:autom_app_registration/ui/colors.dart';
import 'package:autom_app_registration/ui/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication_bloc/authentication_bloc.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  static Page<void> page() =>
      const MaterialPage<void>(child: RegistrationPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(context.read()),
      child: const RegistrationPageView(),
    );
  }
}

class RegistrationPageView extends StatefulWidget {
  const RegistrationPageView({super.key});

  @override
  State<RegistrationPageView> createState() => _RegistrationPageViewState();
}

class _RegistrationPageViewState extends State<RegistrationPageView> {
  @override
  void initState() {

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
              elevation: 0,
              backgroundColor: UIColors.white,
              leadingWidth: MediaQuery.of(context).size.width,
              leading: const AppBarLeading()),
          body: Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Container(
              color: UIColors.white,
              alignment: Alignment.center,
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  const Text(
                    'Регистрация нового аккаунта',
                    style: UIFontStyles.registrationPageTextBlack,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  PhoneTextField(
                    phoneController:
                        context.read<AuthenticationBloc>().phoneController,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: 210,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        color: UIColors.red),
                    child: MaterialButton(
                      onPressed: () =>
                          context.read<AuthenticationBloc>().add(GetSMSCode()),
                      child: const Text(
                        'Выслать SMS-код',
                        style: UIFontStyles.registrationPageButtonFontStyle,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextButton(
                      onPressed: () =>
                          context.read<AuthenticationBloc>().add(ResendCode()),
                      child: const Text(
                        'Выслать повторно',
                        style: UIFontStyles.registrationPageTextButtonFontStyle,
                      )),
                  const SizedBox(
                    height: 50,
                  ),
                  SmsCodeTextField(
                      smsCodeController:
                          context.read<AuthenticationBloc>().smsCodeController),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                      width: 248,
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            alignment: Alignment.center,
                            child: CustomCheckBox(),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Flexible(
                            child: RichText(
                                text: const TextSpan(
                                    style: UIFontStyles
                                        .registrationPageCheckBoxTextFontStyle,
                                    children: <TextSpan>[
                                  TextSpan(text: 'Ознакомлен с '),
                                  TextSpan(
                                      text: 'Договором оферты ',
                                      style: TextStyle(
                                          decoration:
                                              TextDecoration.underline)),
                                  TextSpan(text: 'и согласен на '),
                                  TextSpan(
                                      text: 'Рассылку',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline))
                                ])),
                          )
                        ],
                      )),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: 210,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        color: UIColors.red),
                    child: MaterialButton(
                      onPressed: () =>
                          context.read<AuthenticationBloc>().add(ConfirmCode()),
                      child: const Text(
                        'Далее',
                        style: UIFontStyles.registrationPageButtonFontStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
