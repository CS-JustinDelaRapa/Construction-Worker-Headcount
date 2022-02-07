import 'package:engineering/screens/hamburgerMenu/stack.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';
import '../homePage.dart';

class CreateProject extends StatefulWidget {
  const CreateProject({Key? key}) : super(key: key);

  @override
  _CreateProjectState createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomWidgets().text_title('New Project', 20),
      ),
      body: Center(
        child: Column(
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
              child: Center(
                child: CustomWidgets()
                    .textFormField_widget('Project name ', Colors.white, 0),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomWidgets().text_title('Style:', 20),
                )
              ],
            ),
            CustomWidgets().nav_Button(
                'Open Dummy Project',
                const Icon(Icons.menu_open),
                context,
                () => const StackWidget(),
                null),
            const Flexible(
                child: SizedBox(
              height: 10,
            )),
            CustomWidgets().nav_Button('Back To Home', const Icon(Icons.home),
                context, () => const HomePage(), null),
            const Flexible(
                child: SizedBox(
              height: 10,
            )),
          ],
        ),
      ),
    );
  }
}
