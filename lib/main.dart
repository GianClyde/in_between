import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_between/core/cubit/user_cubit.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:in_between/core/model/user_model.dart';
import 'package:in_between/core/routes/app_router.dart';
import 'package:in_between/dependecy_injection.dart';
import 'package:in_between/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:in_between/features/home/presentation/bloc/bloc/home_bloc.dart';
import 'package:in_between/features/profile/presentation/bloc/user_profile_bloc.dart';
import 'package:in_between/features/registration/data/repository/registration_repo_imp.dart';
import 'package:in_between/features/registration/domain/repository/i_reg_repo.dart';
import 'package:in_between/features/registration/presentation/bloc/registration_bloc.dart';
import 'package:in_between/features/wallet/presentation/bloc/wallet_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setUpDependencies();

  print(
    "Is RegistrationBloc registered? ${sl.isRegistered<RegistrationBloc>()}",
  ); // Debugging check
  print(
    "Is IRegistrationRepo registered? ${sl.isRegistered<IRegistrationRepo>()}",
  );
  print(
    "Is RegistrationRepoImp registered? ${sl.isRegistered<RegistrationRepoImp>()}",
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<RegistrationBloc>()),
        BlocProvider(create: (context) => sl<AuthBloc>()),
        BlocProvider(create: (context) => sl<UserProfileBloc>()),
        BlocProvider<UserCubit>(create: (context) => sl<UserCubit>()),
        BlocProvider(create: (context) => sl<WalletBloc>()),
        BlocProvider(create: (context) => sl<HomeBloc>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'In Between',
        routerConfig: router,
        theme: ThemeData(
          textTheme: GoogleFonts.girassolTextTheme().apply(
            bodyColor: Colors.white,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
      ),
    );
  }
}
