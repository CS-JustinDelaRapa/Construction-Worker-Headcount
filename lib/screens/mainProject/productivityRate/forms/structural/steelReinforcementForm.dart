import 'package:engineering/screens/mainProject/structural/items/twoStoreyStructuralItems.dart';
import 'package:flutter/material.dart';

import '../../../structural/items/bungalowStructuralItem.dart';

class SteelReinforcementForm extends StatefulWidget {
  final String projectType;
  const SteelReinforcementForm({Key? key, required this.projectType})
      : super(key: key);

  @override
  State<SteelReinforcementForm> createState() => _SteelReinforcementFormState();
}

class _SteelReinforcementFormState extends State<SteelReinforcementForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Steel Reinforcement Works'),
      ),
      body: Column(
          children: widget.projectType == "Bungalow"
              ? BungalowStructuralItems.listSteelReinforecedWorks
                  .map((item) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item,
                          style: TextStyle(fontSize: 16),
                        ),
                      ))
                  .toList()
              : TwoStoreyStructuralItems.listSteelReinforecedWorks
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
