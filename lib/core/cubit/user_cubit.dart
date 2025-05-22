import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_between/core/domain/user_entity.dart';

class UserCubit extends Cubit<UserEntity?> {
  UserCubit() : super(null);
  void setUser(UserEntity user) => emit(user);

  void clearUser() => emit(null);
}
