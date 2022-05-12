import 'package:engineering/screens/mainProject/electricalAndPlumbing/items/electricalAndPlumbingItem.dart';
import 'package:flutter/material.dart';

class PlumbingWorksForm extends StatefulWidget {
  final String projectType;
  const PlumbingWorksForm({Key? key, required this.projectType})
      : super(key: key);

  @override
  State<PlumbingWorksForm> createState() => _PlumbingWorksFormState();
}

class _PlumbingWorksFormState extends State<PlumbingWorksForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Plumibing Works'),
        ),
        body: Column(
            children: ElectricalAndPlumbingItems.listPlumbingWorks
                .map((item) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        item,
                        style: TextStyle(fontSize: 16),
                      ),
                    ))
                .toList()));
  }
}
