// ignore_for_file: file_names

import 'package:engineering/screens/hamburgerMenu/openDrawer.dart';
import 'package:engineering/screens/mainProject/productivityRate/dummy.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';

class ProductivityRate extends StatefulWidget {
  final VoidCallback openDrawer;

  const ProductivityRate({Key? key, required this.openDrawer})
      : super(key: key);

  @override
  _ProductivityRateState createState() => _ProductivityRateState();
}

class _ProductivityRateState extends State<ProductivityRate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: OpenDrawerWidget(
          onClicked: widget.openDrawer,
        ),
        title: const Text('Productivity Rate'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomWidgets().text_title('Productivity Rate', 20),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomWidgets().function_ButtonPR(
                    'Ceiling', 0.45, 0.05, context, (() => const Dummy())),
                CustomWidgets().function_ButtonPR(
                    'Formworks', 0.45, 0.05, context, (() => const Dummy())),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomWidgets().function_ButtonPR(
                    'Roofing', 0.45, 0.05, context, (() => const Dummy())),
                CustomWidgets().function_ButtonPR(
                    'Painting', 0.45, 0.05, context, (() => const Dummy())),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomWidgets().function_ButtonPR(
                    'Earthworks', 0.45, 0.05, context, (() => const Dummy())),
                CustomWidgets().function_ButtonPR(
                    'Plastering', 0.45, 0.05, context, (() => const Dummy())),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomWidgets().function_ButtonPR(
                    'Plumbing', 0.45, 0.05, context, (() => const Dummy())),
                CustomWidgets().function_ButtonPR(
                    'Electrical', 0.45, 0.05, context, (() => const Dummy())),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomWidgets().function_ButtonPR('Doors and Windows',
                  0.92, 0.05, context, (() => const Dummy()))),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: CustomWidgets().function_ButtonPR(
                  'Steel Reinforcement Works',
                  0.92,
                  0.05,
                  context,
                  (() => const Dummy()))),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: CustomWidgets().function_ButtonPR(
                  'Reinforced Cement Concreate',
                  0.92,
                  0.05,
                  context,
                  (() => const Dummy()))),
        ],
      ),
    );
  }
}
