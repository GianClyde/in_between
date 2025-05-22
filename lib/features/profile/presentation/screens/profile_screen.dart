import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:in_between/core/cubit/user_cubit.dart';
import 'package:in_between/core/routes/app_router.dart';
import 'package:in_between/core/widgets/images.dart';
import 'package:in_between/core/widgets/outlined_button_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerLeft,
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
              ),
            ],
          ),
          Text('PROFILE', style: TextStyle(fontSize: 40, color: Colors.white)),
          Divider(height: 22, color: Colors.transparent),
          SizedBox(
            height: 150,
            width: 150,
            child: Image.asset(ImagePaths.userPic.path),
          ),
          Text(user!.name, style: TextStyle(fontSize: 20, color: Colors.white)),
          // Text('Username:', style: TextStyle(decorationStyle: ),),
          Text(
            user.username,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          Text(
            user.password,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          Text(user.bdate, style: TextStyle(fontSize: 16, color: Colors.white)),
          Text(
            user.mobile,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),

          Spacer(),
          ButtonWidget(
            label: 'LOGOUT',
            onPressed: () {
              context.go(Routes.loginScreen);
              print('Logout Clicked');
            },
          ),
        ],
      ),
    );
  }
}
