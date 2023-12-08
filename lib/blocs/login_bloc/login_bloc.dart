import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../core/repositories/login_repository.dart';
import '../../core/services/login/login_service.dart';
import '../../core/utils/functions.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginUserEvent) {
        emit(LoginLoading());
        final loginRepository = LoginRepository();
        try {
          emit(LoginSuccess());
        } on LoginServiceException catch (e) {
          emit(LoginFailed(error: e.message));
        } on LoginRepositoryException catch (e) {
          emit(LoginFailed(error: e.message));
        } catch (e) {
          handleException(
              e: e,
              action: (message) {
                emit(LoginFailed(error: message));
              });
        }
      }
    });
  }
}
