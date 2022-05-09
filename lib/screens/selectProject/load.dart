// ignore_for_file: deprecated_member_use, unused_import, unnecessary_new, prefer_const_constructors, avoid_print
import 'package:engineering/databaseHelper/DataBaseHelper.dart';
import 'package:engineering/model/ProjectModel.dart';
import 'package:engineering/screens/hamburgerMenu/stack.dart';
import 'package:engineering/screens/selectProject/about.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../homePage.dart';

class LoadProject extends StatefulWidget {
  const LoadProject({Key? key}) : super(key: key);

  @override
  _LoadProjectState createState() => _LoadProjectState();
}

class _LoadProjectState extends State<LoadProject> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController projectName = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<ProjectItem>? projects;
  bool isLoading = false;
  int? selected;
  int? selectedIndex;
  RegExp regex = new RegExp(r'(?!^ +$)^.+$');
  // final List<ProjectItem> projects = ([
  // ProjectItem(id: 0, project_name: 'Project 1', type: 'Bungalow', date_start:  DateTime.now(), date_end: DateTime.now()),
  // ProjectItem(id: 1, project_name: 'Project 2', type: 'Two Storey', date_start:  DateTime.now(), date_end: DateTime.now())
  // ]);

  @override
  void initState() {
    refreshState();
    super.initState();
  }

  Future refreshState() async {
    setState(() => isLoading = true);
    projects = await DatabaseHelper.instance.readAllProject();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Load Project'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              key: _scaffoldKey,
              children: [
                const ListTile(
                  leading: Text('ID'),
                  title: Text('Project Name'),
                  trailing: Text('Style'),
                ),
                Expanded(
                  child: projects!.isEmpty
                      ? Center(child: Text('No Projects'))
                      : ListView.builder(
                          itemCount: projects!.length,
                          itemBuilder: (context, index) {
                            return Ink(
                              child: GestureDetector(
                                child: ListTile(
                                  tileColor: selected == projects![index].id
                                      ? Theme.of(context)
                                          .listTileTheme
                                          .selectedTileColor
                                      : null,
                                  textColor: selected == projects![index].id
                                      ? Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Color.fromARGB(255, 32, 28, 48)
                                          : const Color.fromARGB(
                                              255, 250, 252, 243)
                                      : null,
                                  leading: Text(projects![index].id.toString()),
                                  title: Text(projects![index].project_name),
                                  trailing: Text(projects![index].type),
                                  onTap: () {
                                    setState(() {
                                      selected = projects![index].id;
                                      selectedIndex = index;
                                      projectName.text =
                                          projects![index].project_name;
                                    });
                                  },
                                  onLongPress: () {
                                    setState(() {
                                      projectName.text =
                                          projects![index].project_name;
                                      selected = projects![index].id;
                                      selectedIndex = index;
                                    });
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              title: const Text(
                                                  'Edit Project Name'),
                                              content: Form(
                                                key: _formKey,
                                                child: TextFormField(
                                                  initialValue:
                                                      projectName.text,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty ||
                                                        !regex
                                                            .hasMatch(value)) {
                                                      return 'This Field is Required';
                                                    }
                                                    return null;
                                                  },

                                                  // controller: projectName.text,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      projectName.text = value;
                                                    });
                                                  },
                                                ),
                                              ),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text("Continue"),
                                                  onPressed: () {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      final updated = ProjectItem(
                                                          id: projects![
                                                                  selectedIndex!]
                                                              .id,
                                                          project_name:
                                                              projectName.text,
                                                          date_start: projects![
                                                                  selectedIndex!]
                                                              .date_start,
                                                          date_end: projects![
                                                                  selectedIndex!]
                                                              .date_end,
                                                          type: projects![
                                                                  selectedIndex!]
                                                              .type);
                                                      DatabaseHelper.instance
                                                          .updateProject(
                                                              updated)
                                                          .then((value) =>
                                                              refreshState());
                                                      Navigator.of(context)
                                                          .pop();
                                                    }
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
                projects!.isEmpty
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomWidgets().funtion_Button(
                              "Delete",
                              const Icon(Icons.delete_outline_outlined),
                              0.45,
                              0.07,
                              context,
                              deleteProject),
                          CustomWidgets().funtion_Button(
                              'Load',
                              const Icon(Icons.menu_open),
                              0.45,
                              0.07,
                              context,
                              loadProject)
                        ],
                      ),
                SizedBox(height: 10)
              ],
            ),
    );
  }

  loadProject() {
    CustomWidgets().function_pushReplacement(
        context,
        () => StackWidget(
              project: projects![selectedIndex!],
            ));
  }

  deleteProject() {
    if (selected == null && selectedIndex == null) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: const Text('Please Select 1 Project'),
                actions: <Widget>[
                  FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      // print(projectName[index]);
                      Navigator.of(context).pop();
                    },
                  ),
                ]);
          });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: const Text('Delete Project?'),
                content: Text(
                    'Are you sure you want to pemanently delete the selected project?'),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Cancel"),
                    onPressed: () {
                      // print(projectName[index]);
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text("Continue"),
                    onPressed: () {
                      DatabaseHelper.instance
                          .deleteProject(selected!)
                          .then((value) => refreshState());
                      Navigator.of(context).pop();
                    },
                  ),
                ]);
          });
    }
  }
}
