import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:in_between/core/model/user_model.dart';
import 'package:in_between/core/routes/app_router.dart';
import 'package:in_between/core/widgets/outlined_button_widget.dart';
import 'package:in_between/core/widgets/textbutton_widget.dart';
import 'package:in_between/core/widgets/textfield_widget.dart';
import 'package:in_between/features/registration/presentation/bloc/registration_bloc.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController regUsernameController = TextEditingController();
    TextEditingController regPasswordController = TextEditingController();
    TextEditingController regmobilenumController = TextEditingController();
    TextEditingController regNameController = TextEditingController();
    TextEditingController regBdateController = TextEditingController();

    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state is RegistrationSuccess) {
          print('andito ako');
          context.go(Routes.loginScreen);
        } else if (state is RegistrationFail) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Ekis bobo kulang field mo')));
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg_image.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.asset('assets/images/logo.png'),
                ),
                Divider(height: 18, color: Colors.transparent),

                Text('REGISTRATION', style: TextStyle(fontSize: 40)),
                Divider(height: 18, color: Colors.transparent),

                // SizedBox(
                //   width: MediaQuery.of(context).size.width * 0.80,
                //   child: NameAgeTxtField(
                //     nameController: regNameController,
                //     birthdateController: regBdateController,
                //   ),
                // ),
                TextFieldWidget(
                  controller: regNameController,
                  tag: 'Name',
                  label: 'Input Name',
                ),
                Divider(height: 15, color: Colors.transparent),

                TextFieldWidget(
                  controller: regBdateController,
                  tag: 'Bithdate',
                  label: 'Input Date',
                ),
                Divider(height: 15, color: Colors.transparent),

                TextFieldWidget(
                  controller: regUsernameController,
                  tag: 'Username',
                  label: 'Create Username',
                ),
                Divider(height: 15, color: Colors.transparent),

                TextFieldWidget(
                  controller: regPasswordController,
                  tag: 'Password',
                  label: 'Create Password',
                ),

                Divider(height: 15, color: Colors.transparent),

                TextFieldWidget(
                  controller: regmobilenumController,
                  tag: 'Mobile',
                  label: 'Input Mobile Number',
                ),
                Divider(height: 35, color: Colors.transparent),

                ButtonWidget(
                  label: 'Register',
                  onPressed: () {
                    final name = regNameController.text.trim();
                    final username = regUsernameController.text.trim();
                    final password = regPasswordController.text.trim();
                    final mobile = regmobilenumController.text.trim();
                    final bdate = regBdateController.text.trim();

                    if (name.isNotEmpty &&
                        username.isNotEmpty &&
                        password.isNotEmpty &&
                        mobile.isNotEmpty &&
                        bdate.isNotEmpty) {
                      context.read<RegistrationBloc>().add(
                        AddUser(
                          UserModel(
                            name: name,
                            username: username,
                            mobile: mobile,
                            password: password,
                            bdate: bdate,
                          ),
                        ),
                      );
                    }

                    print('Registered Clicked');
                  },
                ),
                Spacer(),
                Row(
                  spacing: 0,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?'),
                    TextButtonWidget(
                      label: 'Login Here!',
                      textColor: Color(0xffffb53d),
                      onPressed: () {
                        context.go(Routes.loginScreen);
                        print('Login Here! clicked');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
