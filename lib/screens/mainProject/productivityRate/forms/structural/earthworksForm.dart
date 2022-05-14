import 'package:engineering/screens/mainProject/structural/items/twoStoreyStructuralItems.dart';
import 'package:flutter/material.dart';

import '../../../structural/items/bungalowStructuralItem.dart';

class EarthworksForm extends StatefulWidget {
  final String projectType;
  const EarthworksForm({Key? key, required this.projectType}) : super(key: key);

  @override
  State<EarthworksForm> createState() => _EarthworksFormState();
}

class _EarthworksFormState extends State<EarthworksForm> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Earthworks'),
      ),
      body: Row(
        children: [
          Column(
            children: BungalowStructuralItems.listEarthWorks
                .map((item) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        item,
                        style: TextStyle(fontSize: 16),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
