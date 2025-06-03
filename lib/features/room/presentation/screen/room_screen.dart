import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:in_between/core/routes/app_router.dart';
import 'package:in_between/core/widgets/images.dart';
import 'package:in_between/core/widgets/outlined_button_widget.dart';
import 'package:in_between/features/room/presentation/bloc/room_bloc.dart';

class WaitingRoomScreen extends StatefulWidget {
  final String roomId;
  const WaitingRoomScreen({super.key, required this.roomId});

  @override
  State<WaitingRoomScreen> createState() => _WaitingRoomScreenState();
}

class _WaitingRoomScreenState extends State<WaitingRoomScreen> {
  int countDown = 5;
  bool showTimer = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    print("ROOM ID: ${widget.roomId}");
    context.read<RoomBloc>().add(RoomFetch(roomId: widget.roomId));
  }

  void _cancelCountdown() {
    _timer?.cancel();
    _timer = null;
    setState(() {
      showTimer = false;
      countDown = 5;
    });
  }

  void _startCountdown() {
    _timer?.cancel();

    setState(() {
      showTimer = true;
      countDown = 5;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countDown == 1) {
        timer.cancel();
        context.go(Routes.roomScreen);
      } else {
        setState(() {
          countDown--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final leftPosition = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        BlocBuilder<RoomBloc, RoomState>(
          builder: (context, state) {
            if (state is RoomFetchingSucces) {
              final players = state.room.userList;

              if (players.length == 6 && !showTimer) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _startCountdown();
                });
              } else if (players.length < 6 && showTimer) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _cancelCountdown();
                });
              }

              return Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.only(top: 12),
                child: GridView.builder(
                  itemCount: players.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    final player = players[index];
                    return Card(
                      // margin: EdgeInsets.all(8),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.asset(ImagePaths.userPic.path),
                            ),
                            Text(
                              player.username,
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is RoomFetchingFailed) {
              return Center(
                child: Text(
                  'Failed: ${state.message}',
                  style: TextStyle(color: Colors.red),
                ),
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        ),

        if (showTimer)
          Container(
            color: Colors.black,
            child: Center(
              child: Text(
                'Game starts in $countDown ... ',
                style: TextStyle(color: Colors.white, fontSize: 32),
              ),
            ),
          ),

        Positioned(
          bottom: 30,
          left: leftPosition / 3,

          child: ButtonWidget(
            label: "Exit Lobby",
            onPressed: () {
              context.go(Routes.homeScreen);
            },
          ),
        ),
      ],
    );
  }
}
