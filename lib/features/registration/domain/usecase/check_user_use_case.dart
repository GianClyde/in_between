import 'package:in_between/features/registration/domain/repository/i_reg_repo.dart';

class CheckUserUseCase {
  final IRegistrationRepo iRegistrationRepo;
  CheckUserUseCase(this.iRegistrationRepo);

  Future<bool> execute(String username) async {
    return await iRegistrationRepo.userExists(username);
  }
}
