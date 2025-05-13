import 'package:bloc/bloc.dart';
import 'package:in_between/core/model/user_model.dart';
import 'package:in_between/features/registration/domain/registration_repo.dart';
import 'package:meta/meta.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final RegistrationRepo registrationRepo;
  RegistrationBloc(this.registrationRepo) : super(RegistrationInitial()) {
    on<LoadUsers>((event, emit) {
      final users =
          registrationRepo.getUsers().map((user) => user.username).toList();
      emit(RegistrationLoaded(userData: users));
    });

    on<AddUser>((event, emit) async {
      // await registrationRepo.addUser(event.user);
      if (event.user.name.isEmpty ||
          event.user.username.isEmpty ||
          event.user.password.isEmpty ||
          event.user.mobile.isEmpty ||
          event.user.bdate.isEmpty) {
        emit(RegistrationIncomplete()); // Trigger error state
        return;
      }
      bool isAdded = await registrationRepo.addUser(event.user);
      if (isAdded) {
        emit(RegistrationSuccess());
      } else {
        emit(RegistrationFail());
      }
    });
  }
}
