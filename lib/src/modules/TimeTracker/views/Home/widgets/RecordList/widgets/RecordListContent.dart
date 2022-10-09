import 'package:flutter/widgets.dart';
import 'package:stralom_timetracking/src/modules/TimeTracker/views/Home/widgets/RecordList/widgets/RecordListItemWidget.dart';

class RecordListContent implements RecordListItem {
  final String sender;
  final String body;

  RecordListContent(this.sender, this.body);

  @override
  Widget buildTitle(BuildContext context) => Text(sender);

  @override
  Widget buildSubtitle(BuildContext context) => Text(body);
}
