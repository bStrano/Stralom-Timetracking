import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeInput extends StatefulWidget {
  const DateTimeInput({Key? key, required this.label}) : super(key: key);

  final String label;

  @override
  State<DateTimeInput> createState() => _DateTimeInputState();
}

class _DateTimeInputState extends State<DateTimeInput> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: OutlinedButton(
      onPressed: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: _selectedDate,
            initialDatePickerMode: DatePickerMode.day,
            firstDate: DateTime(2015),
        lastDate: DateTime(2101));

        if(pickedDate != null) {
          setState(() {
            _selectedDate= pickedDate;
          });
        }
      },
      child: Row(
        children: [
          const Icon(Icons.date_range_rounded),
          Expanded(
            child: Text(widget.label),
          ),
          Text( DateFormat.MMMEd().format(_selectedDate))
        ],
      ),
    ));
  }
}
