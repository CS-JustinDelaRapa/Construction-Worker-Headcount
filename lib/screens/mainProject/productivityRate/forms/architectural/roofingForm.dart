import 'package:engineering/screens/mainProject/architectural/items/bungalowArchitecturalItem.dart';
import 'package:engineering/screens/mainProject/architectural/items/twoStoreyArchitecturalItem.dart';
import 'package:flutter/material.dart';

class RoofingWorksForm extends StatefulWidget {
  final String projectType;
  const RoofingWorksForm({Key? key, required this.projectType})
      : super(key: key);

  @override
  State<RoofingWorksForm> createState() => _RoofingWorksFormState();
}

class _RoofingWorksFormState extends State<RoofingWorksForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roofing Works'),
      ),
      body: Column(
          children: widget.projectType == "Bungalow"
              ? BungalowArchitechturalItems.listRoofingWorks
                  .map((item) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item,
                          style: TextStyle(fontSize: 16),
                        ),
                      ))
                  .toList()
              : TwoStoreyArchitechturalItems.listRoofingWorks
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
