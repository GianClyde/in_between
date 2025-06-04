import 'package:in_between/features/authentication/domain/repository/i_auth_repo.dart';

class AuthenticateUserUsecase {
  final IAuthenticationRepo iAuthRepo;
  AuthenticateUserUsecase(this.iAuthRepo);

  Future<bool> execute(String username, String password) async {
    return await iAuthRepo.isValid(username, password);
  }
}
