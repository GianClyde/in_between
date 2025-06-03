import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:in_between/core/cubit/user_cubit.dart';
import 'package:in_between/core/routes/app_router.dart';
import 'package:in_between/core/widgets/bordered_text_widget.dart';
import 'package:in_between/core/widgets/images.dart';
import 'package:in_between/core/widgets/outlined_button_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;
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
                      context.go(Routes.homeScreen);
                    },
                    icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'PROFILE',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        Divider(height: 25, color: Colors.transparent),
        SizedBox(
          height: 150,
          width: 150,
          child: Image.asset(ImagePaths.userPic.path),
        ),
        Text(
          user!.username,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),

        Container(
          margin: EdgeInsets.only(top: 12),
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BorderedText(
                text: user.name,
                onPressed: () {},
                isEditable: false,
              ),
              BorderedText(
                text: user.bdate,
                onPressed: () {},
                isEditable: false,
              ),
              BorderedText(
                text: user.email,
                onPressed: () {
                  editEmailController.text = user.email;
                  editPasswordController.text = user.password;

                  context.go(
                    Routes.editProfileScreen,
                    extra: {'fieldToEdit': 'email'},
                  );
                },
                isEditable: true,
              ), //editable

              BorderedText(
                text: user.mobile,
                onPressed: () {
                  editMobileController.text = user.mobile;
                  editPasswordController.text = user.password;

                  context.go(
                    Routes.editProfileScreen,
                    extra: {'fieldToEdit': 'mobile'},
                  );
                },
                isEditable: true,
              ), //editable
              BorderedText(
                text: '*' * user.password.length,
                onPressed: () {
                  editPasswordController.clear();

                  context.go(
                    Routes.editProfileScreen,
                    extra: {'fieldToEdit': 'password'},
                  );
                },
                isEditable: true,
              ), //editable //pati username i guess
            ],
          ),
        ),

        Container(
          margin: EdgeInsets.only(top: 30),
          child: ButtonWidget(
            label: 'LOGOUT',
            onPressed: () {
              context.go(Routes.loginScreen);
              print('Logout Clicked');
            },
          ),
        ),
      ],
    );
  }
}
