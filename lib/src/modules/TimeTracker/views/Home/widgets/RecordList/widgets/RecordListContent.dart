import 'package:flutter/widgets.dart';
import 'package:stralom_timetracking/src/modules/TimeTracker/entities/TimeRecord.dart';
import 'package:stralom_timetracking/src/modules/TimeTracker/views/Home/widgets/RecordList/widgets/RecordListItemWidget.dart';

import '../../../../../../Tags/views/widgets/TagList.dart';

class RecordListContent implements RecordListItem {
  final TimeRecord record;

  RecordListContent(this.record);

  @override
  Widget buildTitle(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
                "(${record.project != null ? record.project?.name : "Sem projeto"})",
                style: TextStyle(
                  fontSize: 12,
                    color: record.project?.color != null
                        ? Color(int.parse(record.project!.color, radix: 16))
                        : null)),
          ),
          Row(
            children: [
              Expanded(child: Text(record.title, style: TextStyle(fontSize: 18),)),
              Text(record.getFormattedElapsedTime())
            ],
          )
        ],
      );

  @override
  Widget buildSubtitle(BuildContext context) => Row(children: [
    TagList(tags: record.tags != null ? record.tags! : [])
  ],);

  @override
  bool isCard = true;
}
