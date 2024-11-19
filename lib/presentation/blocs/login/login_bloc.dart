import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movieapp/common/constants/translation_constants.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/login_request_params.dart';
import 'package:movieapp/domain/entities/no_params.dart';
import 'package:movieapp/domain/usecases/login_user.dart';
import 'package:movieapp/domain/usecases/logout_user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUser loginUser;
  final LogoutUser logoutUser;

  LoginBloc({required this.loginUser, required this.logoutUser})
      : super(LoginInitial()) {
    on<LoginEvent>(
      (event, emit) async {
        if (event is LoginInitiateEvent) {
          final Either<AppError, bool> eitherResponse = await loginUser(
            LoginRequestParams(
              userName: event.username,
              password: event.password,
            ),
          );
          eitherResponse.fold(
            (l) {
              var message = getErrorMessage(l.appErrorType);
              return emit(LoginError(message));
            },
            (r) => emit(LoginSuccess()),
          );
        } else if (event is LogoutEvent) {
          await logoutUser(NoParams());
          emit(LogoutSuccess());
        }
      },
    );
  }
  String getErrorMessage(AppErrorType appErrorType) {
    switch (appErrorType) {
      case AppErrorType.network:
        return TranslationConstants.noNetwork;
      case AppErrorType.api:
      case AppErrorType.database:
        return TranslationConstants.somethingWentWrong;
      case AppErrorType.sessionDenied:
        return TranslationConstants.sessionDenied;
      default:
        return TranslationConstants.wrongUsernamePassword;
    }
  }
}
