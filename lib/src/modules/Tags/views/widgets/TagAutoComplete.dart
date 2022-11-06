import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:stralom_timetracking/src/modules/Tags/entities/Tag.dart';
import 'package:stralom_timetracking/src/modules/Tags/providers/TagProvider.dart';


class TagAutoCompleteWidget extends StatelessWidget {
  const TagAutoCompleteWidget({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    final TagProvider tagProvider = Provider.of(context, listen: true);

    return Autocomplete<Tag>(
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
            Tag tag = Tag.fromForm(value, color.value.toRadixString(16));
            tagProvider.register(tag);
            textEditingController.text = '';
          },
        );
      },
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<Tag>.empty();
        }
        return tagProvider.tags.where((Tag option) {
          return option.name.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (Tag selection) {
        debugPrint('You just selected $selection');
      },
    );
  }
}
