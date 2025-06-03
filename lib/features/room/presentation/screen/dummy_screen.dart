// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_between/features/home/presentation/bloc/home_bloc.dart';
import 'package:in_between/features/room/presentation/bloc/room_bloc.dart';

class DummyScreen extends StatefulWidget {
  final String roomId;
  const DummyScreen({Key? key, required this.roomId}) : super(key: key);

  @override
  State<DummyScreen> createState() => _DummyScreenState();
}

class _DummyScreenState extends State<DummyScreen> {
  @override
  void initState() {
    context.read<RoomBloc>().add(RoomFetch(roomId: widget.roomId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomBloc, RoomState>(
      builder: (context, state) {
        if (state is RoomFetchingSucces) {
          final players = state.room;
          return Column(children: [Text("USERS: ${players.userList}")]);
        } else if (state is RoomFetchingFailed) {
          print("ROOM SCREEN ${state.message}");
          return Center(child: Text(state.message));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
