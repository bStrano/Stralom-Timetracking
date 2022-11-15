import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class DateTimeInput extends StatefulWidget {
  const DateTimeInput({Key? key, required this.label, required this.onChange}) : super(key: key);

  final String label;
  final Function onChange;

  @override
  State<DateTimeInput> createState() => _DateTimeInputState();
}

class _DateTimeInputState extends State<DateTimeInput> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate:  DateTime.now(),
            initialDatePickerMode: DatePickerMode.day,
            firstDate: DateTime(2015),
            lastDate: DateTime(2101));

        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          builder: (BuildContext context, Widget? child) {
            return Directionality(
              textDirection: ui.TextDirection.ltr,
              child: child!,
            );
          },
        );
        if (pickedDate != null && pickedTime != null) {
          setState(() {
            _selectedDate = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, pickedTime.hour, pickedTime.minute);
            _selectedTime = pickedTime;
          });
          widget.onChange(_selectedDate);
        }
      },
      child: Row(
        children: [
          const Icon(Icons.date_range_rounded),
          Expanded(
            child: Text(widget.label),
          ),
          Container(
            child: _selectedTime != null && _selectedDate != null ? Row(children: [
              Text(DateFormat.MMMEd().format(_selectedDate!)),
              const Text(' - '),
              Text(_selectedTime!.format(context))
            ]) : null,
          )


        ],
      ),
    );
  }
}
