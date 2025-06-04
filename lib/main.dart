import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_between/core/cubit/user_cubit.dart';
import 'package:in_between/core/routes/app_router.dart';
import 'package:in_between/dependecy_injection.dart';
import 'package:in_between/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:in_between/features/registration/presentation/bloc/registration_bloc.dart';
import 'package:in_between/features/waiting_room/presentation/cubit/waiting_room_cubit.dart';
import 'package:in_between/features/wallet/presentation/bloc/wallet_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setUpDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<RegistrationBloc>()),
        BlocProvider(create: (context) => sl<AuthBloc>()),
        BlocProvider<UserCubit>(create: (context) => sl<UserCubit>()),
        BlocProvider(create: (context) => sl<WalletBloc>()),
        BlocProvider(create: (context) => sl<WaitingRoomCubit>()),
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
