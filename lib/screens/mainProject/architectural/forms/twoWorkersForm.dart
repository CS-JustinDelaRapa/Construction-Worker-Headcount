import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class TwoWorkersForm extends StatefulWidget {
  String workType;
  String architecturalType;
  TwoWorkersForm(
      {Key? key, required this.workType, required this.architecturalType})
      : super(key: key);

  @override
  State<TwoWorkersForm> createState() => _TwoWorkersForm();
}

class _TwoWorkersForm extends State<TwoWorkersForm> {
  late String? units, label, worker, secondWorker, surface;
  late double? defaultValue;
  final _formKey = GlobalKey<FormState>();
  RegExp regex = new RegExp(r'(?!^ +$)^.+$');
  List<String> extTileType = [
    'Mosaic Tile',
    'Ceramic Tile',
    'Vitrified Tile',
    'Granite Tile',
    'Marble Tile',
    'Glazed Tile',
  ];
  String? _selectedExtTileType;

  List<String> tileType = [
    'Mosaic Tile',
    'Ceramic Tile',
    'Marble Tile',
  ];
  String? _selectedTileType;

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
    print(widget.workType);
    if (widget.architecturalType == 'Flooring') {
      if (widget.workType.contains('EXT')) {
        label = 'EXT T&B';
        defaultValue = 0;
      } else {
        label = 'T&B';
        defaultValue = 0;
      }
      units = 'sqm';
      surface = 'Area';
      worker = 'Tile man';
      secondWorker = 'Labourer';
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
      secondWorker = 'Labourer';
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
      secondWorker = 'Labourer';
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
                          widget.workType.contains('EXT T&B') &&
                                  widget.architecturalType == 'Flooring'
                              ? Row(
                                  children: [
                                    Flexible(flex: 3, child: extDropdown()),
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
                              : widget.workType.contains('T&B') &&
                                      widget.architecturalType == 'Flooring'
                                  ? Row(
                                      children: [
                                        Flexible(flex: 3, child: intDropdown()),
                                        Flexible(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: TextFormField(
                                                  autofocus: true,
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
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
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
                                                autofocus: true,
                                                decoration:
                                                    const InputDecoration(
                                                  helperText:
                                                      ' ', // this is new
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
                                      units! + '/day',
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
              "\n" +
              preferredTimeController! +
              "\n" +
              selectedDate.toString() +
              "\n" +
              productivityRateController.text);
        }
      },
      child: const Text('Save'));

  Widget extDropdown() => DropdownButtonFormField(
      autofocus: true,
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
      value: _selectedExtTileType,
      onChanged: (value) {
        setState(() {
          _selectedExtTileType = value.toString();
          if (_selectedExtTileType == "Mosaic Tile") {
            defaultValue = 7;
            productivityRateController.text = defaultValue.toString();
          } else if (_selectedExtTileType == "Ceramic Tile") {
            defaultValue = 7;
            productivityRateController.text = defaultValue.toString();
          } else if (_selectedExtTileType == "Vitrified Tile") {
            defaultValue = 10;
            productivityRateController.text = defaultValue.toString();
          } else if (_selectedExtTileType == "Granite Tile") {
            defaultValue = 5;
            productivityRateController.text = defaultValue.toString();
          } else if (_selectedExtTileType == "Marble Tile") {
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
      autofocus: true,
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
      value: _selectedTileType,
      onChanged: (value) {
        setState(() {
          _selectedTileType = value.toString();
          if (_selectedTileType == "Mosaic Tile") {
            defaultValue = 7;
            productivityRateController.text = defaultValue.toString();
          } else if (_selectedTileType == "Ceramic Tile") {
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
}
