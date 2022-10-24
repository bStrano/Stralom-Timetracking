import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stralom_timetracking/src/modules/TimeTracker/apis/TimeRecordApi.dart';


class RecordAutoCompleteWidget extends StatelessWidget {
  const RecordAutoCompleteWidget({super.key});

  static const List<String> _kOptions = <String>[
    'aardvark',
    'bobcat',
    'chameleon',
  ];

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
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
            await startTracking(value);
            textEditingController.text = '';
          },
          validator: (String? value) {
            if (!_kOptions.contains(value)) {
              return 'Nothing selected.';
            }
            return null;
          },
        );
      },
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return _kOptions.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        debugPrint('You just selected $selection');
      },
    );
  }
}
