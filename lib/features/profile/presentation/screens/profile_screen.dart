import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:in_between/core/routes/app_router.dart';
import 'package:in_between/core/widgets/images.dart';
import 'package:in_between/core/widgets/outlined_button_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            context.go(Routes.homeScreen);
          },
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('PROFILE', style: TextStyle(fontSize: 40)),
              Divider(height: 22, color: Colors.transparent),
              SizedBox(
                height: 150,
                width: 150,
                child: Image.asset(ImagePaths.userPic.path),
              ),
              Text('Gian Clyde Nanquil', style: TextStyle(fontSize: 20)),
              // Text('@gianclyde'),
              // Text('09999999999'),
              // Text('April 14, 2000'),
              // Text('Php 100000'),
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
        ),
      ),
    );
  }
}
