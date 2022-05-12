import 'package:engineering/screens/mainProject/architectural/items/bungalowArchitecturalItem.dart';
import 'package:engineering/screens/mainProject/architectural/items/twoStoreyArchitecturalItem.dart';
import 'package:flutter/material.dart';

class PlasteringForm extends StatefulWidget {
  final String projectType;
  const PlasteringForm({Key? key, required this.projectType}) : super(key: key);

  @override
  State<PlasteringForm> createState() => _PlasteringFormState();
}

class _PlasteringFormState extends State<PlasteringForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plastering'),
      ),
      body: Column(
          children: widget.projectType == "Bungalow"
              ? BungalowArchitechturalItems.listPlasteringWorks
                  .map((item) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item,
                          style: TextStyle(fontSize: 16),
                        ),
                      ))
                  .toList()
              : TwoStoreyArchitechturalItems.listPlasteringWorks
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
