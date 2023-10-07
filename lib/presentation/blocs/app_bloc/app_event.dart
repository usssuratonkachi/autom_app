part of 'app_bloc.dart';

@immutable
abstract class AppEvent {
  const AppEvent();
}

class _AppUserChanged extends AppEvent {
  const _AppUserChanged(this.user);

  final User user;
}

 class AppLogoutRequested extends AppEvent {
  const AppLogoutRequested();
}

class AppInitialEvent extends AppEvent{
  const AppInitialEvent();
}

