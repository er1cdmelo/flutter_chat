import 'package:app_testes/core/data/model/auth/auth_login.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent([List props = const []]) : super();
}

class LoginEvent extends AuthEvent {
  final AuthLogin login;

  const LoginEvent({required this.login}) : super();

  @override
  List<Object?> get props => [login];
}

class LogoutEvent extends AuthEvent {
  const LogoutEvent() : super();

  @override
  List<Object?> get props => [];
}
