import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:in_between/core/cubit/user_cubit.dart';
// import 'package:in_between/core/cubit/user_cubit.dart';
import 'package:in_between/core/routes/app_router.dart';
import 'package:in_between/core/widgets/images.dart';
import 'package:in_between/core/widgets/outlined_button_widget.dart';
import 'package:in_between/core/widgets/textbutton_widget.dart';
import 'package:in_between/core/widgets/textfield_widget.dart';
import 'package:in_between/features/authentication/presentation/bloc/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController loginUsernameController = TextEditingController();
    TextEditingController loginPasswordController = TextEditingController();

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UserLoaded) {
          context.read<UserCubit>().setUser(state.users);
          context.go(Routes.homeScreen);
        } else if (state is UserInvalid || state is UserNotLoaded) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Invalid Credentials')));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: Image.asset(ImagePaths.logo.path),
            ),

            Text('LOGIN', style: TextStyle(fontSize: 40)),
            Divider(height: 22, color: Colors.transparent),

            TextFieldWidget(
              controller: loginUsernameController,
              label: 'Username',
            ),
            Divider(height: 21, color: Colors.transparent),

            TextFieldWidget(
              controller: loginPasswordController,
              label: 'Password',
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButtonWidget(
                    onPressed: () {
                      context.go(Routes.forgetPassScreen);

                      print('Forgot pass clicked');
                    },
                    label: 'Forgot Password?',
                    textColor: Color(0xffAFAFAF),
                  ),
                ],
              ),
            ),
            Divider(height: 35, color: Colors.transparent),

            ButtonWidget(
              label: 'login',
              onPressed: () {
                final username = loginUsernameController.text.trim();
                final password = loginPasswordController.text.trim();
                if (username.isNotEmpty && password.isNotEmpty) {
                  context.read<AuthBloc>().add(
                    LoginRequest(username, password),
                  );
                }
              },
            ),
            Spacer(),
            Row(
              spacing: 0,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an account yet?'),
                TextButtonWidget(
                  label: 'Register Here!',
                  textColor: Color(0xffffb53d),
                  onPressed: () {
                    context.go(Routes.registrationScreen);

                    print('Register Here! clicked');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
