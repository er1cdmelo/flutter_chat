import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState({List props = const []}) : super();
}

class AuthInitialState extends AuthState {
  const AuthInitialState() : super();

  @override
  List<Object?> get props => [];
}

class AuthNotLoggedState extends AuthState {
  const AuthNotLoggedState() : super();

  @override
  List<Object?> get props => [];
}

class AuthLoggedState extends AuthState {
  const AuthLoggedState() : super();

  @override
  List<Object?> get props => [];
}
