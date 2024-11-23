part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginInitiateEvent extends LoginEvent {
  final String username, password;

  const LoginInitiateEvent({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class LogoutEvent extends LoginEvent {}

class InitiateGuestLogin extends LoginEvent {}