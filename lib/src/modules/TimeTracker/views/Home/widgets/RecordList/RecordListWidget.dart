import 'package:flutter/material.dart';
import 'package:stralom_timetracking/src/modules/TimeTracker/entities/TimeRecordsGroupedByStart.dart';
import 'package:stralom_timetracking/src/modules/TimeTracker/views/Home/widgets/RecordList/widgets/RecordListContent.dart';
import 'package:stralom_timetracking/src/modules/TimeTracker/views/Home/widgets/RecordList/widgets/RecordListItemWidget.dart';

import 'widgets/RecordListSection.dart';


class RecordListWidget extends StatefulWidget {
  const RecordListWidget({Key? key, required this.records}) : super(key: key);

  final List<TimeRecordGroupedByStart> records;

  @override
  State<RecordListWidget> createState() => _RecordListWidgetState();
}

class _RecordListWidgetState extends State<RecordListWidget> {
  List<RecordListItem> _items = [];

  void renderSectionList(){
    List<RecordListItem> data = [];
    for (var element in widget.records) {
      data.add(RecordListSection(element.date));
      for (var record in element.records) {
        data.add(RecordListContent(record.title, record.start.toString()));
      }
    }
    setState(() {
      _items = data;
    });
  }



  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    renderSectionList();
  }


  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final item = _items[index];

        Widget listTitle = ListTile(
          title: item.buildTitle(context),
          subtitle: item.buildSubtitle(context),
        );

        if(item.isCard){
          return Card(
            child: listTitle,
          );
        }
        return listTitle;
      },
    ));
  }
}
