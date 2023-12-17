import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:evento/core/utils/shared_pref_utils/shared_pref_keys.dart';
import 'package:evento/core/utils/shared_pref_utils/shared_pref_util.dart';

import '../../core/repositories/auth_repository.dart';
import '../../core/services/auth/auth_service.dart';
import '../../core/utils/functions.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginUserEvent) {
        emit(LoginLoading());

        try {
          final authRepository = AuthRepository();
          final List response =
              await authRepository.login(event.email, event.password);
          await SharedPreferencesUtil.saveString(
              SharedPrefKeys.token, response[1]);
          await SharedPreferencesUtil.saveString(
              SharedPrefKeys.userId, response[0]);
          emit(LoginSuccess(response[0], response[1], response[2]));
        } on AuthServiceException catch (e) {
          emit(LoginFailed(error: e.message));
        } on AuthRepositoryException catch (e) {
          emit(LoginFailed(error: e.message));
        } catch (e) {
          handleException(
              e: e,
              action: (message) {
                emit(LoginFailed(error: message));
              });
        }
      }
      if (event is RegisterUserEvent) {
        emit(RegisterLoading());

        try {
          final authRepository = AuthRepository();
          await authRepository.register(
              event.email, event.password, event.firstName, event.lastName);

          emit(const RegisterSuccess('Sign Up successful. Login to continue'));
        } on AuthServiceException catch (e) {
          emit(RegisterFailed(error: e.message));
        } on AuthRepositoryException catch (e) {
          emit(RegisterFailed(error: e.message));
        } catch (e) {
          handleException(
              e: e,
              action: (message) {
                emit(RegisterFailed(error: message));
              });
        }
      }
    });
  }
}
