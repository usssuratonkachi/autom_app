import 'dart:async';

import 'package:autom_app_registration/domain/repositories/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data/models/user_model.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const AppInitial()) {
    on<_AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    on<AppInitialEvent>(_onInitial);

    _userSubscription = _authenticationRepository.user.listen(
          (user) => add(_AppUserChanged(user)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  void _onUserChanged(_AppUserChanged event, Emitter<AppState> emit) async  {
    await  Future.delayed(const Duration(seconds: 2), () {
      emit(
        event.user.isNotEmpty
            ? AppAuthenticated(user: event.user)
            :  AppUnauthenticated(user: _authenticationRepository.currentUser),
      );
    });

  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  void _onInitial(AppInitialEvent event, Emitter<AppState> emit)  async {
    await  Future.delayed(const Duration(seconds: 2), () {
      _authenticationRepository.currentUser.isNotEmpty
          ? emit(AppAuthenticated(user: _authenticationRepository.currentUser))
          : emit(const AppUnauthenticated(user: User.empty));
    });

  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}