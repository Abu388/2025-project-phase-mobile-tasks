import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/socket/socket_service.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/register.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Register registerUsecase;
  final Login loginUsecase;

  AuthBloc({
    required this.registerUsecase,
    required this.loginUsecase,
  }) : super(AuthInitial()) {
    on<RegisterRequested>(_onRegisterRequested);
    on<LoginRequested>(_onLoginRequested);
  }

  void _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await registerUsecase(
      event.name,
      event.email,
      event.password,
    );

    result.fold(
      (failure) => emit(AuthFailure(failure.message ?? 'Registration Failed')),
      (user) => emit(AuthSuccess(user)),
    );
  }

  void _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await loginUsecase(event.email, event.password);

    result.fold(
      (failure) => emit(AuthFailure(failure.message ?? 'Login Failed ❌')),
      (user) {
        // ✅ Connect socket after successful login
        final socketService = SocketService();
        socketService.connect();

        emit(AuthSuccess(user));
      },
    );
  }
}
