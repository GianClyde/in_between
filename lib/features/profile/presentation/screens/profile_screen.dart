import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:in_between/core/routes/app_router.dart';
import 'package:in_between/core/widgets/images.dart';
import 'package:in_between/core/widgets/outlined_button_widget.dart';
import 'package:in_between/features/profile/presentation/bloc/user_profile_bloc.dart';

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
        child: BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, state) {
            if (state is UserDataLoaded) {
              // final user = List.generate(state.userData.length,
              // (index)=> state.userData[index]);
              // final user
              final user =
                  state.userData.isNotEmpty ? state.userData.first : null;
              if (user == null) {
                return Center(
                  child: Text('No data', style: TextStyle(color: Colors.white)),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(
                      'PROFILE',
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                    Divider(height: 22, color: Colors.transparent),
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: Image.asset(ImagePaths.userPic.path),
                    ),
                    Text(
                      user.name,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      user.username,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Text(
                      user.password,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Text(
                      user.bdate,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
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
            } else {
              print('Tanga walang data');
            }
            return Container(); // wala lang para di mag error
          },
        ),
      ),
    );
  }
}

// Container(
//           width: double.infinity,
//           height: double.infinity,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage(ImagePaths.bg.path),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               // crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('PROFILE', style: TextStyle(fontSize: 40)),
//                 Divider(height: 22, color: Colors.transparent),
//                 SizedBox(
//                   height: 150,
//                   width: 150,
//                   child: Image.asset(ImagePaths.userPic.path),
//                 ),
//                 Text('Gian Clyde Nanquil', style: TextStyle(fontSize: 20)),
//                 // Text('@gianclyde'),
//                 // Text('09999999999'),
//                 // Text('April 14, 2000'),
//                 // Text('Php 100000'),
//                 Spacer(),
//                 ButtonWidget(
//                   label: 'LOGOUT',
//                   onPressed: () {
//                     context.go(Routes.loginScreen);
//                     print('Logout Clicked');
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
