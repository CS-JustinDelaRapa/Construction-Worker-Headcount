// ignore_for_file: deprecated_member_use, unused_import, unnecessary_new, prefer_const_constructors, avoid_print

import 'package:engineering/screens/hamburgerMenu/stack.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';
import '../homePage.dart';

class LoadProject extends StatefulWidget {
  const LoadProject({Key? key}) : super(key: key);

  @override
  _LoadProjectState createState() => _LoadProjectState();
}

List<int> id = [0, 1];
List<String> projectName = ["BUNGALOW", "TWO-STOREY"];
List<String> projectStyle = ["Bungalow", "Two-Storey"];

class _LoadProjectState extends State<LoadProject> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
                itemCount: id.length,
                itemBuilder: (context, index) {
                  return Ink(
                    child: GestureDetector(
                      child: ListTile(
                        tileColor: selected == id[index] ? Colors.blue : null,
                        leading: Text(id[index].toString()),
                        title: Text(projectName[index]),
                        trailing: Text(projectStyle[index]),
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
                                          hintText: projectName[index]),
                                      onChanged: (value) {
                                        setState(() {
                                          projectName[index] = value;
                                        });
                                      },
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Continue"),
                                        onPressed: () {
                                          print(projectName[index]);
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
                0.49,
                0.07,
                context,
                deleteProject),
              CustomWidgets().funtion_Button('Load',
                  const Icon(Icons.menu_open), 0.49, 0.07, context, loadProject)
            ],
          ),
          SizedBox(height: 5)
        ],
      ),
    );
  }

  loadProject() {
    CustomWidgets().function_pushReplacement(context, () => const StackWidget());
  }

  deleteProject() {
    print("delete");
  }
}
