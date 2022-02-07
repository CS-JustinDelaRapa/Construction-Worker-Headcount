import 'package:engineering/screens/hamburgerMenu/stack.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';
import '../homePage.dart';

class CreateProject extends StatefulWidget {
  const CreateProject({Key? key}) : super(key: key);

  @override
  _CreateProjectState createState() => _CreateProjectState();
}

TextEditingController projectName = TextEditingController();

class _CreateProjectState extends State<CreateProject> {
  String val = "Bungalow";
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
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomWidgets().text_title(
                    'Enter the name of the new project and select style.', 20),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: CustomWidgets().textFormField_widget(
                    'Project name ', Colors.white, 0, projectName),
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
              CustomWidgets().save_Button(
                'Save',
                const Icon(Icons.menu_open),
                context,
                0.6,
                0.07,
                () => const StackWidget(),
                projectName.text,
                val.toString(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
