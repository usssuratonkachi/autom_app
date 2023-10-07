part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();

  @override
  List<Object> get props => [];
}

class WaitAuthentication extends AuthenticationState{
  const WaitAuthentication();

  @override
  List<Object> get props => [];
}

class AuthenticationSuccess extends AuthenticationState {
  const AuthenticationSuccess();

  @override
  List<Object> get props => [];
}

class AuthenticationFailure extends AuthenticationState {
  const AuthenticationFailure();

  @override
  List<Object> get props => [];
}