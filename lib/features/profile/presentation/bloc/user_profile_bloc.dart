import 'package:bloc/bloc.dart';
import 'package:in_between/core/model/user_model.dart';
import 'package:in_between/features/profile/domain/user_profile_repo.dart';
import 'package:meta/meta.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserProfileRepo userProfileRepo;
  UserProfileBloc(this.userProfileRepo) : super(UserProfileInitial()) {
    on<GetUserData>((event, emit) {
      final userProfile = userProfileRepo.getUsers().firstWhere(
        (user) =>
            user.username == event.username && user.password == event.password,
      );
      emit(UserDataLoaded([userProfile]));
    });
  }
}
