import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateProject extends StatefulWidget {
  const CreateProject({ Key? key }) : super(key: key);

  @override
  _CreateProjectState createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Project'),
      ),
      body: Center(
        child: Column(
          children: [
            CustomWidgets().text_title('Create Project', 35, 1),
            CustomWidgets().text_title('2nd Widget', 10, 1),
          ],
        ),
      ),
    );
  }
}