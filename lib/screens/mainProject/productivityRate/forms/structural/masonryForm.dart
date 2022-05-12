import 'package:engineering/screens/mainProject/structural/items/twoStoreyStructuralItems.dart';
import 'package:flutter/material.dart';

import '../../../structural/items/bungalowStructuralItem.dart';

class MasonryWorksForm extends StatefulWidget {
  final String projectType;
  const MasonryWorksForm({Key? key, required this.projectType})
      : super(key: key);

  @override
  State<MasonryWorksForm> createState() => _MasonryWorksFormState();
}

class _MasonryWorksFormState extends State<MasonryWorksForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Masonry Works'),
      ),
      body: Column(
          children: widget.projectType == "Bungalow"
              ? BungalowStructuralItems.listMasonryWorks
                  .map((item) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item,
                          style: TextStyle(fontSize: 16),
                        ),
                      ))
                  .toList()
              : TwoStoreyStructuralItems.listMasonryWorks
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
