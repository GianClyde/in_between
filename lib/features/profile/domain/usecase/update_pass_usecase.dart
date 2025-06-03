import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/features/profile/domain/repository/i_profile_repo.dart';

class UpdatePassUsecase {
  final IProfileRepo iProfileRepo;
  UpdatePassUsecase(this.iProfileRepo);

  Future<void> execute(UserEntity pass) {
    return iProfileRepo.updatePass(pass);
  }
}
