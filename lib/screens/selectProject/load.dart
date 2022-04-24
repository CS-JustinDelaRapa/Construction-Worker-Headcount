// ignore_for_file: deprecated_member_use, unused_import, unnecessary_new, prefer_const_constructors, avoid_print

import 'package:engineering/model/ProjectItem.dart';
import 'package:engineering/screens/hamburgerMenu/stack.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';
import '../homePage.dart';

class LoadProject extends StatefulWidget {
  const LoadProject({Key? key}) : super(key: key);

  @override
  _LoadProjectState createState() => _LoadProjectState();
}

class _LoadProjectState extends State<LoadProject> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final List<ProjectItem> projects = ([
  ProjectItem(id: 0, project_name: 'Project 1', type: 'Bungalow', date_start:  DateTime.now(), date_end: DateTime.now()),
  ProjectItem(id: 1, project_name: 'Project 2', type: 'Two Storey', date_start:  DateTime.now(), date_end: DateTime.now())
  ]);

  int? selected;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Load Project'),
      ),
      body: Column(
        key: _scaffoldKey,
        children: [
          const ListTile(
            leading: Text('ID'),
            title: Text('Project Name'),
            trailing: Text('Style'),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  return Ink(
                    child: GestureDetector(
                      child: ListTile(
                        tileColor: selected == projects[index].id ? Theme.of(context).listTileTheme.selectedTileColor: null,
                        textColor: selected == projects[index].id ? 
                          Theme.of(context).brightness == Brightness.dark?
                          Color.fromARGB(255, 32, 28, 48):
                          const Color.fromARGB(255, 250, 252, 243)
                          : null,
                        leading: Text(projects[index].id.toString()),
                        title: Text(projects[index].project_name),
                        trailing: Text(projects[index].type),
                        onTap: () {
                          setState(() {
                            selected = index;
                          });
                        },
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    title: const Text('Edit Project Name'),
                                    content: TextField(
                                      decoration: InputDecoration(
                                          hintText: projects[index].project_name),
                                      onChanged: (value) {
                                        setState(() {
                                          // projects[index].projectName = value;
                                        });
                                      },
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Continue"),
                                        onPressed: () {
                                          // print(projectName[index]);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ]);
                              });
                        },
                      ),
                    ),
                  );
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomWidgets().funtion_Button(
                "Delete",
                const Icon(Icons.delete_outline_outlined),
                0.45,
                0.07,
                context,
                deleteProject),
              CustomWidgets().funtion_Button('Load',
                  const Icon(Icons.menu_open), 0.45, 0.07, context, loadProject)
            ],
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }

  loadProject() {
    CustomWidgets().function_pushReplacement(context, () => StackWidget(project: projects[selected!],));
  }

  deleteProject() {
    print("delete");
  }
}
