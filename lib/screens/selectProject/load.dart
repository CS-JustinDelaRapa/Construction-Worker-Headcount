// ignore_for_file: deprecated_member_use

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
          )
        ],
      ),
    );
  }
}
          // child: Center(
                    //   child: Column(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       CustomWidgets().text_title('Load Project', 35),
                    //       const Flexible(
                    //           child: SizedBox(
                    //         height: 10,
                    //       )),
                    //       const Flexible(
                    //           child: SizedBox(
                    //         height: 10,
                    //       )),
                    //       CustomWidgets().nav_Button(
                    //           'Load Dummy Project',
                    //           const Icon(Icons.menu_open),
                    //           context,
                    //           0.6,
                    //           0.05,
                    //           () => const StackWidget(),
                    //           null),
                    //     ],
                    //   ),
                    // ),