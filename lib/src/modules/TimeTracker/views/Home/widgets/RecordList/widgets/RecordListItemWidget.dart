import 'package:flutter/widgets.dart';

/// The base class for the different types of items the list can contain.
abstract class RecordListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);

  bool isCard = false;
}
