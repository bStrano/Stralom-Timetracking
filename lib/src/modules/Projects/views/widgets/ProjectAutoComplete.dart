import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../entities/Project.dart';
import '../../providers/ProjectProvider.dart';



class ProjectAutoCompleteWidget extends StatelessWidget {
  const ProjectAutoCompleteWidget({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    final ProjectProvider projectProvider = Provider.of(context, listen: true);

    return Autocomplete<Project>(
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextFormField(
          controller: textEditingController,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.placeholderNewActivity,
          ),
          focusNode: focusNode,
          onFieldSubmitted: (String value) async {
            onFieldSubmitted();
            Project project = Project.fromForm(value, color.value.toRadixString(16));
            projectProvider.register(project);
            textEditingController.text = '';
          },
        );
      },
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<Project>.empty();
        }
        return projectProvider.projects.where((Project option) {
          return option.name.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (Project selection) {
        debugPrint('You just selected $selection');
      },
    );
  }
}
