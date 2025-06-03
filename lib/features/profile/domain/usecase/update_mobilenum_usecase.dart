import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/features/profile/domain/repository/i_profile_repo.dart';

class UpdateMobilenumUsecase {
  final IProfileRepo iProfileRepo;
  UpdateMobilenumUsecase(this.iProfileRepo);

  Future<void> execute(UserEntity mobileNum) {
    return iProfileRepo.updateMobileNum(mobileNum);
  }
}
