import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:in_between/core/cubit/user_cubit.dart';
import 'package:in_between/core/routes/app_router.dart';
import 'package:in_between/core/widgets/outlined_button_widget.dart';
import 'package:in_between/core/widgets/password_textfield_widget.dart';
import 'package:in_between/core/widgets/textfield_widget.dart';

class EditProfileDetailsScreen extends StatelessWidget {
  final TextEditingController editEmailController;
  final TextEditingController editPasswordController;
  final TextEditingController editMobileController;
  final String fieldToEdit;
  const EditProfileDetailsScreen({
    super.key,
    required this.editEmailController,
    required this.editMobileController,
    required this.editPasswordController,
    required this.fieldToEdit,
  });

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state!;
    final currentPasswordController = TextEditingController();

    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Colors.black,
          child: Row(
            children: [
              Align(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: IconButton(
                    onPressed: () {
                      context.go(Routes.profileScreen);
                    },
                    icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'EDIT PROFILE',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
            ],
          ),
        ),

        Column(
          children: [
            _buildEditProfileContents(fieldToEdit, context),
            PasswordTextfieldWidget(
              label: 'Enter CURRENT Password',
              passwordController: currentPasswordController,
            ),

            Text('Please input your CURRENT password to confirm changes'),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: ButtonWidget(
                label: 'Submit',
                onPressed: () async {
                  if (currentPasswordController.text == user.password) {
                    final cubit = context.read<UserCubit>();
                    print('this is the fieldToEdit = $fieldToEdit');
                    switch (fieldToEdit) {
                      case 'email':
                        cubit.updateEmail(editEmailController.text);
                        print('Updated Email');

                        break;
                      case 'mobile':
                        cubit.updateMobileNum(editMobileController.text);
                        print('Updated mobile');

                        break;
                      case 'password':
                        cubit.updatePass(editPasswordController.text);
                        print('Updated Password');

                        break;
                    }

                    context.go(Routes.profileScreen);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Incorrect password')),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Widget _buildEditProfileContents(String field, BuildContext context) {
  switch (field) {
    case 'email':
      return Column(
        children: [
          Text('You\'re about to change your email address'),

          TextFieldWidget(
            label: 'Enter new Email',
            controller: editEmailController,
            isDigitOnly: false,
          ),
        ],
      );

    case 'mobile':
      return Column(
        children: [
          Text('You\'re about to change your Mobile Number'),

          TextFieldWidget(
            label: 'Enter new Mobile Number',
            controller: editMobileController,
            isDigitOnly: true,
          ),
        ],
      );

    case 'password':
      return Column(
        children: [
          Text('You\'re about to change your password'),

          TextFieldWidget(
            label: 'Enter new Password',
            controller: editPasswordController,
            isDigitOnly: false,
          ),
        ],
      );
    default:
      return SizedBox(child: Text("On default di maread field mo"));
  }
}
