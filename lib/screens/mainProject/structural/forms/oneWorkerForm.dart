// ignore_for_file: file_names

import 'package:engineering/databaseHelper/DataBaseHelper.dart';
import 'package:engineering/model/formModel.dart';
import 'package:engineering/model/workerModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  RegExp regex = new RegExp(r'(?!^ +$)^.+$');
  List<String> soilType = ['Soft Soil', 'Hard Soil'];
  List<WorkerType>? rateOfWorkers;

  String? _selectedType;

  String? units, label, worker, surface;
  double? defaultValue;

  String? preferedTime;
  String? volume;
  TextEditingController productivityRateController = TextEditingController();

  //database
  FormData? formData;
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
    if (widget.structuralType == 'Earthworks') {
      if (widget.workType == 'Excavation') {
        label = 'Excavation';
        defaultValue = 0;
      } else {
        label = 'Backfilling';
        defaultValue = 4;
      }
      units = 'cum';
      surface = 'Volume';
      worker = 'Laborer';
    } else {
      if (widget.workType.contains('Column')) {
        label = 'Column';
        defaultValue = 200;
      } else if (widget.workType.contains('Slab')) {
        label = 'Slab';
        defaultValue = 175;
      } else if (widget.workType.contains('Beams')) {
        label = 'Beams';
        defaultValue = 173;
      } else if (widget.workType.contains('Walls')) {
        label = 'Walls';
        defaultValue = 200;
      } else if (widget.workType == 'Footings') {
        label = 'Footing';
        defaultValue = 190;
      } else if (widget.workType == 'Lintels') {
        label = 'Lintels';
        defaultValue = 100;
      } else if (widget.workType == 'Staircase') {
        label = 'Staircase';
        defaultValue = 173;
      } else {
        label = 'Stirrups, spacers and links';
        defaultValue = 150;
      }
      units = 'kg';
      worker = 'Steel man';
      surface = 'Weight';
    }
    productivityRateController.text = defaultValue.toString();
    refreshState();
    super.initState();
  }

  Future refreshState() async {
    setState(() => isLoading = true);
    formData = await DatabaseHelper.instance
        .readFormData(widget.projectFk, widget.structuralType, widget.workType);
    rateOfWorkers = await DatabaseHelper.instance.readWorkers(widget.projectFk);
    for (int i = 0; i < rateOfWorkers!.length; i++) {
      if (rateOfWorkers![i].workerType.toUpperCase() == worker!.toUpperCase()) {
        workerCost = rateOfWorkers![i].rate;
      }
    }
    if (formData != null) {
      dateStartControler.text = DateFormat('MM/dd/yyyy').format(DateTime.parse(formData!.date_start!));
      defaultValue = formData!.col_1_val;
      volume = formData!.col_2.toString();
      numberOfDays = formData!.num_days;
      numberOfWorkers = formData!.num_workers;
      dateEnd = DateTime.parse(formData!.date_end!);
      worker_1 = formData!.worker_1;
      costOfLabor = formData!.worker_1! * workerCost!;
      // costOfLabor = formData!.cost_of_labor;
      preferedTime = formData!.pref_time.toString();

      _selectedType = formData!.col_1;
      defaultValue = formData!.col_1_val;
      isUpdating = true;
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workType),
        actions: [saveButton()],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        //first column
                        Flexible(
                            flex: 3,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Date Start',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 15),
                                          ))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            label!,
                                            textAlign: TextAlign.left,
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            surface!,
                                            textAlign: TextAlign.left,
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Preferred Time',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 15),
                                          ))),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Number of days',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 15),
                                          ))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Date End',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 15),
                                          ))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Number of workers',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 15),
                                          ))),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            worker!.toUpperCase(),
                                            textAlign: TextAlign.left,
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Cost of Laborer',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 15),
                                          ))),
                                ),
                              ],
                            )),
                        //second column
                        Flexible(
                            flex: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //date start
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
                                //productivity rate
                                widget.workType == 'Excavation'
                                    ? Row(
                                        children: [
                                          Flexible(
                                            flex: 3,
                                            child: DropdownButtonFormField(
                                                decoration:
                                                    const InputDecoration(
                                                  helperText:
                                                      ' ', // this is new
                                                ),
                                                validator: (value) {
                                                  if (value == null) {
                                                    return 'Required Soil Type';
                                                  }
                                                  return null;
                                                },
                                                hint: const Text(
                                                    'Soil Type'), // Not necessary for Option 1
                                                value: _selectedType,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedType =
                                                        value.toString();
                                                    if (_selectedType ==
                                                        "Soft Soil") {
                                                      defaultValue = 3;
                                                      productivityRateController
                                                              .text =
                                                          defaultValue
                                                              .toString();
                                                    } else {
                                                      defaultValue = 2;
                                                      productivityRateController
                                                              .text =
                                                          defaultValue
                                                              .toString();
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
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 25, 8, 0),
                                        child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.07,
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
                                                      return 'This Field is Required';
                                                    }
                                                    return null;
                                                  },
                                                  controller:
                                                      productivityRateController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                ))),
                                      ),
                                //volume
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 10, 8, 0),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: TextFormField(
                                          initialValue: volume,
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
                                            });
                                          },
                                        ),
                                      )),
                                ),
                                //preferred time
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 15, 8, 0),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: TextFormField(
                                          initialValue: preferedTime ?? '',
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
                                const SizedBox(
                                  height: 30,
                                ),
                                //number of days
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: Text(
                                        numberOfDays != null
                                            ? numberOfDays.toString()
                                            : '',
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(fontSize: 15),
                                      )),
                                ),
                                //date end
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: Text(
                                        dateEnd != null
                                            ? outputFormat.format(dateEnd!)
                                            : '',
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(fontSize: 15),
                                      )),
                                ),
                                //number of workers
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: Text(
                                        numberOfWorkers != null
                                            ? numberOfWorkers.toString()
                                            : '',
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(fontSize: 15),
                                      )),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                //number of workers
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: Text(
                                        worker_1 != null
                                            ? worker_1.toString()
                                            : '',
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(fontSize: 15),
                                      )),
                                ),
                                //cost of labor
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: Text(
                                        costOfLabor != null
                                            ? costOfLabor.toString()
                                            : '',
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(fontSize: 15),
                                      )),
                                ),
                              ],
                            )),
                        //third column
                        Flexible(
                          flex: 2,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            //date start right
                                            '',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 15),
                                          ))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            units! + '/day',
                                            textAlign: TextAlign.left,
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            units!,
                                            textAlign: TextAlign.left,
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Day/s',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 15),
                                          ))),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Day/s',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 15),
                                          ))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            //date right side
                                            '',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 15),
                                          ))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'worker/s',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 15),
                                          ))),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'worker/s',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 15),
                                          ))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'php',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 15),
                                          ))),
                                ),
                              ]),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Widget saveButton() => ElevatedButton(
      onPressed: () {
        isExceeded = false;
        if (_formKey.currentState!.validate()) {
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
            isExceeded = true;
          }

          if (isExceeded) {
            print('Exceeded' + initialWorkers.toString());
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      title: const Text(
                          'Initial numbers of workers should not exceed 15 count.'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("OK"),
                          onPressed: () {
                            // print(projectName[index]);
                            Navigator.of(context).pop();
                          },
                        ),
                      ]);
                });
          } else {
            if (double.parse(preferedTime!) < initialNumberofDays!) {
              initialNumberofDays = double.parse(preferedTime!);
            }

            numberOfDays = initialNumberofDays!.round();
            numberOfWorkers = (initialWorkers! / initialNumberofDays!).round();
            costOfLabor = numberOfWorkers! * workerCost!;

            if (isUpdating) {
              final formDataUpdate = FormData(
                  date_start: selectedDate.toString(),
                  col_1: _selectedType ?? 'DEFAULT',
                  col_1_val: defaultValue!,
                  col_2: double.parse(volume!),
                  pref_time: int.parse(preferedTime!),
                  num_days: numberOfDays!,
                  date_end: dateEnd!.toString(),
                  num_workers: numberOfWorkers!,
                  worker_1: numberOfWorkers!,
                  // cost_of_labor: costOfLabor!,
                  type: widget.structuralType,
                  work: widget.workType,
                  fk: widget.projectFk,
                  id: formData!.id!);

              DatabaseHelper.instance.updateFormData(formDataUpdate);
            } else {
              final formDataCreate = FormData(
                date_start: selectedDate.toString(),
                col_1: _selectedType ?? 'DEFAULT',
                col_1_val: defaultValue!,
                col_2: double.parse(volume!),
                pref_time: int.parse(preferedTime!),
                num_days: numberOfDays!,
                date_end: selectedDate.add(Duration(days: numberOfDays!)).toString(),
                num_workers: numberOfWorkers!,
                worker_1: numberOfWorkers!,
                // cost_of_labor: costOfLabor!,
                type: widget.structuralType,
                work: widget.workType,
                fk: widget.projectFk,
              );

              DatabaseHelper.instance.createFormData(formDataCreate);
            }
            refreshState();
          }
        }
      },
      child: const Text('Save'));
}


  // Widget saveButton() => ElevatedButton(
  //     onPressed: () {
  //       if (_formKey.currentState!.validate()) {
  //         if (isUpdating) {
  //           final formDataUpdate = FormData(
  //               date_start: selectedDate,
  //               col_1: _selectedType ?? 'DEFAULT',
  //               col_1_val: defaultValue!,
  //               col_2: double.parse(volume!),
  //               pref_time: int.parse(preferedTime!),
  //               num_days: numberOfDays!,
  //               date_end: dateEnd!,
  //               num_workers: numberOfWorkers!,
  //               worker_1: worker_1!,
  //               cost_of_labor: costOfLabor!,
  //               type: widget.structuralType,
  //               work: widget.workType,
  //               fk: widget.projectFk,
  //               id: formData!.id!);

  //           DatabaseHelper.instance.updateFormData(formDataUpdate);
  //         } else {
  //           final formDataCreate = FormData(
  //             date_start: selectedDate,
  //             col_1: _selectedType ?? 'DEFAULT',
  //             col_1_val: defaultValue!,
  //             col_2: 80,
  //             pref_time: 82,
  //             num_days: 12,
  //             date_end: DateTime.now(),
  //             num_workers: 12,
  //             worker_1: 2,
  //             cost_of_labor: 81,
  //             type: widget.structuralType,
  //             work: widget.workType,
  //             fk: widget.projectFk,
  //           );

  //           DatabaseHelper.instance.createFormData(formDataCreate);
  //         }
  //         refreshState();
  //       }
  //     },
  //     child: const Text('Save'));

