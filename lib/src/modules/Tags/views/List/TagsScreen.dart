import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stralom_timetracking/src/modules/Tags/providers/TagProvider.dart';

import '../../entities/Tag.dart';
import '../widgets/TagRegisterForm.dart';


class TagScreen extends StatefulWidget {
  final bool? selector;

  const TagScreen({super.key,this.selector});

  @override
  State<TagScreen> createState() => _TagScreenState();
}

class _TagScreenState extends State<TagScreen> {
  List<Tag> _selectedTags = [];
  bool _showFab = false;

  toggleTag(Tag tag){
    int index = _selectedTags.indexOf(tag);
    if(index == -1){
      setState(() {
        _selectedTags.add(tag);
        _showFab = true;
      });
    }

    setState(() {
      _selectedTags.removeAt(index);
      _showFab = false;
    });
  }

  @override
  void initState() {
    super.initState();
    final TagProvider tagProvider = Provider.of(context, listen: false);
    tagProvider.getAll();
  }

  @override
  Widget build(BuildContext context) {
    final TagProvider tagProvider = Provider.of(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tags'),
      ),
      floatingActionButton: _showFab ? FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pop(_selectedTags);
        },
        label: const Text('Adicionar Tags'),
        icon: const Icon(Icons.thumb_up),
        backgroundColor: Colors.deepPurple,
      ) : null,
      body: Column(
        children: [
          const TagRegisterForm(),
          FutureBuilder(
              future: tagProvider.tagsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading');
                } else if (snapshot.hasData) {
                  return Expanded(
                      child: ListView.builder(
                          itemCount: tagProvider.tags.length,
                          itemBuilder: (context, index) {
                            final item = snapshot.data![index];
                            return ListTile(
                                title: TextButton(
                                  style:  ButtonStyle(backgroundColor: _selectedTags.contains(item) ? MaterialStateProperty.all(Theme.of(context).highlightColor) : null),
                                  onPressed: () {
                                    if(widget.selector == true){
                                      toggleTag(item);
                                    }
                                    print('PRESS');
                                  },
                                  child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.circle_sharp), color: Color(int.parse(item.color, radix: 16)), onPressed: () {  },),
                                  Text(item.name)
                              ],
                            )));
                          }));
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const Text('OK');
              }),
        ],
      ),
    );
  }
}
