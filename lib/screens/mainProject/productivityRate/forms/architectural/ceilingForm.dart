import 'package:engineering/screens/mainProject/architectural/items/bungalowArchitecturalItem.dart';
import 'package:engineering/screens/mainProject/architectural/items/twoStoreyArchitecturalItem.dart';
import 'package:flutter/material.dart';

class CeilingForm extends StatefulWidget {
  final String projectType;
  const CeilingForm({Key? key, required this.projectType}) : super(key: key);

  @override
  State<CeilingForm> createState() => _CeilingFormState();
}

class _CeilingFormState extends State<CeilingForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ceiling'),
      ),
      body: Column(
          children: widget.projectType == "Bungalow"
              ? BungalowArchitechturalItems.listCeilingWorks
                  .map((item) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item,
                          style: TextStyle(fontSize: 16),
                        ),
                      ))
                  .toList()
              : TwoStoreyArchitechturalItems.listCeilingWorks
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
