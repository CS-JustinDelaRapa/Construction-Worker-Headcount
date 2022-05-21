// ignore_for_file: file_names

import 'package:engineering/model/AdditionalManpowerModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../databaseHelper/DataBaseHelper.dart';
import '../../../../model/formModel.dart';
import '../../../../model/workerModel.dart';

// ignore: must_be_immutable
class OneWorkerForm extends StatefulWidget {
  String workType;
  String architecturalType;
  int projectFk;
  OneWorkerForm(
      {Key? key,
      required this.workType,
      required this.architecturalType,
      required this.projectFk})
      : super(key: key);

  @override
  State<OneWorkerForm> createState() => _OneWorkerFormState();
}

class _OneWorkerFormState extends State<OneWorkerForm> {
  TextEditingController dateStartControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  RegExp regex = RegExp(r'(?!^ +$)^.+$');
  var outputFormat = DateFormat('MM/dd/yyyy');
  DateTime selectedDate = DateTime.now();
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

  List<String> finishType = [
    'OBD',
    'Emulsion',
    'Texture',
    'Enamel',
  ];

  List<String> finishType2 = [
    'Snowcem',
    'Enamel',
    'Emulsion',
  ];

  List<String> doorType = [
    'Wooden',
    'Steel',
    'Aluminum',
  ];

  List<String> windowType = [
    'Glass',
    'Louver',
    'Steel',
  ];

  List<WorkerType>? rateOfWorkers;

  // String? _selectedFinishType;
  // String? _selectedFinishType2;
  // String? _selectedDoorType;
  // String? _selectedWindowType;

  String? _selectedType;

  String? units, label, worker, surface;
  double? defaultValue;

  String? preferedTime;
  String? volume;
  TextEditingController productivityRateController = TextEditingController();

  //database
  FormData? formData;
  AdditionalManpower? manpower;
  bool isLoading = false, isUpdating = false, isExceeded = false;

  //auto populated
  int? numberOfDays, numberOfWorkers, worker_1;
  DateTime? dateEnd;
  double? costOfLabor, initialWorkers, initialNumberofDays, workerCost;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    refreshState();
    if (widget.architecturalType == 'Painting Works') {
      if (widget.workType.contains('Interior Skim Coat')) {
      } else if (widget.workType.contains('Exterior Skim Coat')) {
      } else if (widget.workType.contains('Interior')) {
        defaultValue = formData == null ? 12 : formData!.col_1_val;
      } else if (widget.workType.contains('Exterior')) {
        defaultValue = formData == null ? 20 : formData!.col_1_val;
      }
      units = 'sqm';
      label = 'Finish';
      surface = 'Area';
      worker = 'Painter';
    } else {
      if (widget.workType.contains('Jamb')) {
        label = 'Jamb';
        surface = 'Set';
        units = 'set';
      } else if (widget.workType.contains('Lockset')) {
        label = 'Door lock set';
        surface = 'Set';
        units = 'set';
      } else if (widget.workType.contains('Doors')) {
        label = 'Door';
        surface = 'Area';
        units = 'sqm';
      } else if (widget.workType.contains('Windows')) {
        label = 'Windows';
        surface = 'Area';
        units = 'sqm';
      }
      worker = 'Door Installer';
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
      }
    }
    if (formData != null) {
      dateStartControler.text = formData!.date_start == null
          ? outputFormat.format(DateTime.now())
          : outputFormat.format(DateTime.parse(formData!.date_start!));
      defaultValue = formData!.col_1_val;
      volume = formData!.col_2.toString();
      numberOfDays = formData!.num_days;
      numberOfWorkers = formData!.num_workers;
      dateEnd = formData!.date_end == null
          ? null
          : DateTime.parse(formData!.date_end!);
      worker_1 = formData!.worker_1;
      costOfLabor =
          formData!.worker_1 == null ? null : formData!.worker_1! * workerCost!;
      preferedTime = formData!.pref_time.toString();

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
      body: isLoading && formData == null
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                          flex: 5,
                          child: //date start
                              Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: TextField(
                              readOnly: true,
                              controller: dateStartControler,
                              onTap: () async {
                                _selectDate(context);
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
                                  label!.toUpperCase(),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(fontSize: 15),
                                )),
                          ),
                        ),
                        widget.workType == 'Doors'
                            ? Flexible(
                                flex: 5,
                                child: Row(
                                  children: [
                                    Flexible(flex: 5, child: doorDropdown()),
                                    Flexible(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
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
                            : widget.workType == 'Windows'
                                ? Flexible(
                                    flex: 5,
                                    child: Row(
                                      children: [
                                        Flexible(
                                            flex: 5, child: windowDropdown()),
                                        Flexible(
                                          flex: 3,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
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
                                : widget.workType.contains('Interior') &&
                                        !widget.workType.contains('Skim Coat')
                                    ? Flexible(
                                        flex: 5,
                                        child: Row(
                                          children: [
                                            Flexible(
                                                flex: 3,
                                                child: finishDropdown()),
                                            Flexible(
                                              flex: 2,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: TextFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                        helperText:
                                                            ' ', // this is new
                                                      ),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty ||
                                                            !regex.hasMatch(
                                                                value)) {
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
                                    : widget.workType.contains('Exterior') &&
                                            !widget.workType
                                                .contains('Skim Coat')
                                        ? Flexible(
                                            flex: 5,
                                            child: Row(
                                              children: [
                                                Flexible(
                                                    flex: 4,
                                                    child: finishDropdown2()),
                                                Flexible(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: TextFormField(
                                                          decoration:
                                                              const InputDecoration(
                                                            helperText:
                                                                ' ', // this is new
                                                          ),
                                                          validator: (value) {
                                                            if (value == null ||
                                                                value.isEmpty ||
                                                                !regex.hasMatch(
                                                                    value)) {
                                                              return '';
                                                            }
                                                            return null;
                                                          },
                                                          controller:
                                                              productivityRateController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Flexible(
                                            flex: 5,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: TextFormField(
                                                    controller:
                                                        productivityRateController,
                                                    keyboardType:
                                                        TextInputType.number,
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
                    Row(
                      children: [
                        Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  surface!.toUpperCase(),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(fontSize: 15),
                                )),
                          ),
                        ),
                        Flexible(
                          flex: 5,
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
                                  'PREFERRED TIME',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 15),
                                )),
                          ),
                        ),
                        Flexible(
                          flex: 5,
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
                                  'Day/s',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 15),
                                )),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
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
                                  'Number of days',
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
                                child: Text(
                                  numberOfDays != null
                                      ? numberOfDays.toString()
                                      : '',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(fontSize: 15),
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
                                  'Day/s',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 15),
                                )),
                          ),
                        )
                      ],
                    ),
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
                              child: Text(
                                dateEnd != null
                                    ? outputFormat.format(dateEnd!)
                                    : '',
                                textAlign: TextAlign.left,
                                style: const TextStyle(fontSize: 15),
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
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  numberOfWorkers != null
                                      ? numberOfWorkers!.toString()
                                      : '',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(fontSize: 15),
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
                    Row(
                      children: [
                        Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  worker!.toUpperCase(),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(fontSize: 15),
                                )),
                          ),
                        ),
                        Flexible(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  worker_1 != null ? worker_1!.toString() : '',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(fontSize: 15),
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
                    Row(
                      children: [
                        const Flexible(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Cost of Laborer',
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
                                child: Text(
                                  costOfLabor != null
                                      ? costOfLabor.toString()
                                      : '',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(fontSize: 15),
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
                                  } else {
                                    cbOne = 0;
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
                                  } else {
                                    cbTwo = 0;
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
                                  } else {
                                    cbThree = 0;
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
                                  } else {
                                    cbFour = 0;
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
                                  } else {
                                    cbFive = 0;
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
                                  } else {
                                    cbSix = 0;
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
                                  } else {
                                    cbSeven = 0;
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
                                  } else {
                                    cbEight = 0;
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
                                  } else {
                                    cbNine = 0;
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
                                  } else {
                                    cbTen = 0;
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
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Additional Manpower',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
                          child: Text(
                            'Percent %',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        /*Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 25),
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
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ), */
                      ],
                    ),
                    computeButton()
                  ],
                ),
              ),
            ),
    );
  }

  Future updateManpower() async {
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
        totalPercentage: 2);

    await DatabaseHelper.instance.updateManpower(manpower!);
  }

  paintingworksComputer() {
    if (_formKey.currentState!.validate()) {
      initialWorkers = (double.parse(volume!) /
              double.parse(productivityRateController.text))
          .roundToDouble();
      if (initialWorkers! == 1) {
        initialNumberofDays = 1;
      } else if (initialWorkers! == 2 ||
          initialWorkers! == 4 ||
          initialWorkers! == 5) {
        initialNumberofDays = 2;
      } else if (initialWorkers! == 3 || initialWorkers! == 6) {
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
      setState(() {
        if (double.parse(preferedTime!) < initialNumberofDays!) {
          initialNumberofDays = double.parse(preferedTime!);
        }
        numberOfDays = initialNumberofDays!.round();
        numberOfWorkers = (initialWorkers! / initialNumberofDays!).round();
        costOfLabor = (numberOfWorkers! * workerCost!) * numberOfDays!;
        worker_1 = numberOfWorkers;
        dateEnd = selectedDate.add(Duration(days: numberOfDays!));
        isComputed = true;
      });
    }
  }

  doorsandwindowsComputer() {
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
      setState(() {
        if (double.parse(preferedTime!) < initialNumberofDays!) {
          initialNumberofDays = double.parse(preferedTime!);
        }
        numberOfDays = initialNumberofDays!.round();
        numberOfWorkers = (initialWorkers! / initialNumberofDays!).round();
        costOfLabor = (numberOfWorkers! * workerCost!) * numberOfDays!;
        worker_1 = numberOfWorkers;
        dateEnd = selectedDate.add(Duration(days: numberOfDays!));
        isComputed = true;
      });
    }
  }

  Widget computeButton() => ElevatedButton(
      onPressed: () {
        if (widget.architecturalType.toLowerCase() == 'painting works') {
          paintingworksComputer();
        } else if (widget.architecturalType.toLowerCase() ==
            'doors and windows') {
          doorsandwindowsComputer();
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
            worker_1: numberOfWorkers!,
            work: widget.architecturalType,
            type: widget.workType,
            fk: widget.projectFk,
          );
          DatabaseHelper.instance.updateFormData(formDataCreate);
          refreshState();
        }
      },
      child: const Text('Save'));

  Widget doorDropdown() => DropdownButtonFormField(
      decoration: const InputDecoration(
        helperText: ' ', // this is new
      ),
      validator: (value) {
        if (value == null) {
          return 'Required Door Type';
        }
        return null;
      },
      hint: const Text('Door Type'), // Not necessary for Option 1
      value: _selectedType,
      onChanged: (value) {
        setState(() {
          _selectedType = value.toString();
          if (_selectedType == "Wooden") {
            defaultValue = 3.38;
            productivityRateController.text = defaultValue.toString();
          } else if (_selectedType == "Steel") {
            defaultValue = 1.05;
            productivityRateController.text = defaultValue.toString();
          } else {
            defaultValue = 0.99;
            productivityRateController.text = defaultValue.toString();
          }
        });
      },
      items: doorType.map((doorType) {
        return DropdownMenuItem(
          child: Text(doorType),
          value: doorType,
        );
      }).toList());

  Widget windowDropdown() => DropdownButtonFormField(
      decoration: const InputDecoration(
        helperText: ' ', // this is new
      ),
      validator: (value) {
        if (value == null) {
          return 'Required Window Type';
        }
        return null;
      },
      hint: const Text('Window Type'), // Not necessary for Option 1
      value: _selectedType,
      onChanged: (value) {
        setState(() {
          _selectedType = value.toString();
          if (_selectedType == "Glass") {
            defaultValue = 2.48;
            productivityRateController.text = defaultValue.toString();
          } else if (_selectedType == "Louvre") {
            defaultValue = 1.73;
            productivityRateController.text = defaultValue.toString();
          } else {
            defaultValue = 0.25;
            productivityRateController.text = defaultValue.toString();
          }
        });
      },
      items: windowType.map((windowType) {
        return DropdownMenuItem(
          child: Text(windowType),
          value: windowType,
        );
      }).toList());

  Widget finishDropdown() => DropdownButtonFormField(
      decoration: const InputDecoration(
        helperText: ' ', // this is new
      ),
      validator: (value) {
        if (value == null) {
          return 'Required Finish Type';
        }
        return null;
      },
      hint: const Text('Finish Type'), // Not necessary for Option 1
      value: _selectedType,
      onChanged: (value) {
        print(value);
        setState(() {
          _selectedType = value.toString();
          if (_selectedType == "OBD") {
            defaultValue = 12;
            productivityRateController.text = defaultValue.toString();
          } else if (_selectedType == "Emulsion") {
            defaultValue = 12;
            productivityRateController.text = defaultValue.toString();
          } else if (_selectedType == "Texture") {
            defaultValue = 10;
            productivityRateController.text = defaultValue.toString();
          } else {
            defaultValue = 8;
            productivityRateController.text = defaultValue.toString();
          }
        });
      },
      items: finishType.map((finishType) {
        return DropdownMenuItem(
          child: Text(finishType),
          value: finishType,
        );
      }).toList());

  Widget finishDropdown2() => DropdownButtonFormField(
      decoration: const InputDecoration(
        helperText: ' ', // this is new
      ),
      validator: (value) {
        if (value == null) {
          return 'Required Finish Type';
        }
        return null;
      },
      hint: const Text('Finished Type'), // Not necessary for Option 1
      value: _selectedType,
      onChanged: (value) {
        setState(() {
          _selectedType = value.toString();
          if (_selectedType == "Snowcem") {
            defaultValue = 20;
            productivityRateController.text = defaultValue.toString();
          } else if (_selectedType == "Emulsion") {
            defaultValue = 7;
            productivityRateController.text = defaultValue.toString();
          } else {
            defaultValue = 5;
            productivityRateController.text = defaultValue.toString();
          }
        });
      },
      items: finishType2.map((finishType2) {
        return DropdownMenuItem(
          child: Text(finishType2),
          value: finishType2,
        );
      }).toList());
}
