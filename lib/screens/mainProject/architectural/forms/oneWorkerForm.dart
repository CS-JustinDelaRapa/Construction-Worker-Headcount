// ignore_for_file: file_names

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
    setState(() => isLoading = false);
    productivityRateController.text = defaultValue.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workType),
        actions: [saveButton()],
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
                        // first column
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
                                            'DATE START',
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
                                            label!.toUpperCase(),
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
                                            surface!.toUpperCase(),
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
                                            'PREFERRED TIME',
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                widget.workType == 'Doors'
                                    ? Row(
                                        children: [
                                          Flexible(
                                              flex: 3, child: doorDropdown()),
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
                                    : widget.workType == 'Windows'
                                        ? Row(
                                            children: [
                                              Flexible(
                                                  flex: 3,
                                                  child: windowDropdown()),
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
                                                            TextInputType
                                                                .number,
                                                      )),
                                                ),
                                              ),
                                            ],
                                          )
                                        : widget.workType
                                                    .contains('Interior') &&
                                                !widget.workType
                                                    .contains('Skim Coat')
                                            ? Row(
                                                children: [
                                                  Flexible(
                                                      flex: 3,
                                                      child: finishDropdown()),
                                                  Flexible(
                                                    flex: 1,
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
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty ||
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
                                              )
                                            : widget.workType
                                                        .contains('Exterior') &&
                                                    !widget.workType
                                                        .contains('Skim Coat')
                                                ? Row(
                                                    children: [
                                                      Flexible(
                                                          flex: 3,
                                                          child:
                                                              finishDropdown2()),
                                                      Flexible(
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child:
                                                                  TextFormField(
                                                                decoration:
                                                                    const InputDecoration(
                                                                  helperText:
                                                                      ' ', // this is new
                                                                ),
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                          null ||
                                                                      value
                                                                          .isEmpty ||
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
                                                  )
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.07,
                                                        child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  productivityRateController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                            ))),
                                                  ),
                                //area
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 5, 8, 0),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: TextFormField(
                                          initialValue:
                                              volume == 'null' ? '' : volume,
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
                                      )),
                                ),
                                //preffered time
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 16, 8, 0),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
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
                                            ? numberOfDays!.toString()
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
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            numberOfWorkers != null
                                                ? numberOfWorkers!.toString()
                                                : '',
                                            textAlign: TextAlign.left,
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ))),
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
                                        style: TextStyle(fontSize: 15),
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
                                        style: TextStyle(fontSize: 15),
                                      )),
                                ),
                              ],
                            )),
                        // third column
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
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      title: const Text(
                          'Initial numbers of workers should not exceed 15 count.'),
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
            if (double.parse(preferedTime!) < initialNumberofDays!) {
              initialNumberofDays = double.parse(preferedTime!);
            }

            numberOfDays = initialNumberofDays!.round();
            numberOfWorkers = (initialWorkers! / initialNumberofDays!).round();
            costOfLabor = numberOfWorkers! * workerCost!;

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
              // cost_of_labor: costOfLabor!,
              work: widget.architecturalType,
              type: widget.workType,
              fk: widget.projectFk,
            );

            DatabaseHelper.instance.updateFormData(formDataCreate);
            refreshState();
          }
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
