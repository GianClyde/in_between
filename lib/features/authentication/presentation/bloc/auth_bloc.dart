import 'package:bloc/bloc.dart';
import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/features/authentication/domain/usecase/authenticate_user_usecase.dart';
import 'package:in_between/features/authentication/domain/usecase/get_user_usecase.dart';
import 'package:meta/meta.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetUserUsecase getUserUsecase;
  final AuthenticateUserUsecase authenticateUserUsecase;

  AuthBloc({
    required this.authenticateUserUsecase,
    required this.getUserUsecase,
  }) : super(AuthInitial()) {
    on<LoginRequest>((event, emit) async {
      final isValid = await authenticateUserUsecase.execute(
        event.username,
        event.password,
      );
      if (!isValid) {
        emit(UserInvalid());
        return;
      }

      final user = await getUserUsecase.execute(event.username, event.password);
      if (user != null) {
        emit(UserLoaded(user));
      } else {
        emit(UserNotLoaded());
      }
    });
  }
}
