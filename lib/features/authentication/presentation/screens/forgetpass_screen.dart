import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:in_between/core/routes/app_router.dart';
import 'package:in_between/core/widgets/images.dart';
import 'package:in_between/core/widgets/outlined_button_widget.dart';
import 'package:in_between/core/widgets/textfield_widget.dart';

class ForgetpassScreen extends StatelessWidget {
  const ForgetpassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController forgetpassUsernameController =
        TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            context.go(Routes.loginScreen);
          },
          icon: Icon(Icons.close, color: Colors.white),
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
            children: [
              SizedBox(
                height: 150,
                width: 150,
                child: Image.asset(ImagePaths.logo.path),
              ),
              Divider(height: 22, color: Colors.transparent),

              Text('FORGOT PASSWORD', style: TextStyle(fontSize: 40)),
              Divider(height: 22, color: Colors.transparent),

              TextFieldWidget(
                tag: 'Input your Email',
                label: 'Input Email',
                controller: forgetpassUsernameController,
              ),

              Divider(height: 100, color: Colors.transparent),

              InkWell(
                onTap: () {
                  print('login button clicked');
                },
                child: ButtonWidget(
                  label: 'Reset',
                  onPressed: () {
                    print('Reset');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
