import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:in_between/core/cubit/user_cubit.dart';
import 'package:in_between/core/widgets/images.dart';
import 'package:in_between/features/authentication/presentation/screens/forgetpass_screen.dart';
import 'package:in_between/features/authentication/presentation/screens/login_screen.dart';
import 'package:in_between/features/game_zone.dart';
import 'package:in_between/features/home/presentation/screens/home_screen.dart';
import 'package:in_between/features/profile/presentation/screens/profile_screen.dart';
import 'package:in_between/features/registration/presentation/screens/registration_screen.dart';
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
        final credit = context.watch<UserCubit>().state;
        return SafeArea(
          child: Scaffold(
            appBar:
                showAppBar
                    ? AppBar(
                      backgroundColor: Colors.black,
                      iconTheme: IconThemeData(color: Colors.white),
                      actions: [
                        Text(
                          'Php ${credit!.credits.toString()}',
                          style: TextStyle(color: Colors.white),
                        ),
                        IconButton(
                          onPressed: () {
                            context.push(Routes.cashinoutScreen);
                          },
                          icon: Icon(Icons.add_box_rounded),
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
          path: Routes.cashinoutScreen,
          builder: (context, state) => CashInOutScreen(),
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
          path: Routes.gameZoneScreen,
          builder: (context, state) => GameZone(),
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
  static const String gameZoneScreen = '/gameZoneScreen';
}
