import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OneWorkerForm extends StatefulWidget {
  String workType;
  String architecturalType;
  OneWorkerForm(
      {Key? key, required this.workType, required this.architecturalType})
      : super(key: key);

  @override
  State<OneWorkerForm> createState() => _OneWorkerFormState();
}

class _OneWorkerFormState extends State<OneWorkerForm> {
  TextEditingController dateStartControler = TextEditingController();

  var outputFormat = DateFormat('MM/dd/yyyy');
  DateTime selectedDate = DateTime.now();

  List<String> finishType = [
    'OBD',
    'Emulsion',
    'Texture',
    'Enamel',
  ];
  String? _selectedFinishType;

  List<String> finishType2 = [
    'Snowcem',
    'Enamel',
    'Emulsion',
  ];
  String? _selectedFinishType2;

  List<String> doorType = [
    'Wooden',
    'Steel',
    'Aluminum',
  ];
  String? _selectedDoorType;

  List<String> windowType = [
    'Glass',
    'Louver',
    'Steel',
  ];
  String? _selectedWindowType;

  late String? units, label, worker, surface;
  double? defaultValue;

  TextEditingController preferredTimeController = TextEditingController();
  TextEditingController volumeController = TextEditingController();
  TextEditingController productivityRateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    if (widget.architecturalType == 'Painting Works') {
      if (widget.workType.contains('Interior Skim Coat')) {
        defaultValue = 6.4;
      } else if (widget.workType.contains('Exterior Skim Coat')) {
        defaultValue = 0; //no productivity rate for now
      } else if (widget.workType.contains('Interior')) {
        defaultValue = 0;
      } else if (widget.workType.contains('Exterior')) {
        defaultValue = 0;
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
        defaultValue = 3.52;
      } else if (widget.workType.contains('Lockset')) {
        label = 'Door lock set';
        surface = 'Set';
        units = 'set';
        defaultValue = 10.24;
      } else if (widget.workType.contains('Doors')) {
        label = 'Door';
        surface = 'Area';
        units = 'sqm';
        defaultValue = 0;
      } else if (widget.workType.contains('Windows')) {
        label = 'Windows';
        surface = 'Area';
        units = 'sqm';
        defaultValue = 0;
      }
      defaultValue = 0;
      worker = 'Door Installer';
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
      body: SingleChildScrollView(
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
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.height * 0.07,
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
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    label!.toUpperCase(),
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(fontSize: 15),
                                  ))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    surface!.toUpperCase(),
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(fontSize: 15),
                                  ))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'PREFFERED TIME',
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
                              height: MediaQuery.of(context).size.height * 0.07,
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
                              height: MediaQuery.of(context).size.height * 0.07,
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
                              height: MediaQuery.of(context).size.height * 0.07,
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
                              height: MediaQuery.of(context).size.height * 0.07,
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
                              height: MediaQuery.of(context).size.height * 0.07,
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
                        widget.workType == 'Doors'
                            ? Row(
                                children: [
                                  Flexible(flex: 3, child: doorDropdown()),
                                  Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextFormField(
                                            controller:
                                                productivityRateController,
                                            keyboardType: TextInputType.number,
                                          )),
                                    ),
                                  ),
                                ],
                              )
                            : widget.workType == 'Windows'
                                ? Row(
                                    children: [
                                      Flexible(
                                          flex: 3, child: windowDropdown()),
                                      Flexible(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: TextFormField(
                                                controller:
                                                    productivityRateController,
                                                keyboardType:
                                                    TextInputType.number,
                                              )),
                                        ),
                                      ),
                                    ],
                                  )
                                : !widget.workType.contains('Skim Coat') &&
                                        widget.workType.contains('Interior')
                                    ? Row(
                                        children: [
                                          Flexible(
                                              flex: 3, child: finishDropdown()),
                                          Flexible(
                                            flex: 1,
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
                                        ],
                                      )
                                    : !widget.workType.contains('Skim Coat') &&
                                            widget.workType.contains('Exterior')
                                        ? Row(
                                            children: [
                                              Flexible(
                                                  flex: 3,
                                                  child: finishDropdown2()),
                                              Flexible(
                                                flex: 1,
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
                                                            TextInputType
                                                                .number,
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
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: TextFormField(
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
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: CustomWidgets().textFormField_widget(
                                      '', Colors.white, 0, volumeController))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: CustomWidgets().textFormField_widget(
                                      '',
                                      Colors.white,
                                      0,
                                      preferredTimeController))),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.height * 0.07,
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
                              height: MediaQuery.of(context).size.height * 0.07,
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
                              height: MediaQuery.of(context).size.height * 0.07,
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
                              height: MediaQuery.of(context).size.height * 0.07,
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
                              height: MediaQuery.of(context).size.height * 0.07,
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
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.height * 0.07,
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
                              height: MediaQuery.of(context).size.height * 0.07,
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
                              height: MediaQuery.of(context).size.height * 0.07,
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
                              height: MediaQuery.of(context).size.height * 0.07,
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
                              height: MediaQuery.of(context).size.height * 0.07,
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
                              height: MediaQuery.of(context).size.height * 0.07,
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
                              height: MediaQuery.of(context).size.height * 0.07,
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
                              height: MediaQuery.of(context).size.height * 0.07,
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
                              height: MediaQuery.of(context).size.height * 0.07,
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
    );
  }

  Widget saveButton() => ElevatedButton(
      onPressed: () {
        print(volumeController.text +
            preferredTimeController.text +
            selectedDate.toString() +
            productivityRateController.text);
      },
      child: const Text('Save'));

  Widget doorDropdown() => DropdownButton(
      hint: const Text('Door Type'), // Not necessary for Option 1
      value: _selectedDoorType,
      onChanged: (value) {
        setState(() {
          _selectedDoorType = value.toString();
          if (_selectedDoorType == "Wooden") {
            defaultValue = 3.38;
            productivityRateController.text = defaultValue.toString();
          } else if (_selectedDoorType == "Steel") {
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

  Widget windowDropdown() => DropdownButton(
      hint: const Text('Window Type'), // Not necessary for Option 1
      value: _selectedWindowType,
      onChanged: (value) {
        setState(() {
          _selectedWindowType = value.toString();
          if (_selectedWindowType == "Glass") {
            defaultValue = 2.48;
            productivityRateController.text = defaultValue.toString();
          } else if (_selectedWindowType == "Louvre") {
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

  Widget finishDropdown() => DropdownButton(
      hint: const Text('Finish Type'), // Not necessary for Option 1
      value: _selectedFinishType,
      onChanged: (value) {
        setState(() {
          _selectedFinishType = value.toString();
          if (_selectedFinishType == "OBD") {
            defaultValue = 12;
            productivityRateController.text = defaultValue.toString();
          } else if (_selectedFinishType == "Emulsion") {
            defaultValue = 12;
            productivityRateController.text = defaultValue.toString();
          } else if (_selectedFinishType == "Texture") {
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

  Widget finishDropdown2() => DropdownButton(
      hint: const Text('Finished Type'), // Not necessary for Option 1
      value: _selectedFinishType2,
      onChanged: (value) {
        setState(() {
          _selectedFinishType2 = value.toString();
          if (_selectedFinishType2 == "Snowcem") {
            defaultValue = 20;
            productivityRateController.text = defaultValue.toString();
          } else if (_selectedFinishType2 == "Emulsion") {
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
