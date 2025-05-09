import 'package:flutter/material.dart';

class RoomCard extends StatelessWidget {
  final int players;
  final String roomNumber;
  const RoomCard({super.key, required this.players, required this.roomNumber});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 150,
      child: Card(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(roomNumber, style: TextStyle(color: Colors.black)),
            Text(
              'Players ${players.toString()}',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
