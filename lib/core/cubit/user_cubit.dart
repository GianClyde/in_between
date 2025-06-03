import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/features/profile/domain/usecase/update_email_usecase.dart';
import 'package:in_between/features/profile/domain/usecase/update_mobilenum_usecase.dart';
import 'package:in_between/features/profile/domain/usecase/update_pass_usecase.dart';

class UserCubit extends Cubit<UserEntity?> {
  final UpdateEmailUsecase updateEmailUsecase;
  final UpdateMobilenumUsecase updateMobilenumUsecase;
  final UpdatePassUsecase updatePassUsecase;
  UserCubit({
    required this.updateEmailUsecase,
    required this.updateMobilenumUsecase,
    required this.updatePassUsecase,
  }) : super(null);

  void setUser(UserEntity user) => emit(user);

  void clearUser() => emit(null);

  Future<void> updateEmail(String newEmail) async {
    if (state == null) return;
    final updatedEmail = state!.copyWith(email: newEmail);
    await updateEmailUsecase.execute(updatedEmail);

    emit(updatedEmail);
  }

  Future<void> updateMobileNum(String newMobileNum) async {
    if (state == null) return;
    final updatedMobileNum = state!.copyWith(mobile: newMobileNum);
    await updateMobilenumUsecase.execute(updatedMobileNum);
    emit(updatedMobileNum);
  }

  Future<void> updatePass(String newPass) async {
    if (state == null) return;
    final updatedPass = state!.copyWith(password: newPass);
    await updatePassUsecase.execute(updatedPass);
    emit(updatedPass);
  }
}
