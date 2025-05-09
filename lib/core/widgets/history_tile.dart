import 'package:flutter/material.dart';

class HistoryTile extends StatelessWidget {
  final int index;
  const HistoryTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text('4/20/25  +500 ${index.toString()}'),
      ),
    );
  }
}
