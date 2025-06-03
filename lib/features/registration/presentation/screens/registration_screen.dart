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

            // TextFieldWidget(
            //   controller: regBdateController,
            //   tag: 'Birthdate',
            //   label: 'Input Date',
            //   isDigitOnly: true,
            // ),
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
                  final bdate =
                      '${selectedBdate!.year} - ${selectedBdate!.month} - ${selectedBdate!.day}';

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
                        bdate: bdate.toString(),
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

class DropDownDatePickerWidget extends StatefulWidget {
  final void Function(DateTime) onSelectedDate;
  const DropDownDatePickerWidget({super.key, required this.onSelectedDate});

  @override
  State<DropDownDatePickerWidget> createState() =>
      _DropDownDatePickerWidgetState();
}

class _DropDownDatePickerWidgetState extends State<DropDownDatePickerWidget> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${selectedDate.year} - ${selectedDate.month} - ${selectedDate.day}',
          ),
          ElevatedButton(
            onPressed: () async {
              final DateTime? dateTime = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
              );
              if (dateTime != null) {
                setState(() {
                  selectedDate = dateTime;
                });
                widget.onSelectedDate(dateTime);
              }
            },
            child: Text('Date'),
          ),
        ],
      ),
    );
  }
}
