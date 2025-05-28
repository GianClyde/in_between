import 'package:bloc/bloc.dart';
import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/features/authentication/domain/usecase/get_user_usecase.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // final Authrepo authRepo;
  final GetUserUsecase getUserUsecase;

  AuthBloc({required this.getUserUsecase}) : super(AuthInitial()) {
    on<LoginRequest>((event, emit) async {
      print("USER: bloc truggeds");
      emit(AuthLoading());

      final response = await getUserUsecase.execute(
        event.username,
        event.password,
      );

      response.fold(
        (l) => emit(AuthFailed(error: l.message)),
        (r) => emit(AuthSuccess(user: r!)),
      );
      //final user = null;
      // print("USER: bloc user  contains = ${user?.username}");
      // if (user != null) {
      //   emit(AuthSuccess(user: user));
      // } else {
      //   emit(AuthFailed(error: "UserNot Found"));
      // }
    });
  }
}
