import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/features/profile/domain/repository/i_profile_repo.dart';

class UpdateEmailUsecase {
  final IProfileRepo iProfileRepo;
  UpdateEmailUsecase(this.iProfileRepo);

  Future<void> execute(UserEntity email) {
    return iProfileRepo.updateEmail(email);
  }
}
