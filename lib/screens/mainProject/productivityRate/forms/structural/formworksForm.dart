import 'package:engineering/screens/mainProject/structural/items/twoStoreyStructuralItems.dart';
import 'package:flutter/material.dart';

import '../../../structural/items/bungalowStructuralItem.dart';

class FormworksForm extends StatefulWidget {
  final String projectType;
  const FormworksForm({Key? key, required this.projectType}) : super(key: key);

  @override
  State<FormworksForm> createState() => _FormworksFormState();
}

class _FormworksFormState extends State<FormworksForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formworks'),
      ),
      body: Column(
          children: widget.projectType == "Bungalow"
              ? BungalowStructuralItems.listFormWorks
                  .map((item) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item,
                          style: TextStyle(fontSize: 16),
                        ),
                      ))
                  .toList()
              : TwoStoreyStructuralItems.listFormWorks
                  .map((item) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item,
                          style: TextStyle(fontSize: 16),
                        ),
                      ))
                  .toList()),
    );
  }
}
