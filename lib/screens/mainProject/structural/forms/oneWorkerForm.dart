// ignore_for_file: file_names

import 'package:engineering/databaseHelper/DataBaseHelper.dart';
import 'package:engineering/model/ProductivityModel.dart';
import 'package:engineering/model/ProjectModel.dart';
import 'package:engineering/model/formModel.dart';
import 'package:engineering/model/workerModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../model/AdditionalManpowerModel.dart';

// ignore: must_be_immutable
class OneWorkerForm extends StatefulWidget {
  String workType;
  String structuralType;
  int projectFk;
  OneWorkerForm(
      {Key? key,
      required this.workType,
      required this.structuralType,
      required this.projectFk})
      : super(key: key);

  @override
  State<OneWorkerForm> createState() => _OneWorkerFormState();
}

class _OneWorkerFormState extends State<OneWorkerForm> {
  TextEditingController dateStartControler = TextEditingController();

  var outputFormat = DateFormat('MM/dd/yyyy');
  DateTime selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  RegExp regex = RegExp(r'(?!^ +$)^.+$');
  List<String> soilType = ['Soft Soil', 'Hard Soil'];
  List<WorkerType>? rateOfWorkers;
  List<ProductivityItem>? productivityRate;

  String? _selectedType;

  String? units, label, worker, surface;
  double? defaultValue;

  String? preferedTime;
  String? volume;
  TextEditingController productivityRateController = TextEditingController();

  bool isChecked = false,
      isChecked2 = false,
      isChecked3 = false,
      isChecked4 = false,
      isChecked5 = false,
      isChecked6 = false,
      isChecked7 = false,
      isChecked8 = false,
      isChecked9 = false,
      isChecked10 = false;
  double? cbOne,
      cbTwo,
      cbThree,
      cbFour,
      cbFive,
      cbSix,
      cbSeven,
      cbEight,
      cbNine,
      cbTen;
  double? totalPercentage;
  double percentage = 0;
  double? additionalWorker1;

  //database
  AdditionalManpower? manpower;
  FormData? formData;
  ProductivityItem? productivityItem;
  bool isLoading = false, isUpdating = false, isComputed = false;

  //auto populated
  int? numberOfDays, numberOfWorkers, worker_1;
  DateTime? dateEnd;
  double? costOfLabor, initialWorkers, initialNumberofDays, workerCost;

  /*Future<void> _selectDate(BuildContext context) async {
  //update prod rate
  String? dropdownValue;
  double? prodRateValue;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate!,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        isComputed = false;
      });
    }
  }*/

  Future readProdRate() async {
    productivityItem = await DatabaseHelper.instance.readSpecificProductivity(
        widget.projectFk,
        widget.structuralType,
        widget.workType,
        _selectedType ?? 'DEFAULT');
  }

  @override
  void initState() {
    refreshState();
    if (widget.structuralType == 'Earthworks') {
      if (widget.workType == 'Excavation') {
        label = 'Excavation';
      } else {
        label = 'Backfilling';
      }
      units = 'cum';
      surface = 'Volume';
      worker = 'Laborer';
    } else {
      if (widget.workType.contains('Column')) {
        label = 'Column';
      } else if (widget.workType.contains('Slab')) {
        label = 'Slab';
      } else if (widget.workType.contains('Beams')) {
        label = 'Beams';
      } else if (widget.workType.contains('Walls')) {
        label = 'Walls';
      } else if (widget.workType == 'Footings') {
        label = 'Footing';
      } else if (widget.workType == 'Lintels') {
        label = 'Lintels';
      } else if (widget.workType == 'Staircase') {
        label = 'Staircase';
      } else {
        label = 'Stirrups, spacers and links';
      }
      units = 'kg';
      worker = 'Steel man';
      surface = 'Weight';
    }
    super.initState();
  }

  Future refreshState() async {
    setState(() => isLoading = true);
    formData = await DatabaseHelper.instance
        .readFormData(widget.projectFk, widget.structuralType, widget.workType);
    manpower = await DatabaseHelper.instance.readAllManpower(
        widget.projectFk, widget.workType, widget.structuralType);
    rateOfWorkers = await DatabaseHelper.instance.readWorkers(widget.projectFk);
    productivityRate =
        await DatabaseHelper.instance.readAllProductivity(widget.projectFk);
    for (int i = 0; i < rateOfWorkers!.length; i++) {
      if (rateOfWorkers![i].workerType.toUpperCase() == worker!.toUpperCase()) {
        workerCost = rateOfWorkers![i].rate;
      }
    }
    if (formData != null) {
      if (formData!.date_start == null) {
        outputFormat.format(selectedDate);
      } else {
        DateTime test = DateTime.parse(formData!.date_start!);
        selectedDate = test;
      }
      volume = formData!.col_2.toString();
      numberOfDays = formData!.num_days;
      numberOfWorkers = formData!.num_workers;
      dateEnd = formData!.date_end == null
          ? null
          : DateTime.parse(formData!.date_end!);
      worker_1 = formData!.worker_1 == null ? null : formData!.worker_1!;
      costOfLabor = formData!.worker_1 == null
          ? null
          : (formData!.worker_1! * workerCost!) * numberOfDays!;
      // costOfLabor = formData!.cost_of_labor;
      preferedTime = formData!.pref_time.toString();
      totalPercentage = manpower!.totalPercentage;
      percentage = manpower!.totalPercentage;
      _selectedType = formData!.col_1;
      isUpdating = true;
    }
    readProdRate();
    if (manpower != null) {
      isChecked = manpower!.cbOne;
      isChecked2 = manpower!.cbTwo;
      isChecked3 = manpower!.cbThree;
      isChecked4 = manpower!.cbFour;
      isChecked5 = manpower!.cbFive;
      isChecked6 = manpower!.cbSix;
      isChecked7 = manpower!.cbSeven;
      isChecked8 = manpower!.cbEight;
      isChecked9 = manpower!.cbNine;
      isChecked10 = manpower!.cbTen;
      updateManpower();
    }
    prodRate();
    setState(() => isLoading = false);
    productivityRateController.text = defaultValue.toString();
    // if (formData != null) {}
    // print(productivityItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workType),
        actions: [isComputed ? saveButton() : Container()],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //date start
                    Row(
                      children: [
                        const Flexible(
                            flex: 3,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Date Start',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 15),
                                  )),
                            )),
                        Flexible(
                          flex: 4,
                          child: //date start
                              Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: TextField(
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: selectedDate,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2101));
                                if (pickedDate != null &&
                                    pickedDate != selectedDate) {
                                  setState(() {
                                    selectedDate = pickedDate;
                                    isComputed = false;
                                  });
                                }
                              },
                              decoration: InputDecoration(
                                  hintText: outputFormat
                                      .format(selectedDate)
                                      .toString()),
                            )),
                          ),
                        ),
                        const Flexible(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              //date start right side
                              '',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  label!,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(fontSize: 15),
                                )),
                          ),
                        ),
                        widget.workType == 'Excavation'
                            ? Flexible(
                                flex: 4,
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 4,
                                      child: DropdownButtonFormField(
                                          decoration: const InputDecoration(
                                            helperText: ' ', // this is new
                                          ),
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Required Soil Type';
                                            }
                                            return null;
                                          },
                                          value: _selectedType,
                                          onChanged: (value) {
                                            setState(() {
                                              isComputed = false;
                                              _selectedType = value.toString();
                                              if (_selectedType ==
                                                  "Soft Soil") {
                                                prodRate();
                                                productivityRateController
                                                        .text =
                                                    defaultValue.toString();
                                              } else {
                                                prodRate();
                                                productivityRateController
                                                        .text =
                                                    defaultValue.toString();
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
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: TextFormField(
                                              decoration: const InputDecoration(
                                                helperText: ' ', // this is new
                                              ),
                                              onChanged: (value) {
                                                setState(() {
                                                  isComputed = false;
                                                });
                                              },
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
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Flexible(
                                flex: 4,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 25, 8, 0),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              helperText: ' ', // this is new
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty ||
                                                  !regex.hasMatch(value)) {
                                                return 'This Field is Required';
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              setState(() {
                                                isComputed = false;
                                              });
                                            },
                                            controller:
                                                productivityRateController,
                                            keyboardType: TextInputType.number,
                                          ))),
                                ),
                              ),
                        Flexible(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  units! + '/day',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(fontSize: 15),
                                )),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  surface!,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(fontSize: 15),
                                )),
                          ),
                        ),
                        Flexible(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextFormField(
                                initialValue: volume == 'null' ? '' : volume,
                                decoration: const InputDecoration(
                                  helperText: ' ', // this is new
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      !regex.hasMatch(value)) {
                                    return 'This Fields is Required';
                                  }
                                  return null;
                                },

                                // controller: projectName.text,
                                onChanged: (value) {
                                  setState(() {
                                    isComputed = false;
                                    volume = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  units!,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(fontSize: 15),
                                )),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Flexible(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Preferred Time',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 15),
                                )),
                          ),
                        ),
                        Flexible(
                          flex: 4,
                          child: //preffered time
                              Padding(
                            padding: const EdgeInsets.all(8),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextFormField(
                                initialValue:
                                    preferedTime == 'null' ? '' : preferedTime,
                                decoration: const InputDecoration(
                                  helperText: ' ', // this is new
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      !regex.hasMatch(value)) {
                                    return 'This Field is Required';
                                  }
                                  return null;
                                },

                                // controller: projectName.text,
                                onChanged: (value) {
                                  setState(() {
                                    isComputed = false;
                                    preferedTime = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        const Flexible(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'day/s',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 15),
                                )),
                          ),
                        ),
                      ],
                    ),
                    computeButton(),
                    //number of days
                    Row(
                      children: [
                        const Flexible(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Number of days',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 15),
                                )),
                          ),
                        ),
                        Flexible(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Center(
                                  child: Text(
                                    numberOfDays != null
                                        ? numberOfDays.toString()
                                        : '',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                          ),
                        ),
                        const Flexible(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'day/s',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 15),
                                )),
                          ),
                        )
                      ],
                    ),
                    //date end
                    Row(children: [
                      const Flexible(
                        flex: 3,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Date End',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 15),
                              )),
                        ),
                      ),
                      Flexible(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Center(
                                child: Text(
                                  dateEnd != null
                                      ? outputFormat.format(dateEnd!)
                                      : '',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                        ),
                      ),
                      const Flexible(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                //date end right side
                                '',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 15),
                              )),
                        ),
                      )
                    ]),
                    //number of workers
                    Row(
                      children: [
                        const Flexible(
                            flex: 3,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Number of workers',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 15),
                                  )),
                            )),
                        Flexible(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Center(
                                  child: Text(
                                      numberOfWorkers != null
                                          ? numberOfWorkers!.toString()
                                          : '',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      )),
                                )),
                          ),
                        ),
                        const Flexible(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'worker/s',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 15),
                                )),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    //first worker number
                    Row(
                      children: [
                        Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  worker!,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(fontSize: 15),
                                )),
                          ),
                        ),
                        Flexible(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Center(
                                  child: Text(
                                    worker_1 != null
                                        ? worker_1!.toString()
                                        : '',
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                          ),
                        ),
                        const Flexible(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'worker/s',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 15),
                                )),
                          ),
                        )
                      ],
                    ),
                    //cost of labor
                    Row(
                      children: [
                        const Flexible(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Cost of Labor',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 15),
                                )),
                          ),
                        ),
                        Flexible(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Center(
                                  child: Text(
                                    costOfLabor != null
                                        ? costOfLabor.toString()
                                        : '',
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                          ),
                        ),
                        const Flexible(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'php',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 15),
                                )),
                          ),
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Additional Manpower',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    //cbone
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Checkbox(
                              checkColor: Colors.white,
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                  if (isChecked == true) {
                                    cbOne = 0.4;
                                    percentage = double.parse(
                                        (percentage + cbOne!)
                                            .toStringAsFixed(2));
                                  } else {
                                    cbOne = 0.4;
                                    percentage = double.parse(
                                        (percentage - cbOne!)
                                            .toStringAsFixed(2));
                                  }
                                  updateManpower();
                                });
                              },
                            ),
                          ),
                        ),
                        const Flexible(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Shortage of construction workers due to increase in number of construction projects',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        const Flexible(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              '40%',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //cbtwo
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Checkbox(
                              checkColor: Colors.white,
                              value: isChecked2,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked2 = value!;
                                  if (isChecked2 == true) {
                                    cbTwo = 0.1;
                                    percentage = double.parse(
                                        (percentage + cbTwo!)
                                            .toStringAsFixed(2));
                                  } else {
                                    cbTwo = 0.1;
                                    percentage = double.parse(
                                        (percentage - cbTwo!)
                                            .toStringAsFixed(2));
                                  }
                                });
                                updateManpower();
                              },
                            ),
                          ),
                        ),
                        const Flexible(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Unskilled construction workers due to lack of experience and training',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        const Flexible(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              '10%',
                              textAlign: TextAlign.end,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //cbthree
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Checkbox(
                              checkColor: Colors.white,
                              value: isChecked3,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked3 = value!;
                                  if (isChecked3 == true) {
                                    cbThree = 0.1;
                                    percentage = double.parse(
                                        (percentage + cbThree!)
                                            .toStringAsFixed(2));
                                  } else {
                                    cbThree = 0.1;
                                    percentage = double.parse(
                                        (percentage - cbThree!)
                                            .toStringAsFixed(2));
                                  }
                                });
                                updateManpower();
                              },
                            ),
                          ),
                        ),
                        const Flexible(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Language barrier between workers of different dialect',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        const Flexible(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              '10%',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //cbfour
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Checkbox(
                              checkColor: Colors.white,
                              value: isChecked4,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked4 = value!;
                                  if (isChecked4 == true) {
                                    cbFour = 0.1;
                                    percentage = double.parse(
                                        (percentage + cbFour!)
                                            .toStringAsFixed(2));
                                  } else {
                                    cbFour = 0.1;
                                    percentage = double.parse(
                                        (percentage - cbFour!)
                                            .toStringAsFixed(2));
                                  }
                                });
                                updateManpower();
                              },
                            ),
                          ),
                        ),
                        const Flexible(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Issues of overtime scheduling with construction workers',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        const Flexible(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              '10%',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //cbfive
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Checkbox(
                              checkColor: Colors.white,
                              value: isChecked5,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked5 = value!;
                                  if (isChecked5 == true) {
                                    cbFive = 0.1;
                                    percentage = double.parse(
                                        (percentage + cbFive!)
                                            .toStringAsFixed(2));
                                  } else {
                                    cbFive = 0.1;
                                    percentage = double.parse(
                                        (percentage - cbFive!)
                                            .toStringAsFixed(2));
                                  }
                                });
                                updateManpower();
                              },
                            ),
                          ),
                        ),
                        const Flexible(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              'Demand of higher salaries from construction workers',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        const Flexible(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              '10%',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //cbsix
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Checkbox(
                              checkColor: Colors.white,
                              value: isChecked6,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked6 = value!;
                                  if (isChecked6 == true) {
                                    cbSix = 0.1;
                                    percentage = double.parse(
                                        (percentage + cbSix!)
                                            .toStringAsFixed(2));
                                  } else {
                                    cbSix = 0.1;
                                    percentage = double.parse(
                                        (percentage - cbSix!)
                                            .toStringAsFixed(2));
                                  }
                                });
                                updateManpower();
                              },
                            ),
                          ),
                        ),
                        const Flexible(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Struggle with authority leading to conflict between construction workers and engineers',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        const Flexible(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              '10%',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //cbseven
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Checkbox(
                              checkColor: Colors.white,
                              value: isChecked7,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked7 = value!;
                                  if (isChecked7 == true) {
                                    cbSeven = 0.1;
                                    percentage = double.parse(
                                        (percentage + cbSeven!)
                                            .toStringAsFixed(2));
                                  } else {
                                    cbSeven = 0.1;
                                    percentage = double.parse(
                                        (percentage - cbSeven!)
                                            .toStringAsFixed(2));
                                  }
                                });
                                updateManpower();
                              },
                            ),
                          ),
                        ),
                        const Flexible(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Sudden absences of construction workers without prior notice to superiors',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        const Flexible(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              '10%',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //cbeight
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Checkbox(
                              checkColor: Colors.white,
                              value: isChecked8,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked8 = value!;
                                  if (isChecked8 == true) {
                                    cbEight = 0.1;
                                    percentage = double.parse(
                                        (percentage + cbEight!)
                                            .toStringAsFixed(2));
                                  } else {
                                    cbEight = 0.1;
                                    percentage = double.parse(
                                        (percentage - cbEight!)
                                            .toStringAsFixed(2));
                                  }
                                });
                                updateManpower();
                              },
                            ),
                          ),
                        ),
                        const Flexible(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Usage of electronic devices during working hours',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        const Flexible(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              '10%',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //cbnine
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Checkbox(
                              checkColor: Colors.white,
                              value: isChecked9,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked9 = value!;
                                  if (isChecked9 == true) {
                                    cbNine = 0.3;
                                    percentage = double.parse(
                                        (percentage + cbNine!)
                                            .toStringAsFixed(2));
                                  } else {
                                    cbNine = 0.3;
                                    percentage = double.parse(
                                        (percentage - cbNine!)
                                            .toStringAsFixed(2));
                                  }
                                });
                                updateManpower();
                              },
                            ),
                          ),
                        ),
                        const Flexible(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Sudden resignation of workers due to inadequate benefits, low wages, deployment abroad, etc.',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        const Flexible(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              '30%',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //cbten
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Checkbox(
                              checkColor: Colors.white,
                              value: isChecked10,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked10 = value!;
                                  if (isChecked10 == true) {
                                    cbTen = 0.1;
                                    percentage = double.parse(
                                        (percentage + cbTen!)
                                            .toStringAsFixed(2));
                                  } else {
                                    cbTen = 0.1;
                                    percentage = double.parse(
                                        (percentage - cbTen!)
                                            .toStringAsFixed(2));
                                  }
                                });
                                updateManpower();
                              },
                            ),
                          ),
                        ),
                        const Flexible(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Sudden Termination(Serious Injury, relocation, habitual neglect of duties, serious misconduct, fraud, loss of confidence, commission of a crime and analogous causes)',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        const Flexible(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              '10%',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //percentage
                    Row(
                      children: [
                        const Flexible(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Percent %',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 15),
                                )),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  (totalPercentage! * 100).toStringAsFixed(0),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    worker!,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(fontSize: 15),
                                  )),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    formData!.worker_1 != null
                                        ? additionalWorker1!.toStringAsFixed(0)
                                        : '',
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void earthworksComputer() {
    if (_formKey.currentState!.validate()) {
      if (double.parse(productivityRateController.text) <= 0 ||
          double.parse(volume!) <= 0 ||
          double.parse(preferedTime!) <= 0) {
        setState(() {
          isComputed = false;
        });
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: const Text('Invalid Input.'),
                  actions: <Widget>[
                    ElevatedButton(
                      child: const Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ]);
            });
      } else {
        initialWorkers = (double.parse(volume!) /
                double.parse(productivityRateController.text))
            .roundToDouble();
        if (initialWorkers! <= 3) {
          initialNumberofDays = 1;
        } else if (initialWorkers! >= 4 && initialWorkers! <= 6) {
          initialNumberofDays = 2;
        } else if (initialWorkers! >= 7 && initialWorkers! <= 9) {
          initialNumberofDays = 3;
        } else if (initialWorkers! >= 10 && initialWorkers! <= 12) {
          initialNumberofDays = 4;
        } else if (initialWorkers! >= 13 && initialWorkers! <= 15) {
          initialNumberofDays = 5;
        } else {
          initialNumberofDays = double.parse(preferedTime!);
        }
        if (double.parse(preferedTime!) < initialNumberofDays!) {
          initialNumberofDays = double.parse(preferedTime!);
        }
        int workernumbers = (initialWorkers! / initialNumberofDays!).round();
        if (workernumbers <= 0) {
          setState(() {
            isComputed = false;
          });
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: const Text('Invalid Input.'),
                    actions: <Widget>[
                      ElevatedButton(
                        child: const Text("OK"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ]);
              });
        } else {
          setState(() {
            numberOfDays = initialNumberofDays!.round();
            worker_1 = workernumbers;
            numberOfWorkers = workernumbers;
            costOfLabor = (workerCost! * workernumbers) * numberOfDays!;
            dateEnd = selectedDate.add(Duration(days: numberOfDays!));
            isComputed = true;
          });
        }
      }
    }
  }

  void srwComputer() {
    if (double.parse(productivityRateController.text) <= 0 ||
        double.parse(volume!) <= 0 ||
        double.parse(preferedTime!) <= 0) {
      setState(() {
        isComputed = false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: const Text('Invalid Input.'),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ]);
          });
    } else {
      if (_formKey.currentState!.validate()) {
        initialWorkers = (double.parse(volume!) /
                double.parse(productivityRateController.text))
            .roundToDouble();
        if (initialWorkers! == 1) {
          initialNumberofDays = 1;
        } else if (initialWorkers! == 2 || initialWorkers! == 4) {
          initialNumberofDays = 2;
        } else if (initialWorkers! == 3 ||
            initialWorkers! == 5 ||
            initialWorkers! == 6) {
          initialNumberofDays = 3;
        } else if (initialWorkers! == 7 ||
            initialWorkers! == 8 ||
            initialWorkers! == 11 ||
            initialWorkers! == 12) {
          initialNumberofDays = 4;
        } else if (initialWorkers! == 9 ||
            initialWorkers! == 10 ||
            initialWorkers! == 13 ||
            initialWorkers! == 14 ||
            initialWorkers! == 15) {
          initialNumberofDays = 5;
        } else {
          initialNumberofDays = double.parse(preferedTime!);
        }
        if (double.parse(preferedTime!) < initialNumberofDays!) {
          initialNumberofDays = double.parse(preferedTime!);
        }
        int workernumbers = (initialWorkers! / initialNumberofDays!).round();
        if (workernumbers <= 0) {
          setState(() {
            isComputed = false;
          });
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: const Text('Invalid Input.'),
                    actions: <Widget>[
                      ElevatedButton(
                        child: const Text("OK"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ]);
              });
        } else {
          setState(() {
            numberOfDays = initialNumberofDays!.round();
            worker_1 = workernumbers;
            numberOfWorkers = workernumbers;
            costOfLabor = (workerCost! * workernumbers) * numberOfDays!;
            dateEnd = selectedDate.add(Duration(days: numberOfDays!));
            isComputed = true;
          });
        }
      }
    }
  }

  void prodRate() {
    readProdRate();
    for (int i = 0; i < productivityRate!.length; i++) {
      if (productivityRate![i].type.toUpperCase() ==
              widget.workType.toUpperCase() &&
          productivityRate![i].work.toUpperCase() ==
              widget.structuralType.toUpperCase()) {
        if (productivityRate![i].col_1 == "DEFAULT" &&
            productivityRate![i].work.toUpperCase() ==
                widget.structuralType.toUpperCase()) {
          setState(() {
            defaultValue = productivityRate![i].col_1_val;
          });
        } else {
          if (productivityRate![i].col_1 == _selectedType) {
            setState(() {
              defaultValue = productivityRate![i].col_1_val;
            });
            // break;
          }
        }
      }
    }
  }

  Widget computeButton() => ElevatedButton(
      onPressed: () {
        widget.structuralType.toLowerCase() == 'earthworks'
            ? earthworksComputer()
            : srwComputer();
      },
      child: const Text('Compute'));

  Future updateManpower() async {
    totalPercentage = percentage;
    manpower = AdditionalManpower(
        id: manpower!.id!,
        fk: manpower!.fk,
        work: manpower!.work,
        type: manpower!.type,
        cbOne: isChecked,
        cbTwo: isChecked2,
        cbThree: isChecked3,
        cbFour: isChecked4,
        cbFive: isChecked5,
        cbSix: isChecked6,
        cbSeven: isChecked7,
        cbEight: isChecked8,
        cbNine: isChecked9,
        cbTen: isChecked10,
        totalPercentage: totalPercentage!);
    if (formData!.worker_1 != null) {
      additionalWorker1 = totalPercentage! * worker_1!;
      double decimalValue = additionalWorker1! - additionalWorker1!.toInt();
      if (decimalValue <= 0.09) {
        setState(() {
          additionalWorker1 = (additionalWorker1!.floor()).toDouble();
        });
      } else {
        setState(() {
          additionalWorker1 = (additionalWorker1!.ceil()).toDouble();
        });
      }
    }

    await DatabaseHelper.instance.updateManpower(manpower!);
  }

  Future updateProductivityRate() async {
    final updatePR = ProductivityItem(
      id: productivityItem!.id,
      fk: widget.projectFk,
      col_1: _selectedType ?? 'DEFAULT',
      col_1_val: double.parse(productivityRateController.text),
      work: productivityItem!.work,
      type: productivityItem!.type,
    );
    DatabaseHelper.instance.updateProductivityWithID(updatePR);
  }

  Widget saveButton() => ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          final formDataCreate = FormData(
            id: formData!.id,
            date_start: selectedDate.toString(),
            col_1: _selectedType ?? 'DEFAULT',
            col_1_val: double.parse(productivityRateController.text),
            col_2: double.parse(volume!),
            pref_time: int.parse(preferedTime!),
            num_days: numberOfDays!,
            date_end:
                selectedDate.add(Duration(days: numberOfDays!)).toString(),
            num_workers: numberOfWorkers!,
            worker_1: numberOfWorkers!,
            work: widget.structuralType,
            type: widget.workType,
            fk: widget.projectFk,
          );
          DatabaseHelper.instance.updateFormData(formDataCreate);

          updateManpower();
          updateProductivityRate();
          refreshState();
          setState(() {
            isComputed = false;
          });
        }
      },
      child: const Text('Save'));
}
