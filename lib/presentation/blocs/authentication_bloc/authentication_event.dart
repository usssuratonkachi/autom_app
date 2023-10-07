part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class AuthenticationWaiting extends AuthenticationEvent {}

class GetSMSCode extends AuthenticationEvent {}

class ConfirmCode extends AuthenticationEvent {}

class ResendCode extends AuthenticationEvent {}
