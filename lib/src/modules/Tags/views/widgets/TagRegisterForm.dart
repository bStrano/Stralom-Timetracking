import 'package:flutter/material.dart';
import '../../../../shared/widgets/ColorPicker.dart';
import 'TagAutoComplete.dart';

class TagRegisterForm extends StatefulWidget {
  const TagRegisterForm({Key? key}) : super(key: key);

  @override
  State<TagRegisterForm> createState() => _TagRegisterFormState();
}

class _TagRegisterFormState extends State<TagRegisterForm> {
  Color _selectedColor = Colors.black;

  changeColor(Color color){
    setState(() {
      _selectedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              showDialog(context: context, builder: (context) => const ColorPicker()).then((value) => changeColor(value));
            },
            icon: const Icon(Icons.circle_sharp), color: _selectedColor,),
        Expanded(child: TagAutoCompleteWidget(color: _selectedColor)),
      ],
    );
  }
}
