import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:in_between/core/cubit/user_cubit.dart';
import 'package:in_between/core/model/user_model.dart';
import 'package:in_between/features/authentication/data/data_source/auth_local_datasource.dart';
import 'package:in_between/features/authentication/data/data_source/auth_remote_datasource.dart';
import 'package:in_between/features/authentication/data/repository/auth_repo_imp.dart';
import 'package:in_between/features/authentication/domain/repository/i_auth_repo.dart';
import 'package:in_between/features/authentication/domain/usecase/get_user_usecase.dart';
import 'package:in_between/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:in_between/features/profile/domain/user_profile_repo.dart';
import 'package:in_between/features/profile/presentation/bloc/user_profile_bloc.dart';
import 'package:in_between/features/registration/data/data_source/registration_local_datasource.dart';
import 'package:in_between/features/registration/data/data_source/registration_remote_datasource.dart';
import 'package:in_between/features/registration/data/repository/registration_repo_imp.dart';
import 'package:in_between/features/registration/domain/repository/i_reg_repo.dart';
import 'package:in_between/features/registration/domain/usecase/add_new_user_usecase.dart';
import 'package:in_between/features/registration/domain/usecase/check_user_use_case.dart';
import 'package:in_between/features/registration/presentation/bloc/registration_bloc.dart';
import 'package:in_between/features/wallet/data/datasource/wallet_local_datasource.dart';
import 'package:in_between/features/wallet/data/repository/wallet_imp_repo.dart';
import 'package:in_between/features/wallet/domain/repository/i_wallet_repo.dart';
import 'package:in_between/features/wallet/domain/usecase/update_credit_usecase.dart';
import 'package:in_between/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

final sl = GetIt.instance;
//  GetIt sl = GetIt.instance;

Future<void> setUpDependencies() async {
  await Hive.initFlutter();

  Hive.registerAdapter(UserModelAdapter());

  if (!Hive.isBoxOpen('userBox')) {
    await Hive.openBox<UserModel>('userBox');
  }
  // final userBox = await Hive.openBox<UserModel>('userBox')

  sl.registerLazySingleton<Box<UserModel>>(
    () => Hive.box<UserModel>('userBox'),
  );

  //data source
  sl.registerLazySingleton(() => RegistrationLocalDatasource());
  sl.registerLazySingleton(() => AuthenticationLocalDatasource());
  sl.registerLazySingleton(() => WalletLocalDatasource());

  //remote data source
  sl.registerFactory<RegisterRemoteDataSource>(
    () => RegistrationRemoteDatasourceImpl(channel: sl()),
  );

  sl.registerFactory<AuthRemoteDatasource>(
    () => AuthRemoteDataSourceImpl(channel: sl()),
  );

  //channel
  sl.registerLazySingleton<WebSocketChannel>(() {
    final channel = IOWebSocketChannel.connect('ws://192.168.1.3:8080');
    return channel;
  }, dispose: (channel) => channel.sink.close());

  //repository
  sl.registerLazySingleton<RegistrationRepoImp>(
    () => RegistrationRepoImp(
      localDatasource: sl(),
      registerRemoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<IRegistrationRepo>(
    () => RegistrationRepoImp(
      localDatasource: sl(),
      registerRemoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<IAuthenticationRepo>(
    () => AuthenticationRepoImplementation(
      localDatasource: sl(),
      authRemoteDatasource: sl(),
    ),
  );

  sl.registerLazySingleton<UserProfileRepo>(() => UserProfileRepo());
  sl.registerLazySingleton<IWalletRepo>(() => WalletImpRepo(sl()));

  //usecases
  sl.registerLazySingleton<AddNewUserUseCase>(() => AddNewUserUseCase(sl()));
  sl.registerLazySingleton<CheckUserUseCase>(() => CheckUserUseCase(sl()));
  sl.registerLazySingleton(() => GetUserUsecase(sl()));
  sl.registerLazySingleton(() => UpdateCreditUsecase(sl()));

  //register bloc
  sl.registerFactory<RegistrationBloc>(() => RegistrationBloc(sl(), sl()));
  sl.registerFactory<AuthBloc>(() => AuthBloc(getUserUsecase: sl()));
  sl.registerFactory<UserProfileBloc>(() => UserProfileBloc(sl()));
  sl.registerFactory<UserCubit>(() => UserCubit());
  sl.registerFactory<WalletBloc>(() => WalletBloc(sl()));
}
