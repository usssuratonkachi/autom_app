part of 'app_bloc.dart';

@immutable
sealed class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppInitial extends AppState {
  const AppInitial();


  @override
  List<Object> get props => [];
}

class AppAuthenticated extends AppState {
  const AppAuthenticated({required this.user});

  final User user;

  @override
  List<Object> get props => [user];
}

class AppUnauthenticated extends AppState {
  const AppUnauthenticated({required this.user});

  final User user;

  @override
  List<Object> get props => [user];
}
