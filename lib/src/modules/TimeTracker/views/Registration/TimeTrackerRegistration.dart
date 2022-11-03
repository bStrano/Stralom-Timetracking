import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stralom_timetracking/src/modules/Projects/views/List/ProjectsScreen.dart';

import '../../../../shared/widgets/DateTimeInput.dart';

class TimeTrackerRegistration extends StatefulWidget {
  const TimeTrackerRegistration({Key? key}) : super(key: key);

  @override
  State<TimeTrackerRegistration> createState() => _TimeTrackerRegistrationState();
}

class _TimeTrackerRegistrationState extends State<TimeTrackerRegistration> {
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
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProjectScreen()),
              );
            },
            child: const Text('Selecionar projeto'),
          ),
          TextFormField(),
        ],
      ),),
    );
  }
}
