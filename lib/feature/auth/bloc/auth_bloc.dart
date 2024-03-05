import 'package:app_testes/feature/auth/bloc/auth_event.dart';
import 'package:app_testes/feature/auth/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(super.initialState) {
    on<LoginEvent>(_mapLoginEventToState);
  }

  void _mapLoginEventToState(
    LoginEvent event,
    Emitter<AuthState> state,
  ) {}
}
