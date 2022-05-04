import 'package:engineering/screens/hamburgerMenu/openDrawer.dart';
import 'package:engineering/screens/mainProject/rateOfWorkers/rateOfWorkers.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class TwoWorkersForm extends StatefulWidget {
  String workType;
  String structuralType;
  TwoWorkersForm(
      {Key? key, required this.workType, required this.structuralType})
      : super(key: key);

  @override
  State<TwoWorkersForm> createState() => _TwoWorkersForm();
}

class _TwoWorkersForm extends State<TwoWorkersForm> {
  late String? units, label, worker, secondWorker, surface;
  late double? defaultValue;

  List<String> soilType = ['8"', '6"'];
  String? _selectedSoilType;
  final _formKey = GlobalKey<FormState>();
  RegExp regex = new RegExp(r'(?!^ +$)^.+$');
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

  String? preferredTimeController;
  String? volumeController;
  TextEditingController productivityRateController = TextEditingController();
  TextEditingController dateStartControler = TextEditingController();

  @override
  void initState() {
    if (widget.structuralType == 'Formworks') {
      if (widget.workType == 'Footings') {
        label = 'Footings';
        defaultValue = 7.7;
      } else if (widget.workType.contains('Column')) {
        label = 'Column';
        defaultValue = 4;
      } else if (widget.workType.contains('Beam')) {
        label = 'Beam';
        defaultValue = 3.3;
      } else if (widget.workType.contains('Slab')) {
        label = 'Slab';
        defaultValue = 4.3;
      } else if (widget.workType.contains('Staircase')) {
        label = 'Staircase';
        defaultValue = 3.3;
      }
      units = 'sqm';
      surface = 'Area';
      worker = 'Carpenter';
      secondWorker = 'Labourer';
    } else if (widget.structuralType == 'Masonry Works') {
      if (widget.workType.contains('Interior')) {
        surface = 'Area';
        label = 'Concrete Block';
        defaultValue = 4;
      } else if (widget.workType.contains('Exterior')) {
        surface = 'Surface Area';
        label = 'CHB Walls';
        defaultValue = 0;
      }
      units = 'sqm';
      worker = 'Tile man';
      secondWorker = 'Labourer';
    } else {
      if (widget.workType == 'Footings') {
        label = 'Footings';
        defaultValue = 1.5;
      } else if (widget.workType.contains('Column')) {
        label = 'Column';
        defaultValue = 1;
      } else if (widget.workType.contains('Beam')) {
        label = 'Beam';
        defaultValue = 1;
      } else if (widget.workType.contains('Slab')) {
        label = 'Slab';
        defaultValue = 2;
      } else if (widget.workType.contains('Staircase')) {
        label = 'Staircase';
        defaultValue = 1;
      }
      units = 'cum';
      surface = 'Volume';
      worker = 'Mason';
      secondWorker = 'Labourer';
    }
    productivityRateController.text = defaultValue.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workType),
        actions: [saveButton()],
      ),
      body: Form(
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
                          Padding(
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
                          Padding(
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
                          Padding(
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
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
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
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
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
                          Padding(
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
                          Padding(
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
                        ],
                      )),
                  //second column
                  Flexible(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                          widget.structuralType == 'Masonry Works' &&
                                  widget.workType.contains('Exterior')
                              ? Row(
                                  children: [
                                    Flexible(
                                      flex: 3,
                                      child: DropdownButtonFormField(
                                          autofocus: true,
                                          decoration: const InputDecoration(
                                            helperText: ' ', // this is new
                                          ),
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Required CHB Type';
                                            }
                                            return null;
                                          },
                                          hint: const Text(
                                              'CHB Type'), // Not necessary for Option 1
                                          value: _selectedSoilType,
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedSoilType =
                                                  value.toString();
                                              if (_selectedSoilType == "8\"") {
                                                defaultValue = 8.5;
                                                productivityRateController
                                                        .text =
                                                    defaultValue.toString();
                                              } else {
                                                defaultValue = 9;
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
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: TextFormField(
                                              autofocus: true,
                                              decoration: const InputDecoration(
                                                helperText: ' ', // this is new
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty ||
                                                    !regex.hasMatch(value)) {
                                                  return ' ';
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
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
                                            keyboardType: TextInputType.number,
                                          ))),
                                ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextFormField(
                                    initialValue: '',
                                    autofocus: true,
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

                                    // controller: projectName.text,
                                    onChanged: (value) {
                                      setState(() {
                                        volumeController = value;
                                      });
                                    },
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextFormField(
                                    initialValue: '',
                                    autofocus: true,
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

                                    // controller: projectName.text,
                                    onChanged: (value) {
                                      setState(() {
                                        preferredTimeController = value;
                                      });
                                    },
                                  ),
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
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
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
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
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
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
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '',
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
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
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
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 15),
                                    ))),
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
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
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
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      units! + 'day',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(fontSize: 15),
                                    ))),
                          ),
                          Padding(
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
                          Padding(
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
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
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
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
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
                          Padding(
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
                          Padding(
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
        if (_formKey.currentState!.validate()) {
          print(volumeController! +
              preferredTimeController! +
              selectedDate.toString() +
              productivityRateController.text);
        }
      },
      child: const Text('Save'));
}
