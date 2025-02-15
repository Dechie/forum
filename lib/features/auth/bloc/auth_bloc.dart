import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';

import '../models/user.dart';
import '../repository/auth_repository.dart';
part 'auth_event.dart';
part 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.login(event.username, event.password);
      emit(AuthSuccess(user: user));
    } catch (error) {
      emit(AuthFailure(message: error.toString()));
    }
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.register(
        event.name,
        event.username,
        event.email,
        event.password,
      );
      emit(AuthSuccess(user: user));
    } catch (error) {
      emit(AuthFailure(message: error.toString()));
    }
  }
}
