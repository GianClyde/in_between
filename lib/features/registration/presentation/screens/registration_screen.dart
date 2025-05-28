import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:in_between/core/model/user_model.dart';
import 'package:in_between/core/routes/app_router.dart';
import 'package:in_between/core/widgets/outlined_button_widget.dart';
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

  @override
  void dispose() {
    regUsernameController.dispose();
    regPasswordController.dispose();
    regmobilenumController.dispose();
    regNameController.dispose();
    regBdateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state is RegistrationSuccess) {
          print('Registered Successfully');
          context.go(Routes.loginScreen);
        } else if (state is RegistrationFailed) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is RegistrationIncomplete) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Please fill in all fields!')));
        }
      },
      builder: (BuildContext context, RegistrationState state) {
        if (state is RegistrationLoading) {
          return Center(child: CircularProgressIndicator());
        }

        return Padding(
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

              TextFieldWidget(
                controller: regNameController,
                tag: 'Name',
                label: 'Input Name',
              ),
              Divider(height: 15, color: Colors.transparent),

              TextFieldWidget(
                controller: regBdateController,
                tag: 'Birthdate',
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

                  if ([
                    name,
                    username,
                    password,
                    mobile,
                    bdate,
                  ].any((field) => field.isEmpty)) {
                    context.read<RegistrationBloc>().add(IncompleteField());
                    return;
                  }

                  context.read<RegistrationBloc>().add(
                    AddUser(
                      UserModel(
                        name: name,
                        username: username,
                        mobile: mobile,
                        password: password,
                        bdate: bdate,
                        credits: 0,
                      ),
                    ),
                  );

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
                      print('Login Here! clicked from reg  screen');
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
