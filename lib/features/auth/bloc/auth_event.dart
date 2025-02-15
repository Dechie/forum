
part of 'auth_bloc.dart';



abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginRequested extends AuthEvent {
  final String username;
  final String password;

  LoginRequested({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class RegisterRequested extends AuthEvent {
  final String name;
  final String username;
  final String email;
  final String password;

  RegisterRequested({
    required this.name,
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [name, username, email, password];
}
