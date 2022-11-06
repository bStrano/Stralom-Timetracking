import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({Key? key}) : super(key: key);

  final List<MaterialColor> colors = Colors.primaries;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {

  late List<IconButton> colors = Colors.primaries
      .map((e) => IconButton(
          onPressed: () {
            Navigator.pop(context, e);
          },
          icon: const Icon(Icons.circle), color: e.shade400,))
      .toList();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Selecione a cor"),
      content: SizedBox(
        width: 250,
        height: 300,
        child: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 4,
          // Generate 100 widgets that display their index in the List.
          children: colors
        ),
      ),
      elevation: 5,
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel')),
        TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK')),
      ],
    );
  }
}
