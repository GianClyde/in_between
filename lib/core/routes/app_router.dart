import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:in_between/core/cubit/user_cubit.dart';
import 'package:in_between/core/widgets/images.dart';
import 'package:in_between/features/authentication/presentation/screens/forgetpass_screen.dart';
import 'package:in_between/features/authentication/presentation/screens/login_screen.dart';
import 'package:in_between/features/game_zone.dart';
import 'package:in_between/features/home/presentation/screens/home_screen.dart';
import 'package:in_between/features/profile/presentation/screens/edit_profile_details_screen.dart';
import 'package:in_between/features/profile/presentation/screens/profile_screen.dart';
import 'package:in_between/features/registration/presentation/screens/registration_screen.dart';
import 'package:in_between/features/waiting_room/presentation/screens/waiting_room_screen.dart';
import 'package:in_between/features/wallet/presentation/screens/cash_in_out_screen.dart';
import 'package:in_between/features/wallet/presentation/screens/cash_out_screen.dart';

final editEmailController = TextEditingController();
final editPasswordController = TextEditingController();
final editMobileController = TextEditingController();
late dynamic fieldToEdit;

final GoRouter router = GoRouter(
  initialLocation: Routes.loginScreen,
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        final showAppBar = state.fullPath == Routes.homeScreen;
        final walletScreen = state.fullPath == Routes.cashinoutScreen;
        final credit = context.watch<UserCubit>().state;
        return SafeArea(
          child:
              walletScreen
                  ? DefaultTabController(
                    length: 2,
                    child: Scaffold(
                      appBar: AppBar(
                        backgroundColor: Colors.black,
                        toolbarTextStyle: TextStyle(color: Colors.white),
                        iconTheme: IconThemeData(color: Colors.white),
                        centerTitle: true,
                        title: Text(
                          'Wallet',
                          style: TextStyle(color: Colors.white),
                        ),
                        leading: IconButton(
                          onPressed: () {
                            context.go(Routes.homeScreen);
                          },
                          icon: Icon(Icons.arrow_back_ios_new),
                        ),
                        bottom: const TabBar(
                          tabs: [Tab(text: 'Cash In'), Tab(text: 'Cash Out')],
                        ),
                      ),
                      body: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(ImagePaths.bg.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: TabBarView(
                          children: [CashInOutScreen(), CashOutScreen()],
                        ),
                      ),
                    ),
                  )
                  : Scaffold(
                    appBar:
                        showAppBar
                            ? AppBar(
                              backgroundColor: Colors.black,
                              iconTheme: IconThemeData(color: Colors.white),
                              leading: IconButton(
                                onPressed: () {
                                  context.push(Routes.profileScreen);
                                },
                                icon: Icon(Icons.account_circle_outlined),
                              ),
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
        GoRoute(
          path: Routes.editProfileScreen,
          builder: (context, state) {
            final extra = state.extra! as Map<String, dynamic>;
            return EditProfileDetailsScreen(
              editEmailController: editEmailController,
              editPasswordController: editPasswordController,
              editMobileController: editMobileController,
              fieldToEdit: extra['fieldToEdit'],
            );
          },
        ),
        GoRoute(
          path: Routes.waitingRoomScreen,
          builder: (context, state) => WaitingRoomScreen(),
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
  static const String editProfileScreen = '/editProfileScreen';
  static const String waitingRoomScreen = '/waitingRoomScreen';
}
