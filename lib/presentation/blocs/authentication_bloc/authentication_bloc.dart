import 'dart:async';

import 'package:autom_app_registration/domain/repositories/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(this._authenticationRepository)
      : super(const AuthenticationInitial()) {
    on<AuthenticationWaiting>(_waitAuthentication);
    on<GetSMSCode>(_getSMSCode);
    on<ConfirmCode>(_confirmCode);
    on<ResendCode>(_resendCode);
  }

  final AuthenticationRepository _authenticationRepository;

  TextEditingController phoneController = TextEditingController();
  TextEditingController smsCodeController = TextEditingController();

  Future<void> _waitAuthentication(AuthenticationEvent event, Emitter<AuthenticationState> emit) async{
    emit(const WaitAuthentication());
  }

  Future<void> _getSMSCode(
      AuthenticationEvent event, Emitter<AuthenticationState> emit) async {
    try {
      final String phoneNumber = '+7${phoneController.text}';

      print(phoneNumber);

      _authenticationRepository.getSMSCode(phoneNumber: phoneNumber);
      emit(const AuthenticationSuccess());
    } catch (_) {
      emit(const AuthenticationFailure());
    }
  }

  Future<void> _confirmCode(
      AuthenticationEvent event, Emitter<AuthenticationState> emit) async {
    try {
      _authenticationRepository.confirmCode(code: smsCodeController.text);
    } catch (_) {
      emit(const AuthenticationFailure());
    }
  }

  Future<void> _resendCode(
      AuthenticationEvent event, Emitter<AuthenticationState> emit) async {
    try {
      final String phoneNumber = '+7${phoneController.text}';

      _authenticationRepository.resendCode(phoneNumber: phoneNumber);
      emit(const AuthenticationSuccess());
    } catch (_) {
      emit(const AuthenticationFailure());
    }
  }
}
