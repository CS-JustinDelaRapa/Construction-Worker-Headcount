// ignore: file_names
import 'package:engineering/databaseHelper/DataBaseHelper.dart';
import 'package:engineering/model/formModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../model/workerModel.dart';

// ignore: must_be_immutable
class TwoWorkersForm extends StatefulWidget {
  String workType;
  String elecAndPlumbType;
  String projectType;
  int projectFk;
  TwoWorkersForm(
      {Key? key,
      required this.workType,
      required this.elecAndPlumbType,
      required this.projectType,
      required this.projectFk})
      : super(key: key);

  @override
  State<TwoWorkersForm> createState() => _TwoWorkersFormState();
}

class _TwoWorkersFormState extends State<TwoWorkersForm> {
  late String? units, label, worker, secondWorker, surface;
  late double? defaultValue;

  final _formKey = GlobalKey<FormState>();
  RegExp regex = RegExp(r'(?!^ +$)^.+$');

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
      });
    }
  }

  List<WorkerType>? rateOfWorkers;
  String? preferedTime;
  String? surfaceController;
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
  //database
  FormData? formData;
  bool isLoading = false, isUpdating = false, isComputed = false;

  //auto populated
  int? numberOfDays, numberOfWorkers, worker1, worker2;
  String? _selectedType;
  DateTime? dateEnd;
  double? costOfLabor,
      initialWorkers,
      initialNumberofDays,
      workerCost,
      workerCost2;

  @override
  void initState() {
    if (widget.elecAndPlumbType == 'Electrical Works') {
      if (widget.workType == 'Roughing Ins') {
        label = 'Conduit Pipes';
        units = 'm';
        surface = 'Length';
      } else {
        label = 'Fixtures';
        units = 'set';
        surface = 'Set';
      }
      worker = 'Electrician';
      secondWorker = 'Laborer';
    } else {
      if (widget.workType == 'Works') {
        label = 'Pipes and Fittings';
        units = 'm';
        surface = 'Length';
      } else {
        label = 'Fixtures';
        units = 'set';
        surface = 'Fixtures';
      }
      worker = 'Plumber';
      secondWorker = 'Laborer';
    }
    refreshState();
    super.initState();
  }

  Future refreshState() async {
    setState(() => isLoading = true);
    formData = await DatabaseHelper.instance.readFormData(
        widget.projectFk, widget.elecAndPlumbType, widget.workType);

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
      dateStartControler.text = formData!.date_start == null
          ? outputFormat.format(DateTime.now())
          : outputFormat.format(DateTime.parse(formData!.date_start!));
      defaultValue = formData!.col_1_val;
      surfaceController = formData!.col_2.toString();
      numberOfDays = formData!.num_days;
      numberOfWorkers = formData!.num_workers;
      dateEnd = formData!.date_end == null
          ? null
          : DateTime.parse(formData!.date_end!);
      worker1 = formData!.worker_1 == null ? null : formData!.worker_1!;
      worker2 = formData!.worker_2 == null ? null : formData!.worker_2!;
      costOfLabor = formData!.worker_1 == null
          ? null
          : (formData!.worker_1! * workerCost!) +
              (formData!.worker_2! * workerCost2!);
      preferedTime = formData!.pref_time.toString();

      _selectedType = formData!.col_1;
      defaultValue = formData!.col_1_val;
      isUpdating = true;
    }
    setState(() => isLoading = false);
    productivityRateController.text = defaultValue.toString();
  }

  @override
  Widget build(BuildContext context) {
    var sizedBox = Text(
      '10%',
      textAlign: TextAlign.left,
      style: TextStyle(fontSize: 15),
    );
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
                  physics: const ClampingScrollPhysics(),
                  child: Column(children: [
                    Row(
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Date Start',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 15),
                                    ))),
                          ),
                        ),
                        Flexible(
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
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      //date start right side
                                      '',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 15),
                                    ))),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      label!,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(fontSize: 15),
                                    ))),
                          ),
                        ),
                        Flexible(
                          child: //prod rate
                              Padding(
                            padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
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
                                      controller: productivityRateController,
                                      keyboardType: TextInputType.number,
                                    ))),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      units! + '/day',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(fontSize: 15),
                                    ))),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      surface!,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(fontSize: 15),
                                    ))),
                          ),
                        ),
                        //area
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextFormField(
                                    initialValue: surfaceController == 'null'
                                        ? ''
                                        : surfaceController,
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
                                        surfaceController = value;
                                      });
                                    },
                                  ),
                                )),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      units!,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(fontSize: 15),
                                    ))),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Preferred Time',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 15),
                                    ))),
                          ),
                        ),
                        //area
                        Flexible(
                          child: //prefered time
                              Padding(
                            padding: const EdgeInsets.fromLTRB(8, 15, 8, 0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextFormField(
                                    initialValue: preferedTime == 'null'
                                        ? ''
                                        : preferedTime,
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
                                )),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Day/s',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 15),
                                    ))),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Number of days',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 15),
                                    ))),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      numberOfDays != null
                                          ? numberOfDays.toString()
                                          : '',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(fontSize: 15),
                                    ))),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Day/s',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 15),
                                    ))),
                          ),
                        )
                      ],
                    ),
                    Row(children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Date End',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 15),
                                  ))),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    dateEnd != null
                                        ? outputFormat.format(dateEnd!)
                                        : '',
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(fontSize: 15),
                                  ))),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    //date end right side
                                    '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 15),
                                  ))),
                        ),
                      )
                    ]),
                    Row(
                      children: [
                        Flexible(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Number of workers',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 15),
                                  ))),
                        )),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      numberOfWorkers != null
                                          ? numberOfWorkers.toString()
                                          : '',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(fontSize: 15),
                                    ))),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'worker/s',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 15),
                                    ))),
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      worker!.toUpperCase(),
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(fontSize: 15),
                                    ))),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      worker2 != null ? worker1.toString() : '',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(fontSize: 15),
                                    ))),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'worker/s',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 15),
                                    ))),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      secondWorker!.toUpperCase(),
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(fontSize: 15),
                                    ))),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      worker2 != null ? worker2.toString() : '',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(fontSize: 15),
                                    ))),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'worker/s',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 15),
                                    ))),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Cost of Laborer',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 15),
                                    ))),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      costOfLabor != null
                                          ? costOfLabor.toString()
                                          : '',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(fontSize: 15),
                                    ))),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'php',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 15),
                                    ))),
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
                              style: TextStyle(fontSize: 15),
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
                              style: TextStyle(fontSize: 15),
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.22,
                            height: MediaQuery.of(context).size.height * 0.07,
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
                              },
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                child: const Text(
                                  'Struggle with authority leading to conflict between construction workers and engineers',
                                  style: TextStyle(fontSize: 12),
                                )),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(80, 8, 8, 8),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '10%',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 15),
                                    ))),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.22,
                            height: MediaQuery.of(context).size.height * 0.07,
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
                              },
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                child: const Text(
                                  'Sudden absences of construction workers without prior notice to superiors',
                                  style: TextStyle(fontSize: 12),
                                )),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(80, 8, 8, 8),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '10%',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 15),
                                    ))),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.22,
                            height: MediaQuery.of(context).size.height * 0.07,
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
                              },
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                child: const Text(
                                  'Usage of electronic devices during working hours',
                                  style: TextStyle(fontSize: 12),
                                )),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(80, 8, 8, 8),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '10%',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 15),
                                    ))),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.22,
                            height: MediaQuery.of(context).size.height * 0.07,
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
                              },
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                child: const Text(
                                  'Sudden resignation of workers due to inadequate benefits, low wages, deployment abroad, etc.',
                                  style: TextStyle(fontSize: 12),
                                )),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(80, 8, 8, 8),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '30%',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 15),
                                    ))),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.22,
                            height: MediaQuery.of(context).size.height * 0.07,
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
                              },
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                child: const Text(
                                  'Sudden Termination(Serious Injury, relocation, habitual neglect of duties, serious misconduct, fraud, loss of confidence, commission of a crime and analogous causes)',
                                  style: TextStyle(fontSize: 12),
                                )),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(80, 8, 8, 8),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '10%',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 15),
                                    ))),
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
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.22,
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: const Text(
                                'Percent %',
                                style: TextStyle(fontSize: 15),
                              )),
                        ),
                        // Flexible(
                        //   child: Padding(
                        //     padding: const EdgeInsets.fromLTRB(0, 8, 0, 25),
                        //     child: SizedBox(
                        //         width: MediaQuery.of(context).size.width * 0.5,
                        //         height:
                        //             MediaQuery.of(context).size.height * 0.07,
                        //         child: TextFormField(
                        //           decoration: const InputDecoration(
                        //             helperText: ' ', // this is new
                        //           ),
                        //           validator: (value) {
                        //             if (value == null ||
                        //                 value.isEmpty ||
                        //                 !regex.hasMatch(value)) {
                        //               return 'This Field is Required';
                        //             }
                        //             return null;
                        //           },
                        //           keyboardType: TextInputType.number,
                        //         )),
                        //   ),
                        // ),
                      ],
                    ),
                    computeButton()
                  ]),
                ),
              ));
  }

  Widget computeButton() => ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          initialWorkers = (double.parse(surfaceController!) /
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
          setState(() {
            if (double.parse(preferedTime!) < initialNumberofDays!) {
              initialNumberofDays = double.parse(preferedTime!);
            }
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
      },
      child: const Text('Compute'));

  Widget saveButton() => ElevatedButton(
      onPressed: () {
        final formDataCreate = FormData(
          id: formData!.id,
          date_start: selectedDate.toString(),
          col_1: _selectedType ?? 'DEFAULT',
          col_1_val: double.parse(productivityRateController.text),
          col_2: double.parse(surface!),
          pref_time: int.parse(preferedTime!),
          num_days: numberOfDays!,
          date_end: selectedDate.add(Duration(days: numberOfDays!)).toString(),
          num_workers: numberOfWorkers!,
          worker_1: numberOfWorkers!,
          work: widget.elecAndPlumbType,
          type: widget.workType,
          fk: widget.projectFk,
        );
        DatabaseHelper.instance.updateFormData(formDataCreate);
        refreshState();
      },
      child: const Text('Save'));
}
