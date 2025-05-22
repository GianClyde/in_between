import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/features/registration/domain/repository/i_reg_repo.dart';

class AddNewUserUseCase {
  final IRegistrationRepo iRegistrationRepo;
  AddNewUserUseCase(this.iRegistrationRepo);

  Future<void> execute(UserEntity user) async {
    return await iRegistrationRepo.addUser(user);
  }
}
