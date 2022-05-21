// ignore_for_file: file_names

import 'package:engineering/model/ProjectModel.dart';
import 'package:engineering/screens/hamburgerMenu/openDrawer.dart';
import 'package:engineering/screens/mainProject/structural/items/twoStoreyStructuralItems.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:engineering/model/formModel.dart';
import '../architectural/items/bungalowArchitecturalItem.dart';
import '../architectural/items/twoStoreyArchitecturalItem.dart';
import 'package:engineering/databaseHelper/DataBaseHelper.dart';
import '../structural/items/bungalowStructuralItem.dart';

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
  // late List<FormData> formData;
  late List<FormData> formData2;

  RegExp regex = RegExp(r'(?!^ +$)^.+$');
  List<String> soilType = ['Soft Soil', 'Hard Soil'];
  TextEditingController productivityRateController = TextEditingController();
  String? _selectedType;
  bool isLoading = true;
  double? defaultValue;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    refreshState();
  }

  Future refreshState() async {
    setState(() => isLoading = true);

    // formData = await DatabaseHelper.instance.readProductivityForm(
    //     widget.project.id!, BungalowStructuralItems.earthWorks.title);
    formData2 = await DatabaseHelper.instance.readForm(widget.project.id!);

    // for (int x = 0; x < formData.length; x++) {
    //   if (formData[x].type == "Excavation") {
    //     _selectedType = formData[x].col_1;
    //     defaultValue = formData[x].col_1_val;
    //   }
    // }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.project.type);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: OpenDrawerWidget(
          onClicked: widget.openDrawer,
        ),
        title: const Text('Productivity Rate'),
      ),
      body: SingleChildScrollView(
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: CustomWidgets()
                            .text_subtitle('Structural Forms', 20),
                      ),
                    ),
                    //earthworks
                    structuralForms()
                  ],
                )

          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: CustomWidgets().text_subtitle('Structural', 20),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 12),
          //   child: CustomWidgets().function_ButtonPR(
          //       'Earthworks',
          //       0.92,
          //       0.05,
          //       context,
          //       (() => EarthworksForm(projectType: widget.project))),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 12),
          //   child: CustomWidgets().function_ButtonPR(
          //       'Formworks',
          //       0.92,
          //       0.05,
          //       context,
          //       (() => FormworksForm(projectType: widget.project.type))),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 12),
          //   child: CustomWidgets().function_ButtonPR(
          //       'Masonry Works',
          //       0.92,
          //       0.05,
          //       context,
          //       (() => MasonryWorksForm(projectType: widget.project.type))),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 12),
          //   child: CustomWidgets().function_ButtonPR(
          //       'Reinforced Cement Works',
          //       0.92,
          //       0.05,
          //       context,
          //       (() => ReinforcedCementForm(
          //           projectType: widget.project.type))),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 12),
          //   child: CustomWidgets().function_ButtonPR(
          //       'Steel Reinforcement Works',
          //       0.92,
          //       0.05,
          //       context,
          //       (() => SteelReinforcementForm(
          //           projectType: widget.project.type))),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: CustomWidgets().text_subtitle('Architectural', 20),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 12),
          //   child: CustomWidgets().function_ButtonPR(
          //       'Flooring',
          //       0.92,
          //       0.05,
          //       context,
          //       (() => FlooringForm(projectType: widget.project.type))),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 12),
          //   child: CustomWidgets().function_ButtonPR(
          //       'Plastering',
          //       0.92,
          //       0.05,
          //       context,
          //       (() => PlasteringForm(projectType: widget.project.type))),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 12),
          //   child: CustomWidgets().function_ButtonPR(
          //       'Painting Works',
          //       0.92,
          //       0.05,
          //       context,
          //       (() =>
          //           PaintingWorksForm(projectType: widget.project.type))),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 12),
          //   child: CustomWidgets().function_ButtonPR(
          //       'Doors and Windows',
          //       0.92,
          //       0.05,
          //       context,
          //       (() =>
          //           DoorsnWindowsForm(projectType: widget.project.type))),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 12),
          //   child: CustomWidgets().function_ButtonPR(
          //       'Ceiling',
          //       0.92,
          //       0.05,
          //       context,
          //       (() => CeilingForm(projectType: widget.project.type))),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 12),
          //   child: CustomWidgets().function_ButtonPR(
          //       'Roofing Works',
          //       0.92,
          //       0.05,
          //       context,
          //       (() => RoofingWorksForm(projectType: widget.project.type))),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child:
          //       CustomWidgets().text_subtitle('Electrical & Plumbing', 20),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 12),
          //   child: CustomWidgets().function_ButtonPR(
          //       'Electrical Works',
          //       0.92,
          //       0.05,
          //       context,
          //       (() =>
          //           ElectricalWorksForm(projectType: widget.project.type))),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 12),
          //   child: CustomWidgets().function_ButtonPR(
          //       'Plumbing Works',
          //       0.92,
          //       0.05,
          //       context,
          //       (() =>
          //           PlumbingWorksForm(projectType: widget.project.type))),
          // ),

          ),
    );
  }

  Widget structuralForms() => Column(
        children: formData2
            .map((form) => Center(
                    child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(form.type),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(form.col_1),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(form.col_1_val.toString()),
                    ),
                    ElevatedButton(
                        onPressed: () => {
                              print(form.id.toString() +
                                  form.col_1_val.toString() +
                                  form.col_1)
                            },
                        child: const Text('save'))
                  ],
                )))
            .toList(),
      );
}
