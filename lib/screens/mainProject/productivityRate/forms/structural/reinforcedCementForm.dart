import 'package:engineering/screens/mainProject/structural/items/twoStoreyStructuralItems.dart';
import 'package:flutter/material.dart';

import '../../../structural/items/bungalowStructuralItem.dart';

class ReinforcedCementForm extends StatefulWidget {
  final String projectType;
  const ReinforcedCementForm({Key? key, required this.projectType})
      : super(key: key);

  @override
  State<ReinforcedCementForm> createState() => _ReinforcedCementFormState();
}

class _ReinforcedCementFormState extends State<ReinforcedCementForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reinforced Cement Works'),
      ),
      body: Column(
          children: widget.projectType == "Bungalow"
              ? BungalowStructuralItems.listReinforecedWorks
                  .map((item) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item,
                          style: TextStyle(fontSize: 16),
                        ),
                      ))
                  .toList()
              : TwoStoreyStructuralItems.listReinforecedWorks
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
