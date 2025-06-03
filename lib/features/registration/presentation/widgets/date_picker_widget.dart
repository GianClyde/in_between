import 'package:flutter/material.dart';

class DropDownDatePickerWidget extends StatefulWidget {
  final void Function(DateTime) onSelectedDate;
  const DropDownDatePickerWidget({super.key, required this.onSelectedDate});

  @override
  State<DropDownDatePickerWidget> createState() =>
      _DropDownDatePickerWidgetState();
}

class _DropDownDatePickerWidgetState extends State<DropDownDatePickerWidget> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Birthdate"),
          Container(
            padding: EdgeInsets.only(left: 8.0),
            height: 55,
            width: screenWidth * 0.80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: const Color.fromARGB(255, 170, 176, 179),
                width: 1.2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Birthdate',
                  style: TextStyle(
                    fontSize: 16,
                    color: const Color.fromARGB(255, 158, 164, 167),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      onTap: () async {
        final DateTime? dateTime = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (dateTime != null) {
          setState(() {
            selectedDate = dateTime;
          });
          widget.onSelectedDate(dateTime);
        }
      },
    );
  }
}
