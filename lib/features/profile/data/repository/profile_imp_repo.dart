import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/core/model/user_model.dart';
import 'package:in_between/features/profile/data/datasource/profile_datasource.dart';
import 'package:in_between/features/profile/domain/repository/i_profile_repo.dart';

class ProfileImpRepo implements IProfileRepo {
  final ProfileDatasource profileLocalDatasource;
  ProfileImpRepo(this.profileLocalDatasource);

  @override
  Future<void> updateEmail(UserEntity email) {
    final toModel = UserModel.fromEntity(email);
    return profileLocalDatasource.updateEmail(toModel);
  }

  @override
  Future<void> updateMobileNum(UserEntity mobile) {
    final toModel = UserModel.fromEntity(mobile);
    return profileLocalDatasource.updateMobileNum(toModel);
  }

  @override
  Future<void> updatePass(UserEntity password) {
    final toModel = UserModel.fromEntity(password);
    return profileLocalDatasource.updatePass(toModel);
  }
}
