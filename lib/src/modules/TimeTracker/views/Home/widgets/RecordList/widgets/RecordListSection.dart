import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'RecordListItemWidget.dart';

class RecordListSection implements RecordListItem {
  final DateTime date;

  RecordListSection(this.date);

  String getFormattedDate(){
    if(date.difference(DateTime.now()).inDays == 0) {
      return 'Hoje';
    } else if(date.difference(DateTime.now()).inDays == 1) {
      return 'Ontem';
    }
    return DateFormat.MMMEd().format(date);
  }

  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      getFormattedDate(),
      style: Theme.of(context).textTheme.headline5,
    );
  }

  @override
  Widget buildSubtitle(BuildContext context) => const SizedBox.shrink();
}
