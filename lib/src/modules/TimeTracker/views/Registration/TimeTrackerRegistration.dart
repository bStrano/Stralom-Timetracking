import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:stralom_timetracking/src/modules/Tags/views/List/TagScreenArgument.dart';
import '../../../../shared/widgets/DateTimeInput.dart';
import '../../../Projects/entities/Project.dart';
import '../../../Projects/views/List/ProjectScreenArguments.dart';
import '../../../Tags/entities/Tag.dart';
import '../../providers/TimeTrackerProvider.dart';

class TimeTrackerRegistration extends StatefulWidget {
  const TimeTrackerRegistration({Key? key}) : super(key: key);

  @override
  State<TimeTrackerRegistration> createState() =>
      _TimeTrackerRegistrationState();
}

class _TimeTrackerRegistrationState extends State<TimeTrackerRegistration> {
  TextEditingController titleTextController = TextEditingController();
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  Project? _selectedProject;
  List<Tag>? _selectedTags = [];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TimeTrackerProvider timeTrackerProvider =
        Provider.of(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar nova entrada'),
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                const SizedBox(height: 10),
                TextFormField(
                    controller: titleTextController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!
                            .placeholderNewActivity)),
                const SizedBox(height: 10),
                DateTimeInput(
                    label: 'Data Inicio',
                    onChange: (selectedDate) {
                      setState(() {
                        _selectedStartDate = selectedDate;
                      });
                    }),
                const SizedBox(height: 10),
                DateTimeInput(
                    label: 'Data Termino',
                    onChange: (selectedDate) {
                      setState(() {
                        _selectedEndDate = selectedDate;
                      });
                    }),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () async {
                    Project result = await Navigator.pushNamed(
                            context, '/time-record/register/project',
                            arguments: ProjectScreenArguments(selector: true))
                        as Project;
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
                                  color: Color(int.parse(
                                      _selectedProject!.color,
                                      radix: 16)))
                              : null),
                      Text(_selectedProject != null
                          ? _selectedProject!.name
                          : ''),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                    onPressed: () async {
                      List<Tag> result = await Navigator.pushNamed(
                              context, '/time-record/register/tag',
                              arguments: TagScreenArguments(selector: true))
                          as List<Tag>;
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
                  child: ListView.builder(
                      shrinkWrap: false,
                      itemCount:
                          _selectedTags != null ? _selectedTags!.length : 0,
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
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                Colors.deepPurple)),
                        onPressed: () async {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            await timeTrackerProvider.register(
                                titleTextController.text,
                                _selectedStartDate,
                                _selectedEndDate,
                                _selectedTags,
                                _selectedProject?.id);
                            // TimeRecord record = new TimeRecord();
                            // timeTrackerProvider.save(record)
                            if (mounted) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing Data')),
                              );
                            }
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
