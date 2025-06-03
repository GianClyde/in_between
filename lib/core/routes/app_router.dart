import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:in_between/core/cubit/user_cubit.dart';
import 'package:in_between/core/widgets/images.dart';
import 'package:in_between/features/authentication/presentation/screens/forgetpass_screen.dart';
import 'package:in_between/features/authentication/presentation/screens/login_screen.dart';
import 'package:in_between/features/game_zone.dart';
import 'package:in_between/features/home/presentation/bloc/home_bloc.dart';
import 'package:in_between/features/home/presentation/screens/home_screen.dart';
import 'package:in_between/features/profile/presentation/screens/profile_screen.dart';
import 'package:in_between/features/registration/presentation/screens/registration_screen.dart';
import 'package:in_between/features/room/presentation/screen/dummy_screen.dart';
import 'package:in_between/features/room/presentation/screen/room_screen.dart';
import 'package:in_between/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:in_between/features/wallet/presentation/screens/cash_in_out_screen.dart';

// PreferredSizeWidget _appBarContents(UserEntity credit) {
//   var currentPath;
//   switch (currentPath) {
//     case Routes.cashinoutScreen:
//       return AppBar(
//         backgroundColor: Colors.black,
//         iconTheme: IconThemeData(color: Colors.white),
//         leading: IconButton(
//           onPressed: () {},
//           icon: Icon(Icons.arrow_back_ios_new),
//         ),
//         title: Text('Wallet'),
//         centerTitle: true,
//       );

//     case Routes.homeScreen:
//       return AppBar(
//         backgroundColor: Colors.black,
//         iconTheme: IconThemeData(color: Colors.white),
//         actions: [
//           Text(
//             'Php ${credit!.credits.toString()}',
//             style: TextStyle(color: Colors.white),
//           ),
//           IconButton(
//             onPressed: () {
//               context.push(Routes.cashinoutScreen);
//             },
//             icon: Icon(Icons.add_box_rounded),
//           ),
//         ],
//       );
//   }
// }

final GoRouter router = GoRouter(
  initialLocation: '/loginScreen',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        final showAppBar = state.fullPath == Routes.homeScreen;
        final showDrawer = state.fullPath == Routes.homeScreen;
        // final credit = context.watch<UserCubit>().state;
        return SafeArea(
          child: Scaffold(
            appBar:
                showAppBar
                    ? AppBar(
                      backgroundColor: Colors.black,
                      iconTheme: IconThemeData(color: Colors.white),
                      actions: [
                        BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            if (state is HomeUserWalletFetchedSuccess) {
                              return Text(
                                'Php ${state.userWallet.balance}', //PUT THE WALLET BALANC HERE
                                style: TextStyle(color: Colors.white),
                              );
                            } else {
                              return Text("Error Retieving Wallet");
                            }
                          },
                        ),
                        BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            if (state is HomeUserWalletFetchedSuccess) {
                              return IconButton(
                                onPressed: () {
                                  context.push(
                                    "${Routes.cashinoutScreen}/${state.userWallet.walletId}",
                                  ); //FIX THIS
                                },
                                icon: Icon(Icons.add_box_rounded),
                              );
                            } else {
                              return SizedBox.shrink();
                            }
                          },
                        ),
                      ],
                    )
                    : null,
            drawer:
                showDrawer
                    ? Drawer(
                      backgroundColor: Color(0xffffb53d),
                      child: ListView(
                        children: [
                          ListTile(
                            leading: Icon(Icons.person),
                            title: Text("Profile"),
                            onTap: () {
                              print("profile tile clicked");

                              context.push(Routes.profileScreen);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.settings),
                            title: Text("Settings"),
                            onTap: () {},
                          ),
                        ],
                      ),
                    )
                    : null,

            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImagePaths.bg.path),
                  fit: BoxFit.cover,
                ),
              ),
              child: child,
            ),
          ),
        );
      },
      routes: [
        GoRoute(
          path: Routes.registrationScreen,
          builder: (context, state) => RegistrationScreen(),
        ),
        GoRoute(
          path: Routes.homeScreen,
          builder: (context, state) => HomeScreen(),
        ),
        GoRoute(
          path: "/${Routes.cashinoutScreen}/:walletId",
          builder: (context, state) {
            final walletId = state.pathParameters['walletId'] as String;
            return CashInOutScreen(walletId: walletId);
          },
        ),
        GoRoute(
          path: Routes.forgetPassScreen,
          builder: (context, state) => ForgetpassScreen(),
        ),
        GoRoute(
          path: Routes.loginScreen,
          builder: (context, state) => LoginScreen(),
        ),
        GoRoute(
          path: Routes.profileScreen,
          builder: (context, state) => ProfileScreen(),
        ),
        GoRoute(
          path: "${Routes.roomScreen}/:roomId",
          builder: (context, state) {
            final roomId = state.pathParameters['roomId'] as String;
            return WaitingRoomScreen(roomId: roomId);
            // return DummyScreen(roomId: roomId);
          },
        ),
      ],
    ),
  ],
);

class Routes {
  static const String homeScreen = '/homeScreen';
  static const String cashinoutScreen = '/cashinoutScreen';
  static const String forgetPassScreen = '/forgetPassScreen';
  static const String loginScreen = '/loginScreen';
  static const String profileScreen = '/profileScreen';
  static const String registrationScreen = '/';
  static const String roomScreen = '/roomScreen';
}
