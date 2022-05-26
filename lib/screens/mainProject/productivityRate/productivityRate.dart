// ignore_for_file: file_names

import 'package:engineering/model/ProjectModel.dart';
import 'package:engineering/screens/hamburgerMenu/openDrawer.dart';
import 'package:engineering/screens/mainProject/productivityRate/forms/structural/formworksForm.dart';
import 'package:engineering/screens/mainProject/productivityRate/forms/structural/masonryForm.dart';
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
  late List<FormData> formData;

  RegExp regex = RegExp(r'(?!^ +$)^.+$');
  List<String> soilType = ['Soft Soil', 'Hard Soil'];
  TextEditingController productivityRateController = TextEditingController();
  String? prodRate;
  String? _selectedType;
  bool isLoading = false;
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
    formData = await DatabaseHelper.instance.readForm(widget.project.id!);

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
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: OpenDrawerWidget(
          onClicked: widget.openDrawer,
        ),
        title: const Text('Productivity Rate'),
        //actions: [saveButton()],
      ),
      body: SingleChildScrollView(
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [structuralForms()],
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

  Widget structuralForms() =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: CustomWidgets().text_subtitle('Structural Forms', 20),
          ),
        ),
        //earthworks
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomWidgets().text_subtitle('Earthworks', 16),
        ),
        earthworksForm(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomWidgets().text_subtitle('Formworks', 16),
        ),
        formworksForm(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomWidgets().text_subtitle('Masonry Works', 16),
        ),
        masonryForm(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomWidgets().text_subtitle('Reinforced Cement Works', 16),
        ),
        rcwForm(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomWidgets().text_subtitle('Steel Reinforcement Works', 16),
        ),
        rcwForm(),
      ]);

  Widget earthworksForm() => Column(
        children: formData
            .map((form) => Container(
                child: form.work == 'Earthworks'
                    ? Center(
                        child: Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(form.type),
                            ),
                          ),
                          form.col_1 == 'DEFAULT'
                              ? Flexible(
                                  child: TextFormField(
                                    initialValue: form.col_1_val.toString(),
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          !regex.hasMatch(value)) {
                                        return '';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        // value = form.col_1_val.toString();
                                        prodRate = value;
                                        print(prodRate);
                                      });
                                    },
                                    keyboardType: TextInputType.number,
                                  ),
                                )
                              : Flexible(
                                  child: Row(
                                    children: [
                                      Flexible(
                                        flex: 2,
                                        child: DropdownButtonFormField(
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Required Soil Type';
                                              }
                                              return null;
                                            },
                                            value: _selectedType,
                                            onChanged: (value) {
                                              setState(() {
                                                _selectedType =
                                                    value.toString();
                                                if (_selectedType ==
                                                    "Soft Soil") {
                                                  setState(() {
                                                    defaultValue = 3;
                                                    productivityRateController
                                                            .text =
                                                        defaultValue.toString();
                                                  });
                                                } else {
                                                  setState(() {
                                                    defaultValue = 2;
                                                    productivityRateController
                                                            .text =
                                                        defaultValue.toString();
                                                  });
                                                }
                                              });
                                            },
                                            items: soilType.map((soilType) {
                                              return DropdownMenuItem(
                                                child: Text(soilType),
                                                value: soilType,
                                              );
                                            }).toList()),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: TextFormField(
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty ||
                                                      !regex.hasMatch(value)) {
                                                    return '';
                                                  }
                                                  return null;
                                                },
                                                controller:
                                                    productivityRateController,
                                                keyboardType:
                                                    TextInputType.number,
                                                onChanged: (value) {
                                                  setState(() {
                                                    prodRate = value;
                                                    print(prodRate);
                                                  });
                                                },
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          Flexible(
                            flex: 1,
                            child: ElevatedButton(
                                onPressed: () => {
                                      //_selectedType
                                      //double.parse(prodRate!)
                                    },
                                child: const Text("Save")),
                          )
                        ],
                      ))
                    : Container()))
            .toList(),
      );
  Widget formworksForm() => Column(
        children: formData
            .map((form) => Container(
                child: form.work == 'Formworks'
                    ? Center(
                        child: Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(form.type),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(form.col_1),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(form.col_1_val.toString()),
                            ),
                          ),
                          // Flexible(
                          //   child: IconButton(
                          //       onPressed: () => {setState(() {})},
                          //       icon: const Icon(Icons.create_rounded)),
                          // )
                        ],
                      ))
                    : Container()))
            .toList(),
      );

  Widget masonryForm() => Column(
        children: formData
            .map((form) => Container(
                child: form.work == 'Masonry Works'
                    ? Center(
                        child: Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(form.type),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(form.col_1),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(form.col_1_val.toString()),
                            ),
                          ),
                          // Flexible(
                          //   child: IconButton(
                          //       onPressed: () => {setState(() {})},
                          //       icon: const Icon(Icons.create_rounded)),
                          // )
                        ],
                      ))
                    : Container()))
            .toList(),
      );
  Widget rcwForm() => Column(
        children: formData
            .map((form) => Container(
                child: form.work == 'Reinforced Cement Works'
                    ? Center(
                        child: Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(form.type),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(form.col_1),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(form.col_1_val.toString()),
                            ),
                          ),
                          // Flexible(
                          //   child: IconButton(
                          //       onPressed: () => {setState(() {})},
                          //       icon: const Icon(Icons.create_rounded)),
                          // )
                        ],
                      ))
                    : Container()))
            .toList(),
      );

  Widget srwForm() => Column(
        children: formData
            .map((form) => Container(
                child: form.work == 'Steel Reinforcement Works'
                    ? Center(
                        child: Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(form.type),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(form.col_1),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(form.col_1_val.toString()),
                            ),
                          ),
                        ],
                      ))
                    : Container()))
            .toList(),
      );
  /* Widget saveButton() => ElevatedButton(
      onPressed: () {
        form.col_1 = _selectedType.toString();
        form.col_1_val = double.parse(prodRate!);
      },
      child: const Text('Save'));*/
}
