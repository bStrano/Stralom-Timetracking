import 'package:flutter/material.dart';

import '../../../../shared/widgets/ColorPicker.dart';
import 'ProjectAutoComplete.dart';

class ProjectRegisterForm extends StatefulWidget {
  const ProjectRegisterForm({Key? key}) : super(key: key);

  @override
  State<ProjectRegisterForm> createState() => _ProjectRegisterFormState();
}

class _ProjectRegisterFormState extends State<ProjectRegisterForm> {
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
        Expanded(child: ProjectAutoCompleteWidget(color: _selectedColor)),
      ],
    );
  }
}
