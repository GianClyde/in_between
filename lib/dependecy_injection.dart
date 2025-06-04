import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:in_between/core/cubit/user_cubit.dart';
import 'package:in_between/features/authentication/data/data_source/auth_local_datasource.dart';
import 'package:in_between/features/authentication/data/repository/auth_repo_imp.dart';
import 'package:in_between/features/authentication/domain/repository/i_auth_repo.dart';
import 'package:in_between/features/authentication/domain/usecase/authenticate_user_usecase.dart';
import 'package:in_between/features/authentication/domain/usecase/get_user_usecase.dart';
import 'package:in_between/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:in_between/features/profile/data/datasource/profile_datasource.dart';
import 'package:in_between/features/profile/data/repository/profile_imp_repo.dart';
import 'package:in_between/features/profile/domain/repository/i_profile_repo.dart';
import 'package:in_between/features/profile/domain/usecase/update_email_usecase.dart';
import 'package:in_between/features/profile/domain/usecase/update_mobilenum_usecase.dart';
import 'package:in_between/features/profile/domain/usecase/update_pass_usecase.dart';
import 'package:in_between/features/profile/domain/user_profile_repo.dart';
import 'package:in_between/features/registration/data/data_source/registration_local_datasource.dart';
import 'package:in_between/features/registration/data/repository/registration_repo_imp.dart';
import 'package:in_between/features/registration/domain/repository/i_reg_repo.dart';
import 'package:in_between/features/registration/domain/usecase/add_new_user_usecase.dart';
import 'package:in_between/features/registration/domain/usecase/check_user_use_case.dart';
import 'package:in_between/features/registration/presentation/bloc/registration_bloc.dart';
import 'package:in_between/core/model/user_model.dart';
import 'package:in_between/features/waiting_room/data/datasource/waiting_room_datasource.dart';
import 'package:in_between/features/waiting_room/data/repository/waiting_room_repo_imp.dart';
import 'package:in_between/features/waiting_room/domain/repository/i_waiting_room_repo.dart';
import 'package:in_between/features/waiting_room/domain/usecase/waiting_room_usecase.dart';
import 'package:in_between/features/waiting_room/presentation/cubit/waiting_room_cubit.dart';
import 'package:in_between/features/wallet/data/datasource/wallet_local_datasource.dart';
import 'package:in_between/features/wallet/data/repository/wallet_imp_repo.dart';
import 'package:in_between/features/wallet/domain/repository/i_wallet_repo.dart';
import 'package:in_between/features/wallet/domain/usecase/update_credit_usecase.dart';
import 'package:in_between/features/wallet/presentation/bloc/wallet_bloc.dart';

final sl = GetIt.instance;

Future<void> setUpDependencies() async {
  await Hive.initFlutter();

  Hive.registerAdapter(UserModelAdapter());

  if (!Hive.isBoxOpen('userBox')) {
    await Hive.openBox<UserModel>('userBox');
  }

  sl.registerLazySingleton<Box<UserModel>>(
    () => Hive.box<UserModel>('userBox'),
  );

  //data source
  sl.registerLazySingleton(() => RegistrationLocalDatasource());
  sl.registerLazySingleton(() => AuthenticationLocalDatasource());
  sl.registerLazySingleton(() => WalletLocalDatasource());
  sl.registerLazySingleton(() => ProfileDatasource());
  sl.registerLazySingleton(() => WaitingRoomDatasource());

  //repository
  sl.registerLazySingleton<RegistrationRepoImp>(
    () => RegistrationRepoImp(sl()),
  );
  sl.registerLazySingleton<AuthenticationRepoImplementation>(
    () => AuthenticationRepoImplementation(sl()),
  );
  sl.registerLazySingleton<ProfileImpRepo>(() => ProfileImpRepo(sl()));

  sl.registerLazySingleton<IRegistrationRepo>(() => RegistrationRepoImp(sl()));
  sl.registerLazySingleton<IAuthenticationRepo>(
    () => AuthenticationRepoImplementation(sl()),
  );

  sl.registerLazySingleton<UserProfileRepo>(() => UserProfileRepo());
  sl.registerLazySingleton<IWalletRepo>(() => WalletImpRepo(sl()));

  sl.registerLazySingleton<IProfileRepo>(() => ProfileImpRepo(sl()));
  sl.registerLazySingleton<IWaitingRoomRepo>(() => WaitingRoomRepoImp(sl()));

  //usecases
  sl.registerLazySingleton<AddNewUserUseCase>(() => AddNewUserUseCase(sl()));
  sl.registerLazySingleton<CheckUserUseCase>(() => CheckUserUseCase(sl()));
  sl.registerLazySingleton(() => AuthenticateUserUsecase(sl()));
  sl.registerLazySingleton(() => GetUserUsecase(sl()));
  sl.registerLazySingleton(() => UpdateCreditUsecase(sl()));
  sl.registerLazySingleton(() => UpdateEmailUsecase(sl()));
  sl.registerLazySingleton(() => UpdatePassUsecase(sl()));
  sl.registerLazySingleton(() => UpdateMobilenumUsecase(sl()));
  sl.registerLazySingleton(() => WaitingRoomUsecase(sl()));

  //register bloc
  sl.registerFactory<RegistrationBloc>(() => RegistrationBloc(sl(), sl()));
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(authenticateUserUsecase: sl(), getUserUsecase: sl()),
  );
  sl.registerFactory<UserCubit>(
    () => UserCubit(
      updateEmailUsecase: sl(),
      updateMobilenumUsecase: sl(),
      updatePassUsecase: sl(),
    ),
  );
  sl.registerFactory<WalletBloc>(() => WalletBloc(sl()));
  sl.registerFactory<WaitingRoomCubit>(() => WaitingRoomCubit(sl()));
}
