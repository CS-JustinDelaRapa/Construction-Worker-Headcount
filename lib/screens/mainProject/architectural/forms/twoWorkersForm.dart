// ignore_for_file: file_names
import 'package:engineering/databaseHelper/DataBaseHelper.dart';
import 'package:engineering/model/AdditionalManpowerModel.dart';
import 'package:engineering/model/formModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../model/workerModel.dart';

// ignore: must_be_immutable
class TwoWorkersForm extends StatefulWidget {
  String workType;
  String architecturalType;
  int projectFk;
  TwoWorkersForm(
      {Key? key,
      required this.workType,
      required this.architecturalType,
      required this.projectFk})
      : super(key: key);

  @override
  State<TwoWorkersForm> createState() => _TwoWorkersForm();
}

class _TwoWorkersForm extends State<TwoWorkersForm> {
  late String? units, label, worker, secondWorker, surface;
  late double? defaultValue;
  final _formKey = GlobalKey<FormState>();
  RegExp regex = RegExp(r'(?!^ +$)^.+$');
  List<String> extTileType = [
    'Mosaic Tile',
    'Ceramic Tile',
    'Vitrified Tile',
    'Granite Tile',
    'Marble Tile',
    'Glazed Tile',
  ];

  List<String> tileType = [
    'Mosaic Tile',
    'Ceramic Tile',
    'Marble Tile',
  ];

  // String? _selectedTileType;
  // String? _selectedExtTileType;

  String? _selectedType;

  var outputFormat = DateFormat('MM/dd/yyyy');
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        isComputed = false;
      });
    }
  }

  List<WorkerType>? rateOfWorkers;
  String? preferedTime;
  String? volume;
  TextEditingController productivityRateController = TextEditingController();
  TextEditingController dateStartControler = TextEditingController();
  bool isChecked = false,
      isChecked2 = false,
      isChecked3 = false,
      isChecked4 = false,
      isChecked5 = false,
      isChecked6 = false,
      isChecked7 = false,
      isChecked8 = false,
      isChecked9 = false,
      isChecked10 = false,
      isComputed = false;
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
  double? additionalWorker1, additionalWorker2;

  //database
  FormData? formData;
  AdditionalManpower? manpower;
  bool isLoading = false, isUpdating = false, isExceeded = false;

  //auto populated
  int? numberOfDays, numberOfWorkers, worker1, worker2;
  DateTime? dateEnd;
  double? costOfLabor,
      initialWorkers,
      initialNumberofDays,
      workerCost,
      workerCost2;

  @override
  void initState() {
    refreshState();
    if (widget.architecturalType == 'Flooring') {
      if (widget.workType.contains('EXT')) {
        label = 'EXT T&B';
        defaultValue = formData == null ? 7 : formData!.col_1_val;
      } else {
        label = 'T&B';
        defaultValue = formData == null ? 7 : formData!.col_1_val;
      }
      units = 'sqm';
      surface = 'Area';
      worker = 'Tile man';
      secondWorker = 'Laborer';
    } else if (widget.architecturalType == 'Plastering') {
      if (widget.workType.contains('Interior')) {
        defaultValue = 10;
      } else if (widget.workType.contains('Exterior')) {
        defaultValue = 8;
      }
      label = 'Finish';
      surface = 'Area';
      units = 'sqm';
      worker = 'Mason';
      secondWorker = 'Laborer';
    } else if (widget.architecturalType == 'Ceiling') {
      if (widget.workType.contains('Steel Frame')) {
        defaultValue = 21.28;
        label = 'Steel Frame';
      } else if (widget.workType.contains('Plywood')) {
        defaultValue = 16;
        label = 'Plywood';
      }
      surface = 'Area';
      units = 'sqm';
      worker = 'Carpenter';
      secondWorker = 'Laborer';
    } else {
      if (widget.workType.contains('Trusses')) {
        label = 'Trusses';
        defaultValue = 4;
        worker = 'Welder';
        surface = 'PCS';
      } else if (widget.workType.contains('Gutter')) {
        label = 'Gl Sheet';
        defaultValue = 11.52;
        worker = 'Tinsmith';
        surface = 'Area';
      } else {
        label = 'Gl Sheet';
        defaultValue = 0; // no productivity rate yet
        worker = 'Tinsmith';
        surface = 'Area';
      }
      units = 'sqm';
      secondWorker = 'Laborer';
    }
    super.initState();
  }

  Future refreshState() async {
    setState(() => isLoading = true);
    formData = await DatabaseHelper.instance.readFormData(
        widget.projectFk, widget.architecturalType, widget.workType);
    manpower = await DatabaseHelper.instance.readAllManpower(
        widget.projectFk, widget.workType, widget.architecturalType);
    rateOfWorkers = await DatabaseHelper.instance.readWorkers(widget.projectFk);
    for (int i = 0; i < rateOfWorkers!.length; i++) {
      if (rateOfWorkers![i].workerType.toUpperCase() == worker!.toUpperCase()) {
        workerCost = rateOfWorkers![i].rate;
      } else if (rateOfWorkers![i].workerType.toUpperCase() ==
          secondWorker!.toUpperCase()) {
        workerCost2 = rateOfWorkers![i].rate;
      }
    }
    if (formData != null) {
      if (formData!.date_start == null) {
        outputFormat.format(selectedDate);
      } else {
        DateTime test = DateTime.parse(formData!.date_start!);
        selectedDate = test;
      }
      defaultValue = formData!.col_1_val;
      volume = formData!.col_2.toString();
      numberOfDays = formData!.num_days;
      numberOfWorkers = formData!.num_workers;
      dateEnd = formData!.date_end == null
          ? null
          : DateTime.parse(formData!.date_end!);
      worker1 = formData!.worker_1 == null ? null : formData!.worker_1!;
      worker2 = formData!.worker_2 == null ? null : formData!.worker_2!;
      costOfLabor = formData!.worker_1 == null
          ? null
          : ((formData!.worker_1!.toDouble() * workerCost!) +
                  (formData!.worker_2!.toDouble() * workerCost2!)) *
              numberOfDays!;
      preferedTime = formData!.pref_time.toString();
      totalPercentage = manpower!.totalPercentage;
      percentage = manpower!.totalPercentage;
      _selectedType = formData!.col_1;
      defaultValue = formData!.col_1_val;
      isUpdating = true;
    }

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
    setState(() => isLoading = false);
    productivityRateController.text = defaultValue.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.workType),
          actions: [isComputed ? saveButton() : Container()],
        ),
        body: isLoading || formData == null
            ? const Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(children: [
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
                          ),
                        ),
                        Flexible(
                          flex: 4,
                          child: //date start
                              Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: TextField(
                              readOnly: true,
                              controller: dateStartControler,
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
                    //productivity rate
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        widget.workType.contains('EXT T&B') &&
                                widget.architecturalType == 'Flooring'
                            ? Flexible(
                                flex: 5,
                                child: Row(
                                  children: [
                                    Flexible(flex: 3, child: extDropdown()),
                                    Flexible(
                                      flex: 1,
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              decoration: const InputDecoration(
                                                helperText: ' ', // this is new
                                              ),
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
                                                  isComputed = false;
                                                });
                                              },
                                              controller:
                                                  productivityRateController,
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              )
                            : widget.workType.contains('T&B') &&
                                    widget.architecturalType == 'Flooring'
                                ? Flexible(
                                    flex: 5,
                                    child: Row(
                                      children: [
                                        Flexible(flex: 3, child: intDropdown()),
                                        Flexible(
                                          flex: 1,
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  decoration:
                                                      const InputDecoration(
                                                    helperText:
                                                        ' ', // this is new
                                                  ),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty ||
                                                        !regex
                                                            .hasMatch(value)) {
                                                      return '';
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
                                                  keyboardType:
                                                      TextInputType.number,
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                  )
                                : Flexible(
                                    flex: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8, 20, 8, 0),
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
                                                return '';
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
                                  units! + '/day',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(fontSize: 15),
                                )),
                          ),
                        ),
                      ],
                    ),
                    //volume
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
                        //area
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
                                    return 'This Field is Required';
                                  }
                                  return null;
                                },

                                // controller: projectName.text,
                                onChanged: (value) {
                                  setState(() {
                                    volume = value;
                                    isComputed = false;
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
                    //preferred time
                    Row(
                      children: [
                        const Flexible(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Preferred time',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 15),
                                )),
                          ),
                        ),
                        Flexible(
                          flex: 4,
                          child: //prefered time
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
                                onChanged: (value) {
                                  setState(() {
                                    preferedTime = value;
                                    isComputed = false;
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
                    // number of days
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
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
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
                    //date ned
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
                        flex: 5,
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
                                      fontWeight: FontWeight.bold),
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
                    //number of worker
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
                                        ? numberOfWorkers.toString()
                                        : '',
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
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
                    const SizedBox(
                      height: 30,
                    ),
                    //first worker count
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
                                    worker2 != null ? worker1.toString() : '',
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
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
                    //second worker count
                    Row(
                      children: [
                        Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  secondWorker!,
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
                                    worker2 != null ? worker2.toString() : '',
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
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
                                          fontWeight: FontWeight.bold)),
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
                        textAlign: TextAlign.left,
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
                    //addtl first worker
                    Row(
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
                                    secondWorker!,
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
                                    formData!.worker_2 != null
                                        ? additionalWorker2!.toStringAsFixed(0)
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
                  ]),
                ),
              ));
  }

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
      totalPercentage: totalPercentage!,
    );
    if (formData!.worker_1 != null) {
      additionalWorker1 = totalPercentage! * worker1!;
      additionalWorker2 = totalPercentage! * worker2!;
      double decimalValue = additionalWorker1! - additionalWorker1!.toInt();
      double secondDecimalValue =
          additionalWorker2! - additionalWorker2!.toInt();
      if (decimalValue <= 0.09) {
        setState(() {
          additionalWorker1 = (additionalWorker1!.floor()).toDouble();
        });
      } else {
        setState(() {
          additionalWorker1 = (additionalWorker1!.ceil()).toDouble();
        });
      }
      if (secondDecimalValue <= 0.09) {
        setState(() {
          additionalWorker2 = (additionalWorker2!.floor()).toDouble();
        });
      } else {
        setState(() {
          additionalWorker2 = (additionalWorker2!.ceil()).toDouble();
        });
      }
    }

    await DatabaseHelper.instance.updateManpower(manpower!);
  }

  Widget extDropdown() => DropdownButtonFormField(
      decoration: const InputDecoration(
        helperText: ' ', // this is new
      ),
      validator: (value) {
        if (value == null) {
          return 'Required Tile Type';
        }
        return null;
      },
      hint: const Text('Tile Type'), // Not necessary for Option 1
      value: _selectedType,
      onChanged: (value) {
        setState(() {
          _selectedType = value.toString();
          if (_selectedType == "Mosaic Tile") {
            defaultValue = 7;
            productivityRateController.text = defaultValue.toString();
          } else if (_selectedType == "Ceramic Tile") {
            defaultValue = 7;
            productivityRateController.text = defaultValue.toString();
          } else if (_selectedType == "Vitrified Tile") {
            defaultValue = 10;
            productivityRateController.text = defaultValue.toString();
          } else if (_selectedType == "Granite Tile") {
            defaultValue = 5;
            productivityRateController.text = defaultValue.toString();
          } else if (_selectedType == "Marble Tile") {
            defaultValue = 5;
            productivityRateController.text = defaultValue.toString();
          } else {
            defaultValue = 8;
            productivityRateController.text = defaultValue.toString();
          }
        });
      },
      items: extTileType.map((extTileType) {
        return DropdownMenuItem(
          child: Text(extTileType),
          value: extTileType,
        );
      }).toList());

  Widget intDropdown() => DropdownButtonFormField(
      decoration: const InputDecoration(
        helperText: ' ', // this is new
      ),
      validator: (value) {
        if (value == null) {
          return 'Required Tile Type';
        }
        return null;
      },
      hint: const Text('Tile Type'), // Not necessary for Option 1
      value: _selectedType,
      onChanged: (value) {
        setState(() {
          _selectedType = value.toString();
          if (_selectedType == "Mosaic Tile") {
            defaultValue = 7;
            productivityRateController.text = defaultValue.toString();
          } else if (_selectedType == "Ceramic Tile") {
            defaultValue = 7;
            productivityRateController.text = defaultValue.toString();
          } else {
            defaultValue = 5;
            productivityRateController.text = defaultValue.toString();
          }
        });
      },
      items: tileType.map((tileType) {
        return DropdownMenuItem(
          child: Text(tileType),
          value: tileType,
        );
      }).toList());

  void flooringComputer() {
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
        if (initialWorkers! >= 1 && initialWorkers! <= 3) {
          initialNumberofDays = 1;
        } else if (initialWorkers! >= 4 && initialWorkers! <= 6) {
          initialNumberofDays = 2;
        } else if (initialWorkers! >= 7 && initialWorkers! <= 9) {
          initialNumberofDays = 3;
        } else if (initialWorkers! == 10) {
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
            if (workernumbers <= 2) {
              worker1 = workernumbers;
              worker2 = 1;
            } else if (workernumbers == 3) {
              worker1 = 2;
              worker2 = 2;
            } else {
              worker1 = 3;
              worker2 = workernumbers;
            }
            numberOfDays = initialNumberofDays!.round();
            numberOfWorkers = (worker1! + worker2!);
            costOfLabor = ((worker1!.toDouble() * workerCost!) +
                    (worker2!.toDouble() * workerCost2!)) *
                numberOfDays!;
            dateEnd = selectedDate.add(Duration(days: numberOfDays!));
            isComputed = true;
          });
        }
      }
    }
  }

  void plasteringWorksComputer() {
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
        if (initialWorkers! >= 1 && initialWorkers! <= 3) {
          initialNumberofDays = 1;
        } else if (initialWorkers! >= 4 && initialWorkers! <= 6) {
          initialNumberofDays = 2;
        } else if (initialWorkers! >= 7 && initialWorkers! <= 9) {
          initialNumberofDays = 3;
        } else if (initialWorkers! == 10) {
          initialNumberofDays = 5;
        } else {
          initialNumberofDays = double.parse(preferedTime!);
        }
        int workernumbers = (initialWorkers! / initialNumberofDays!).round();
        if (double.parse(preferedTime!) < initialNumberofDays!) {
          initialNumberofDays = double.parse(preferedTime!);
        }
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
            if (workernumbers <= 2) {
              worker1 = workernumbers;
              worker2 = 1;
            } else if (workernumbers == 3) {
              worker1 = 2;
              worker2 = 2;
            } else {
              worker1 = 2;
              worker2 = workernumbers;
            }
            numberOfDays = initialNumberofDays!.round();
            numberOfWorkers = (worker1! + worker2!);
            costOfLabor = ((worker1!.toDouble() * workerCost!) +
                    (worker2!.toDouble() * workerCost2!)) *
                numberOfDays!;
            dateEnd = selectedDate.add(Duration(days: numberOfDays!));
            isComputed = true;
          });
        }
      }
    }
  }

  void ceilingComputer() {
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
        if (initialWorkers! == 1 || initialWorkers! == 2) {
          initialNumberofDays = 1;
        } else if (initialWorkers! == 2 || initialWorkers! == 4) {
          initialNumberofDays = 2;
        } else if (initialWorkers! == 3 || initialWorkers! == 6) {
          initialNumberofDays = 3;
        } else if (initialWorkers! == 7 || initialWorkers! == 8) {
          initialNumberofDays = 4;
        } else if (initialWorkers! == 5 ||
            initialWorkers! == 9 ||
            initialWorkers! == 10) {
          initialNumberofDays = 5;
        } else {
          initialNumberofDays = double.parse(preferedTime!);
        }
        int workernumbers = (initialWorkers! / initialNumberofDays!).round();
        if (double.parse(preferedTime!) < initialNumberofDays!) {
          initialNumberofDays = double.parse(preferedTime!);
        }
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
            if (workernumbers <= 2) {
              worker1 = workernumbers;
              worker2 = 1;
            } else {
              worker1 = 2;
              worker2 = workernumbers;
            }
            numberOfDays = initialNumberofDays!.round();
            numberOfWorkers = (worker1! + worker2!);
            costOfLabor = (worker1!.toDouble() * workerCost!) +
                (worker2!.toDouble() * workerCost2!);
            dateEnd = selectedDate.add(Duration(days: numberOfDays!));
            isComputed = true;
          });
        }
      }
    }
  }

  void roofingComputer() {
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
        if (initialWorkers! == 1 && initialWorkers! <= 3) {
          initialNumberofDays = 1;
        } else if (initialWorkers! >= 4 && initialWorkers! <= 6) {
          initialNumberofDays = 2;
        } else if (initialWorkers! >= 7 && initialWorkers! <= 9) {
          initialNumberofDays = 3;
        } else if (initialWorkers! == 10) {
          initialNumberofDays = 5;
        } else {
          initialNumberofDays = double.parse(preferedTime!);
        }
        int workernumbers = (initialWorkers! / initialNumberofDays!).round();
        if (double.parse(preferedTime!) < initialNumberofDays!) {
          initialNumberofDays = double.parse(preferedTime!);
        }
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
            if (workernumbers <= 2) {
              worker1 = 1;
              worker2 = 1;
            } else if (workernumbers == 3) {
              worker1 = 2;
              worker2 = 1;
            } else if (workernumbers == 4) {
              worker1 = 2;
              worker2 = 2;
            } else {
              worker1 = 2;
              worker2 = workernumbers - 2;
            }
            numberOfDays = initialNumberofDays!.round();
            numberOfWorkers = (worker1! + worker2!);
            costOfLabor = ((worker1!.toDouble() * workerCost!) +
                    (worker2!.toDouble() * workerCost2!)) *
                numberOfDays!;
            dateEnd = selectedDate.add(Duration(days: numberOfDays!));
            isComputed = true;
          });
        }
      }
    }
  }

  Widget computeButton() => ElevatedButton(
      onPressed: () {
        if (widget.architecturalType.toLowerCase() == 'flooring') {
          flooringComputer();
        } else if (widget.architecturalType.toLowerCase() == 'plastering') {
          plasteringWorksComputer();
        } else if (widget.architecturalType.toLowerCase() == 'ceiling') {
          ceilingComputer();
        } else if (widget.architecturalType.toLowerCase() == 'roofing works') {
          roofingComputer();
        }
      },
      child: const Text('Compute'));

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
            worker_1: worker1!,
            worker_2: worker2!,
            work: widget.architecturalType,
            type: widget.workType,
            fk: widget.projectFk,
          );
          DatabaseHelper.instance.updateFormData(formDataCreate);
          refreshState();
          updateManpower();
          setState(() {
            isComputed = false;
          });
        }
      },
      child: const Text('Save'));
}
