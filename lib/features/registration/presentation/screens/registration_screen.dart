import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/core/routes/app_router.dart';
import 'package:in_between/core/widgets/outlined_button_widget.dart';
import 'package:in_between/core/widgets/password_textfield_widget.dart';
import 'package:in_between/core/widgets/textbutton_widget.dart';
import 'package:in_between/core/widgets/textfield_widget.dart';
import 'package:in_between/features/registration/presentation/bloc/registration_bloc.dart';

import '../widgets/date_picker_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController regUsernameController = TextEditingController();
  final TextEditingController regPasswordController = TextEditingController();
  final TextEditingController regmobilenumController = TextEditingController();
  final TextEditingController regNameController = TextEditingController();
  final TextEditingController regBdateController = TextEditingController();
  final TextEditingController regEmailController = TextEditingController();
  DateTime? selectedBdate;

  @override
  void dispose() {
    regUsernameController.dispose();
    regPasswordController.dispose();
    regmobilenumController.dispose();
    regNameController.dispose();
    regBdateController.dispose();
    regEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state is RegistrationSuccess) {
          print('Registered Successfully');
          context.go(Routes.loginScreen);
        } else if (state is RegistrationFail) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('User Exists')));
        } else if (state is RegistrationIncomplete) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Please fill in all fields!')));
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 130,
              width: 150,
              child: Image.asset('assets/images/logo.png'),
            ),

            Text('REGISTRATION', style: TextStyle(fontSize: 35)),

            TextFieldWidget(
              controller: regNameController,
              tag: 'Name',
              label: 'Input Name',
              isDigitOnly: false,
            ),

            TextFieldWidget(
              controller: regUsernameController,
              tag: 'Username',
              label: 'Create Username',
              isDigitOnly: false,
            ),

            TextFieldWidget(
              controller: regEmailController,
              tag: 'Email',
              label: 'Input Email',
              isDigitOnly: false,
            ),

            PasswordTextfieldWidget(
              label: 'Create Password',
              tag: 'Password',
              passwordController: regPasswordController,
            ),

            TextFieldWidget(
              controller: regmobilenumController,
              tag: 'Mobile',
              label: 'Input Mobile Number',
              isDigitOnly: true,
            ),

            Divider(height: 8, color: Colors.transparent),
            DropDownDatePickerWidget(
              onSelectedDate: (bdate) {
                setState(() {
                  selectedBdate = bdate;
                });
              },
            ),

            Container(
              margin: EdgeInsets.only(top: 15),
              child: ButtonWidget(
                label: 'Register',
                onPressed: () {
                  final name = regNameController.text.trim();
                  final username = regUsernameController.text.trim();
                  final password = regPasswordController.text.trim();
                  final mobile = regmobilenumController.text.trim();

                  if (selectedBdate == null) {
                    print('Select date');
                    return;
                  }

                  final now = DateTime.now();
                  final age =
                      now.year -
                      selectedBdate!.year -
                      ((now.month < selectedBdate!.month ||
                              (now.month == selectedBdate!.month &&
                                  now.day < selectedBdate!.day))
                          ? 1
                          : 0);
                  if (age < 18) {
                    print("should be at least 18");
                    return;
                  }

                  final bdate =
                      '${selectedBdate!.year}/${selectedBdate!.month}/${selectedBdate!.day}';

                  final email = regEmailController.text.trim();

                  if ([
                    name,
                    username,
                    password,
                    mobile,
                    bdate,
                    email,
                  ].any((field) => field.isEmpty)) {
                    context.read<RegistrationBloc>().add(IncompleteField());
                    return;
                  }

                  context.read<RegistrationBloc>().add(
                    AddUser(
                      UserEntity(
                        name: name,
                        username: username,
                        mobile: mobile,
                        password: password,
                        bdate: bdate,
                        credits: 0,
                        email: email,
                      ),
                    ),
                  );

                  print('Registered Clicked');
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?'),
                TextButtonWidget(
                  label: 'Login Here!',
                  textColor: Color(0xffffb53d),
                  onPressed: () {
                    context.go(Routes.loginScreen);
                    print('Login Here! clicked from reg  screen');
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
