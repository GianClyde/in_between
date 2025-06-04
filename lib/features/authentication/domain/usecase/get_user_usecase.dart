import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/features/authentication/domain/repository/i_auth_repo.dart';

class GetUserUsecase {
  final IAuthenticationRepo iAuthRepo;
  GetUserUsecase(this.iAuthRepo);

  Future<UserEntity?> execute(String username, String password) async {
    return await iAuthRepo.getUser(username, password);
  }
}
