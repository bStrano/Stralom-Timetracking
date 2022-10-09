import 'package:flutter/material.dart';
import 'package:stralom_timetracking/src/modules/TimeTracker/views/Home/widgets/RecordList/widgets/RecordListItemWidget.dart';

import 'widgets/RecordListContent.dart';
import 'widgets/RecordListSection.dart';

class RecordListWidget extends StatefulWidget {
  const RecordListWidget({Key? key}) : super(key: key);

  @override
  State<RecordListWidget> createState() => _RecordListWidgetState();
}

class _RecordListWidgetState extends State<RecordListWidget> {
  final List<RecordListItem> _items = List<RecordListItem>.generate(
    1000,
        (i) => i % 6 == 0
        ? RecordListSection('Heading $i')
        : RecordListContent('Sender $i', 'Message body $i'),
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _items.length,
      // Provide a builder function. This is where the magic happens.
      // Convert each item into a widget based on the type of item it is.
      itemBuilder: (context, index) {
        final item = _items[index];

        return ListTile(
          title: item.buildTitle(context),
          subtitle: item.buildSubtitle(context),
        );
      },
    );
  }
}
