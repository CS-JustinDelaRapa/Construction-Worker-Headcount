// ignore_for_file: file_names

import 'package:engineering/model/ProjectModel.dart';
import 'package:engineering/screens/hamburgerMenu/openDrawer.dart';
import 'package:engineering/screens/mainProject/productivityRate/forms/structural/formworksForm.dart';
import 'package:engineering/screens/mainProject/productivityRate/forms/structural/masonryForm.dart';
import 'package:engineering/screens/mainProject/structural/items/twoStoreyStructuralItems.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:engineering/model/formModel.dart';
import '../../../model/ProductivityModel.dart';
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
  List<FormData>? formData;
  List<ProductivityItem>? productivityData;
  TextEditingController excavationController = TextEditingController();
  TextEditingController mInteriorController = TextEditingController();
  TextEditingController mExteriorController = TextEditingController();

  RegExp regex = RegExp(r'(?!^ +$)^.+$');
  List<String> soilType = ['Soft Soil', 'Hard Soil'];
  List<String> exteriorWalls = ['8', '6'];
  List<String> interiorWalls = ['6', '4'];

  String? prodRate;

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
    productivityData =
        await DatabaseHelper.instance.readAllProductivity(widget.project.id!);
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

  double? getProductivityRate(String x, String y) {
    double? prodValue;
    for (int i = 0; i < productivityData!.length; i++) {
      if (productivityData![i].type.toUpperCase() == x.toUpperCase() &&
          productivityData![i].col_1.toUpperCase() == y.toUpperCase()) {
        print('pumasok' + productivityData![i].col_1_val.toString());
        prodValue = productivityData![i].col_1_val;
      }
    }
    return prodValue;
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
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: srwForm(),
        ),
      ]);

  Widget earthworksForm() => Column(
          children: formData!
              .where((element) => element.work == 'Earthworks')
              .map((form) {
        double? initialValue;
        String? _selectedType;

        if (form.work == 'Earthworks') {
          for (int i = 0; i < productivityData!.length; i++) {
            if (productivityData![i].type.toUpperCase() ==
                    form.type.toUpperCase() &&
                form.work == productivityData![i].work) {
              initialValue = productivityData![i].col_1_val;
            }
          }
        }
        return Container(
            child: form.work == 'Earthworks'
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Text(form.type)),
                        form.col_1 == 'DEFAULT'
                            ? Flexible(
                                flex: 2,
                                child: TextFormField(
                                  initialValue: initialValue.toString(),
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
                                      prodRate = value;
                                    });
                                  },
                                  keyboardType: TextInputType.number,
                                ),
                              )
                            : Flexible(
                                flex: 4,
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
                                          hint: const Text('Soil Type'),
                                          value: _selectedType,
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedType = value.toString();
                                              if (_selectedType ==
                                                  "Soft Soil") {
                                                setState(() {
                                                  initialValue =
                                                      getProductivityRate(
                                                          form.type,
                                                          _selectedType!);
                                                  excavationController.text =
                                                      initialValue.toString();
                                                });
                                              } else {
                                                setState(() {
                                                  initialValue =
                                                      getProductivityRate(
                                                          form.type,
                                                          _selectedType!);
                                                  excavationController.text =
                                                      initialValue.toString();
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
                                              controller: excavationController,
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (value) {
                                                setState(() {
                                                  prodRate = value;
                                                });
                                              },
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        Flexible(
                          flex: 2,
                          child: ElevatedButton(
                              onPressed: () => {
                                    //_selectedType
                                    //double.parse(prodRate!)
                                  },
                              child: const Text("Save")),
                        )
                      ],
                    ),
                  )
                : Container());
      }).toList());

  Widget formworksForm() => Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children:
          formData!.where((element) => element.work == 'Formworks').map((form) {
        double? initialValue;
        for (int i = 0; i < productivityData!.length; i++) {
          if (productivityData![i].type.toUpperCase() ==
                  form.type.toUpperCase() &&
              form.work == productivityData![i].work) {
            print(form.type);
            print(form.col_1_val.toString());
            initialValue = productivityData![i].col_1_val;
            break;
          }
        }
        return
            //Text(form.col_1_val.toString());
            Container(
                child: form.work == 'Formworks'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Text(form.type)),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: TextFormField(
                                initialValue: initialValue.toString(),
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
                                    prodRate = value;
                                  });
                                },
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: ElevatedButton(
                                  onPressed: () => {
                                        //_selectedType
                                        //double.parse(prodRate!)
                                      },
                                  child: const Text("Save")),
                            )
                          ],
                        ),
                      )
                    : Container());
      }).toList());

  Widget masonryForm() => Column(
          children: formData!
              .where((element) => element.work == 'Masonry Works')
              .map((form) {
        double? initialValue;
        String? _selectedType;
        TextEditingController test = TextEditingController();
        return Container(
            child: form.work == 'Masonry Works'
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Text(form.type)),
                        form.type.contains('Interior') &&
                                form.work == 'Masonry Works'
                            ? Flexible(
                                flex: 4,
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 2,
                                      child: DropdownButtonFormField(
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Required CHB Walls';
                                            }
                                            return null;
                                          },
                                          hint: const Text('CHB Walls'),
                                          value: _selectedType,
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedType = value.toString();
                                              if (_selectedType == "6") {
                                                setState(() {
                                                  initialValue =
                                                      getProductivityRate(
                                                          form.type,
                                                          _selectedType!);
                                                  test.text =
                                                      initialValue.toString();
                                                });
                                              } else {
                                                setState(() {
                                                  initialValue =
                                                      getProductivityRate(
                                                          form.type,
                                                          _selectedType!);
                                                  test.text =
                                                      initialValue.toString();
                                                });
                                              }
                                            });
                                          },
                                          items:
                                              interiorWalls.map((interiorType) {
                                            return DropdownMenuItem(
                                              child: Text(interiorType + "\""),
                                              value: interiorType,
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
                                              controller: test,
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (value) {
                                                setState(() {
                                                  prodRate = value;
                                                });
                                              },
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Flexible(
                                flex: 4,
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 2,
                                      child: DropdownButtonFormField(
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Required CHB Walls';
                                            }
                                            return null;
                                          },
                                          hint: const Text('CHB Walls'),
                                          value: _selectedType,
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedType = value.toString();
                                              if (_selectedType == "8") {
                                                setState(() {
                                                  initialValue =
                                                      getProductivityRate(
                                                          form.type,
                                                          _selectedType!);
                                                  mExteriorController.text =
                                                      initialValue.toString();
                                                });
                                              } else {
                                                setState(() {
                                                  initialValue =
                                                      getProductivityRate(
                                                          form.type,
                                                          _selectedType!);
                                                  mExteriorController.text =
                                                      initialValue.toString();
                                                });
                                              }
                                            });
                                          },
                                          items:
                                              exteriorWalls.map((exteriorType) {
                                            return DropdownMenuItem(
                                              child: Text(exteriorType + "\""),
                                              value: exteriorType,
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
                                              controller: mExteriorController,
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
                          flex: 2,
                          child: ElevatedButton(
                              onPressed: () => {
                                    //_selectedType
                                    //double.parse(prodRate!)
                                  },
                              child: const Text("Save")),
                        )
                      ],
                    ),
                  )
                : Container());
      }).toList());

  Widget rcwForm() => Column(
          children: formData!
              .where((element) => element.work == 'Reinforced Cement Works')
              .map((form) {
        double? initialValue;
        for (int i = 0; i < productivityData!.length; i++) {
          if (productivityData![i].type.toUpperCase() ==
                  form.type.toUpperCase() &&
              form.work == productivityData![i].work) {
            initialValue = productivityData![i].col_1_val;
          }
        }
        return Container(
            child: form.work == 'Reinforced Cement Works'
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Text(form.type)),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: TextFormField(
                            initialValue: initialValue.toString(),
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
                                prodRate = value;
                              });
                            },
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: ElevatedButton(
                              onPressed: () => {
                                    //_selectedType
                                    //double.parse(prodRate!)
                                  },
                              child: const Text("Save")),
                        )
                      ],
                    ),
                  )
                : Container());
      }).toList());

  Widget srwForm() => Column(
          children: formData!
              .where((element) => element.work == 'Steel Reinforcement Works')
              .map((form) {
        double? initialValue;
        if (form.work == 'Steel Reinforcement Works') {
          for (int i = 0; i < productivityData!.length; i++) {
            if (productivityData![i].type.toUpperCase() ==
                    form.type.toUpperCase() &&
                form.work == productivityData![i].work) {
              initialValue = productivityData![i].col_1_val;
            }
          }
        }
        return
            // Text(form.type);
            Container(
                child: form.work == 'Steel Reinforcement Works'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Text(form.type)),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: TextFormField(
                                initialValue: initialValue.toString(),
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
                                    prodRate = value;
                                  });
                                },
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: ElevatedButton(
                                  onPressed: () => {
                                        //_selectedType
                                        //double.parse(prodRate!)
                                      },
                                  child: const Text("Save")),
                            )
                          ],
                        ),
                      )
                    : Container());
      }).toList());
}
