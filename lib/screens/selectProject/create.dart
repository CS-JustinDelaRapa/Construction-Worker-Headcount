// ignore_for_file: unused_import

import 'package:engineering/databaseHelper/DataBaseHelper.dart';
import 'package:engineering/model/ProjectItem.dart';
import 'package:engineering/screens/hamburgerMenu/stack.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../homePage.dart';

class CreateProject extends StatefulWidget {
  const CreateProject({Key? key}) : super(key: key);

  @override
  _CreateProjectState createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  String val = "Bungalow";
  TextEditingController projectName = TextEditingController();

  var outputFormat = DateFormat('MM/dd/yyyy');
  TextEditingController dateStartControler = TextEditingController();
  DateTime startSelectedDate = DateTime.now();
  DateTime endSelectedDate = DateTime.now();
  Future<void> _selectDateStart(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: startSelectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != startSelectedDate) {
      setState(() {
        startSelectedDate = picked;
      });
    }
  }

  Future<void> _selectDateEnd(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: endSelectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != endSelectedDate) {
      setState(() {
        endSelectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: CustomWidgets().text_title('New Project', 20),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomWidgets().text_title(
                'Enter the name of the new project and select style.', 20),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: CustomWidgets().textFormField_widget(
                'Project name', Colors.white, 0, projectName),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: TextField(
              readOnly: true,
              controller: dateStartControler,
              onTap: () async {
                _selectDateStart(context);
                print(startSelectedDate);
              },
              decoration: InputDecoration(
                  hintText: outputFormat.format(startSelectedDate).toString()),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: TextField(
              readOnly: true,
              controller: dateStartControler,
              onTap: () async {
                _selectDateEnd(context);
                print(endSelectedDate);
              },
              decoration: InputDecoration(
                  hintText: outputFormat.format(endSelectedDate).toString()),
            )),
          ),
          Container(
            alignment: AlignmentDirectional.centerStart,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: CustomWidgets().text_title('Style:', 20),
            ),
          ),
          ListTile(
            title: const Text("Bungalow"),
            leading: Radio(
              value: "Bungalow",
              groupValue: val,
              onChanged: (value) {
                setState(() {
                  val = value.toString();
                });
              },
              activeColor: Colors.green,
            ),
          ),
          ListTile(
            title: const Text("Two-Storey"),
            leading: Radio(
              value: "Two-Storey",
              groupValue: val,
              onChanged: (value) {
                setState(() {
                  val = value.toString();
                });
              },
              activeColor: Colors.green,
            ),
          ),
          const SizedBox(height: 30),
          CustomWidgets().funtion_Button('Save', const Icon(Icons.menu_open),
              0.6, 0.07, context, saveProject)
        ],
      ),
    );
  }

  saveProject() async {
    final craetedProject = ProjectItem(
        project_name: projectName.text,
        date_start: DateTime.now(),
        date_end: DateTime.now(),
        type: val);
    final iDFromSQL =
        await DatabaseHelper.instance.createProject(craetedProject);
    final toStackProject = ProjectItem(
        id: iDFromSQL,
        project_name: projectName.text,
        date_start: DateTime.now(),
        date_end: DateTime.now(),
        type: val);
    CustomWidgets().function_pushReplacement(
        context, () => StackWidget(project: toStackProject));
  }
}
