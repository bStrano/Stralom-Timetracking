import 'package:flutter/material.dart';

import 'RecordListItemWidget.dart';

class RecordListSection implements RecordListItem {
  final String heading;

  RecordListSection(this.heading);

  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.headline5,
    );
  }

  @override
  Widget buildSubtitle(BuildContext context) => const SizedBox.shrink();
}
