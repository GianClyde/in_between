import 'package:bloc/bloc.dart';
// import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/core/model/user_model.dart';
// import 'package:in_between/features/registration/domain/registration_repo.dart';
import 'package:in_between/features/registration/domain/usecase/add_new_user_usecase.dart';
import 'package:in_between/features/registration/domain/usecase/check_user_use_case.dart';
import 'package:meta/meta.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AddNewUserUseCase addNewUserUseCase;
  final CheckUserUseCase checkUserUseCase;

  RegistrationBloc(this.addNewUserUseCase, this.checkUserUseCase)
    : super(RegistrationInitial()) {
    on<AddUser>((event, emit) async {
      emit(RegistrationLoading());
      final response = await addNewUserUseCase.execute(event.user.toEntity());

      response.fold(
        (l) => emit(RegistrationFailed(message: l.message)),
        (r) => emit(RegistrationSuccess()),
      );
      //TODO login user after registration
    });

    on<IncompleteField>((event, emit) {
      emit(RegistrationIncomplete());
    });
  }
}
