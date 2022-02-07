import 'package:engineering/screens/hamburgerMenu/stack.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';
import '../homePage.dart';

class CreateProject extends StatefulWidget {
  const CreateProject({Key? key}) : super(key: key);

  @override
  _CreateProjectState createState() => _CreateProjectState();
}

enum projectType { bungalow, twoStorey }

class _CreateProjectState extends State<CreateProject> {
  projectType? _value = projectType.bungalow;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: CustomWidgets()
                .textFormField_widget('Project name ', Colors.white, 0),
          ),
          Container(
            alignment: AlignmentDirectional.centerStart,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: CustomWidgets().text_title('Style:', 20),
            ),
          ),
          ListTile(
            title: const Text('Bungalow'),
            leading: Radio<projectType>(
              value: projectType.bungalow,
              groupValue: _value,
              onChanged: (projectType? value) {
                setState(() {
                  _value = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Two-Storey'),
            leading: Radio<projectType>(
              value: projectType.twoStorey,
              groupValue: _value,
              onChanged: (projectType? value) {
                setState(() {
                  _value = value;
                });
              },
            ),
          ),
          CustomWidgets().nav_Button(
            'Open Dummy Project',
            const Icon(Icons.menu_open),
            context,
            0.6,
            0.06,
            () => const StackWidget(),
            null,
          ),
          const Flexible(
              child: SizedBox(
            height: 10,
          )),
          CustomWidgets().nav_Button('Back To Home', const Icon(Icons.home),
              context, 0.6, 0.06, () => const HomePage(), null),
          const Flexible(
              child: SizedBox(
            height: 10,
          ))
        ],
      ),
    );
  }
}
