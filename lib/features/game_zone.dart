// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:in_between/core/cubit/user_cubit.dart';
import 'package:in_between/core/domain/user_entity.dart';

import 'package:in_between/core/routes/app_router.dart';
import 'package:in_between/features/home/presentation/bloc/home_bloc.dart';

class GameZone extends StatefulWidget {
  final String roomId;
  const GameZone({Key? key, required this.roomId}) : super(key: key);

  @override
  State<GameZone> createState() => _GameZoneState();
}

class _GameZoneState extends State<GameZone> {
  late UserEntity? currentUser;
  @override
  void initState() {
    super.initState();
    currentUser = context.read<UserCubit>().state;
    if (currentUser != null) {
      //todo if null clear the user in cubit and redirect to login
    }
  }

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
        child: GestureDetector(
          onTap: () {
            context.read<HomeBloc>().add(
              HomeLeaveRoom(user: currentUser!, roomId: widget.roomId),
            );
          },
          child: Text(
            'Bugala!',
            style: TextStyle(color: Colors.black, fontSize: 40),
          ),
        ),
      ),
    );
  }
}
