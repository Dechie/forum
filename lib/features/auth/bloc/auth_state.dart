part of 'auth_bloc.dart';

class AuthFailure extends AuthState {
  final String message;

  AuthFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthSuccess extends AuthState {
  final User user;

  AuthSuccess({required this.user});

  @override
  List<Object> get props => [user];
}
