import 'package:engineering/screens/mainProject/architectural/items/twoStoreyArchitecturalItem.dart';
import 'package:engineering/screens/mainProject/electricalAndPlumbing/items/electricalAndPlumbingItem.dart';
import 'package:flutter/material.dart';

class ElectricalWorksForm extends StatefulWidget {
  final String projectType;
  const ElectricalWorksForm({Key? key, required this.projectType})
      : super(key: key);

  @override
  State<ElectricalWorksForm> createState() => _ElectricalWorksFormState();
}

class _ElectricalWorksFormState extends State<ElectricalWorksForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Electrical Works'),
        ),
        body: Column(
            children: ElectricalAndPlumbingItems.listElectricalWorks
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
