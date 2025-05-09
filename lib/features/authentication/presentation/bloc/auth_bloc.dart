import 'package:bloc/bloc.dart';
import 'package:in_between/core/model/user_model.dart';
import 'package:in_between/features/authentication/domain/auth_repo.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Authrepo authRepo;

  AuthBloc(this.authRepo) : super(AuthInitial()) {
    on<GetUser>((event, emit) {
      final user = authRepo.getUsers();
      emit(UserLoaded(user.cast<UserModel>()));
    });

    on<IsValid>((event, emit) async {
      final isValid = authRepo.isValid(event.username, event.password);
      if (isValid) {
        emit(UserValid());
      } else {
        emit(UserInvalid());
      }
    });
  }
}
