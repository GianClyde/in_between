import 'package:go_router/go_router.dart';
import 'package:in_between/features/authentication/presentation/screens/forgetpass_screen.dart';

import 'package:in_between/features/authentication/presentation/screens/login_screen.dart';
import 'package:in_between/features/game_zone.dart';
import 'package:in_between/features/home/presentation/screens/home_screen.dart';
import 'package:in_between/features/profile/presentation/screens/profile_screen.dart';
import 'package:in_between/features/registration/presentation/screens/registration_screen.dart';
import 'package:in_between/features/wallet/presentation/screens/cash_in_out.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: Routes.registrationScreen,
      builder: (context, state) => RegistrationScreen(),
    ),
    GoRoute(path: Routes.homeScreen, builder: (context, state) => HomeScreen()),
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
