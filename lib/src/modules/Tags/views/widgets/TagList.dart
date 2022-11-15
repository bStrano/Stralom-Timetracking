import 'package:flutter/material.dart';

import '../../entities/Tag.dart';

class TagList extends StatelessWidget {
  const TagList({Key? key, required this.tags}) : super(key: key);
  final List<Tag> tags;

  @override
  Widget build(BuildContext context) {
    if(tags.isEmpty) return Container(padding: const EdgeInsets.only(bottom: 10),);
    return Expanded(
        child: Container(
      height: 50.0,
      width: 100,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: tags
            .map((tag) => Row(
                  children: [
                    Icon(Icons.tag,
                        color: Color(int.parse(tag.color, radix: 16))),
                    Text(tag.name)
                  ],
                ))
            .toList(),
      ),
    ));
  }
}
