import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stralom_timetracking/src/modules/Projects/views/List/ProjectsScreen.dart';

import '../../../../shared/widgets/DateTimeInput.dart';
import '../../../Projects/entities/Project.dart';

class TimeTrackerRegistration extends StatefulWidget {
  const TimeTrackerRegistration({Key? key}) : super(key: key);

  @override
  State<TimeTrackerRegistration> createState() => _TimeTrackerRegistrationState();
}

class _TimeTrackerRegistrationState extends State<TimeTrackerRegistration> {
  Project? _selectedProject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar nova entrada'),
      ),
      body: Form(child: Column(
        children: [
          TextFormField(decoration: InputDecoration(hintText: AppLocalizations.of(context)!.placeholderNewActivity)),
          const DateTimeInput(label: 'Data Inicio'),
          const DateTimeInput(label: 'Data Termino'),
          OutlinedButton(
            onPressed: () async {
               Project result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProjectScreen(selector: true,)),
              );
               setState(() {
                 _selectedProject = result;
               });
            },
            child:  Row(
              children: [
                const Expanded(child: Text('Selecionar projeto')),
                Container(padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),child: _selectedProject != null ?  Icon(Icons.circle_sharp, color: Color(int.parse(_selectedProject!.color,radix: 16))) : null),
                Text(_selectedProject != null? _selectedProject!.name : '' ),
              ],
            ),
          ),
          TextFormField(),
        ],
      ),),
    );
  }
}
