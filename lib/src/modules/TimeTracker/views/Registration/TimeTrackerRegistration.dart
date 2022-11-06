import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stralom_timetracking/src/modules/Projects/views/List/ProjectsScreen.dart';
import 'package:stralom_timetracking/src/modules/Tags/views/List/TagsScreen.dart';

import '../../../../shared/widgets/DateTimeInput.dart';
import '../../../Projects/entities/Project.dart';
import '../../../Tags/entities/Tag.dart';

class TimeTrackerRegistration extends StatefulWidget {
  const TimeTrackerRegistration({Key? key}) : super(key: key);

  @override
  State<TimeTrackerRegistration> createState() =>
      _TimeTrackerRegistrationState();
}

class _TimeTrackerRegistrationState extends State<TimeTrackerRegistration> {
  Project? _selectedProject;
  List<Tag>? _selectedTags = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar nova entrada'),
      ),
      body: Form(
          child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextFormField(
                decoration: InputDecoration(
                    hintText:
                        AppLocalizations.of(context)!.placeholderNewActivity)),
            const SizedBox(height: 10),
            const DateTimeInput(label: 'Data Inicio'),
            const SizedBox(height: 10),
            const DateTimeInput(label: 'Data Termino'),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () async {
                Project result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProjectScreen(
                            selector: true,
                          )),
                );
                setState(() {
                  _selectedProject = result;
                });
              },
              child: Row(
                children: [
                  const Expanded(child: Text('Selecionar projeto')),
                  Container(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: _selectedProject != null
                          ? Icon(Icons.circle_sharp,
                              color: Color(int.parse(_selectedProject!.color,
                                  radix: 16)))
                          : null),
                  Text(_selectedProject != null ? _selectedProject!.name : ''),
                ],
              ),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
                onPressed: () async {
                  List<Tag> result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TagScreen(
                              selector: true,
                            )),
                  );
                  setState(() {
                    _selectedTags = result;
                  });
                },
                child: Row(
                  children: const [
                    Expanded(child: Text('Selecionar tags')),
                  ],
                )),
            Container(
                height: 50.0,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Expanded(
                  child: ListView.builder(
                      shrinkWrap: false,
                      itemCount: _selectedTags?.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final item = _selectedTags![index];
                        return Expanded(
                            child: Container(
                                margin: EdgeInsets.only(right: 15),
                                child: Chip(
                                  onDeleted: () {
                                    setState(() {
                                      _selectedTags?.remove(item);
                                    });
                                  },
                                  label: Text(item.name),
                                  backgroundColor:
                                      Color(int.parse(item.color, radix: 16)),
                                )));
                      }),
                )),
          ],
        ),
      )),
    );
  }
}
