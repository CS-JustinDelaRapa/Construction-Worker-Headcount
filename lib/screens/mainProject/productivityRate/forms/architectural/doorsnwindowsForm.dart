import 'package:engineering/screens/mainProject/architectural/items/bungalowArchitecturalItem.dart';
import 'package:engineering/screens/mainProject/architectural/items/twoStoreyArchitecturalItem.dart';
import 'package:flutter/material.dart';

class DoorsnWindowsForm extends StatefulWidget {
  final String projectType;
  const DoorsnWindowsForm({Key? key, required this.projectType})
      : super(key: key);

  @override
  State<DoorsnWindowsForm> createState() => _DoorsnWindowsFormState();
}

class _DoorsnWindowsFormState extends State<DoorsnWindowsForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doors and Windows'),
      ),
      body: Column(
          children: widget.projectType == "Bungalow"
              ? BungalowArchitechturalItems.listDoornWindowsWorks
                  .map((item) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item,
                          style: TextStyle(fontSize: 16),
                        ),
                      ))
                  .toList()
              : TwoStoreyArchitechturalItems.listDoornWindowsWorks
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
