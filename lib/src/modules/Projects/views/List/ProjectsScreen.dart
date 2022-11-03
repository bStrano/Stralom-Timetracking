import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stralom_timetracking/src/modules/Projects/providers/ProjectProvider.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({Key? key}) : super(key: key);

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  @override
  void initState() {
    super.initState();
    final ProjectProvider projectProvider = Provider.of(context, listen: false);
    projectProvider.getAll();
  }

  @override
  Widget build(BuildContext context) {
    final ProjectProvider projectProvider = Provider.of(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projetos'),
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: projectProvider.projectsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading');
                } else if (snapshot.hasData) {
                  return Expanded(
                      child: ListView.builder(
                          itemCount: projectProvider.projects?.length,
                          itemBuilder: (context, index) {
                            final item = snapshot.data![index];
                            return ListTile(title: Text(item.name));
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
