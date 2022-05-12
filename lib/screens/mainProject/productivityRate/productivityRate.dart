// ignore_for_file: file_names

import 'package:engineering/model/ProjectModel.dart';
import 'package:engineering/screens/hamburgerMenu/openDrawer.dart';
import 'package:engineering/screens/mainProject/productivityRate/dummy.dart';
import 'package:engineering/screens/mainProject/productivityRate/forms/architectural/ceilingForm.dart';
import 'package:engineering/screens/mainProject/productivityRate/forms/architectural/flooringForm.dart';
import 'package:engineering/screens/mainProject/productivityRate/forms/electrical_plumbing/electricalWorksForm.dart';
import 'package:engineering/screens/mainProject/productivityRate/forms/electrical_plumbing/plumbingWorksForm.dart';
import 'package:engineering/screens/mainProject/productivityRate/forms/structural/formworksForm.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';

import 'forms/architectural/doorsnwindowsForm.dart';
import 'forms/architectural/paintingworksForm.dart';
import 'forms/architectural/plastering.dart';
import 'forms/architectural/roofingForm.dart';
import 'forms/structural/earthworksForm.dart';
import 'forms/structural/masonryForm.dart';
import 'forms/structural/reinforcedCementForm.dart';
import 'forms/structural/steelReinforcementForm.dart';

class ProductivityRate extends StatefulWidget {
  final VoidCallback openDrawer;
  final ProjectItem project;
  const ProductivityRate(
      {Key? key, required this.openDrawer, required this.project})
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomWidgets().text_subtitle('Structural', 20),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CustomWidgets().function_ButtonPR(
                    'Earthworks',
                    0.92,
                    0.05,
                    context,
                    (() => EarthworksForm(projectType: widget.project.type))),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CustomWidgets().function_ButtonPR(
                    'Formworks',
                    0.92,
                    0.05,
                    context,
                    (() => FormworksForm(projectType: widget.project.type))),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CustomWidgets().function_ButtonPR(
                    'Masonry Works',
                    0.92,
                    0.05,
                    context,
                    (() => MasonryWorksForm(projectType: widget.project.type))),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CustomWidgets().function_ButtonPR(
                    'Reinforced Cement Works',
                    0.92,
                    0.05,
                    context,
                    (() => ReinforcedCementForm(
                        projectType: widget.project.type))),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CustomWidgets().function_ButtonPR(
                    'Steel Reinforcement Works',
                    0.92,
                    0.05,
                    context,
                    (() => SteelReinforcementForm(
                        projectType: widget.project.type))),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomWidgets().text_subtitle('Architectural', 20),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CustomWidgets().function_ButtonPR(
                    'Flooring',
                    0.92,
                    0.05,
                    context,
                    (() => FlooringForm(projectType: widget.project.type))),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CustomWidgets().function_ButtonPR(
                    'Plastering',
                    0.92,
                    0.05,
                    context,
                    (() => PlasteringForm(projectType: widget.project.type))),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CustomWidgets().function_ButtonPR(
                    'Painting Works',
                    0.92,
                    0.05,
                    context,
                    (() =>
                        PaintingWorksForm(projectType: widget.project.type))),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CustomWidgets().function_ButtonPR(
                    'Doors and Windows',
                    0.92,
                    0.05,
                    context,
                    (() =>
                        DoorsnWindowsForm(projectType: widget.project.type))),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CustomWidgets().function_ButtonPR(
                    'Ceiling',
                    0.92,
                    0.05,
                    context,
                    (() => CeilingForm(projectType: widget.project.type))),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CustomWidgets().function_ButtonPR(
                    'Roofing Works',
                    0.92,
                    0.05,
                    context,
                    (() => RoofingWorksForm(projectType: widget.project.type))),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child:
                    CustomWidgets().text_subtitle('Electrical & Plumbing', 20),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CustomWidgets().function_ButtonPR(
                    'Electrical Works',
                    0.92,
                    0.05,
                    context,
                    (() =>
                        ElectricalWorksForm(projectType: widget.project.type))),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CustomWidgets().function_ButtonPR(
                    'Plumbing Works',
                    0.92,
                    0.05,
                    context,
                    (() =>
                        PlumbingWorksForm(projectType: widget.project.type))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
