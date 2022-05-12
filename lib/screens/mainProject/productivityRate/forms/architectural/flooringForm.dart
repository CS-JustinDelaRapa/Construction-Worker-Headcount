import 'package:engineering/screens/mainProject/architectural/items/bungalowArchitecturalItem.dart';
import 'package:engineering/screens/mainProject/architectural/items/twoStoreyArchitecturalItem.dart';
import 'package:flutter/material.dart';

class FlooringForm extends StatefulWidget {
  final String projectType;
  const FlooringForm({Key? key, required this.projectType}) : super(key: key);

  @override
  State<FlooringForm> createState() => _FlooringFormState();
}

class _FlooringFormState extends State<FlooringForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flooring'),
      ),
      body: Column(
          children: widget.projectType == "Bungalow"
              ? BungalowArchitechturalItems.listFlooringWorks
                  .map((item) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item,
                          style: TextStyle(fontSize: 16),
                        ),
                      ))
                  .toList()
              : TwoStoreyArchitechturalItems.listFlooringWorks
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
