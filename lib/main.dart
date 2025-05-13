import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:in_between/core/model/user_model.dart';
import 'package:in_between/core/routes/app_router.dart';
import 'package:in_between/features/authentication/domain/auth_repo.dart';
import 'package:in_between/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:in_between/features/profile/domain/user_profile_repo.dart';
import 'package:in_between/features/profile/presentation/bloc/user_profile_bloc.dart';
import 'package:in_between/features/registration/domain/registration_repo.dart';
import 'package:in_between/features/registration/presentation/bloc/registration_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>('registrationBox');

  final authRepo = Authrepo();
  final registerRepo = RegistrationRepo();
  final userProfileRepo = UserProfileRepo();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(authRepo)..add(GetUser())),
        BlocProvider(
          create: (context) => RegistrationBloc(registerRepo)..add(LoadUsers()),
        ),
        BlocProvider(create: (context) => UserProfileBloc(userProfileRepo)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'In Between',
      routerConfig: router,
      theme: ThemeData(
        textTheme: GoogleFonts.girassolTextTheme().apply(
          bodyColor: Colors.white,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: SafeArea(child: CashInOutScreen()),
    );
  }
}
