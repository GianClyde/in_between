import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:in_between/core/routes/app_router.dart';

class GameZone extends StatelessWidget {
  const GameZone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go(Routes.homeScreen);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Center(
        child: Text(
          'Bugala!',
          style: TextStyle(color: Colors.black, fontSize: 40),
        ),
      ),
    );
  }
}
