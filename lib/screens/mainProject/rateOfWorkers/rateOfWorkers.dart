// ignore_for_file: file_names
import 'package:engineering/databaseHelper/DataBaseHelper.dart';
import 'package:engineering/model/workerModel.dart';
import 'package:engineering/screens/hamburgerMenu/openDrawer.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';

class RateOfWorkers extends StatefulWidget {
  final VoidCallback openDrawer;
  final int projectFk;

  const RateOfWorkers(
      {Key? key, required this.openDrawer, required this.projectFk})
      : super(key: key);

  @override
  _RateOfWorkersState createState() => _RateOfWorkersState();
}

List<TextEditingController> myController = [
  for (int i = 0; i <= 11; i++) TextEditingController()
];

class _RateOfWorkersState extends State<RateOfWorkers> {
  bool isLoading = false;

  late List<WorkerType> workers;

  @override
  void initState() {
    // TODO: implement initState
    refreshState();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  RegExp regex = new RegExp(r'(?!^ +$)^.+$');
  var rate = [];
  Future refreshState() async {
    setState(() => isLoading = true);
    workers = await DatabaseHelper.instance.readWorkers(widget.projectFk);
    for (int i = 0; i < workers.length; i++) {
      rate.add(workers[i].rate.toString());
    }
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
        title: const Text('Rate of Workers'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Labels
                          Flexible(
                            flex: 1,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.090,
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            workers[0].workerType,
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
                                              0.090,
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            workers[1].workerType,
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
                                              0.090,
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            workers[2].workerType,
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
                                              0.090,
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            workers[3].workerType,
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
                                              0.090,
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            workers[4].workerType,
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
                                              0.090,
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            workers[5].workerType,
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
                                              0.090,
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            workers[6].workerType,
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
                                              0.090,
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            workers[7].workerType,
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
                                              0.090,
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            workers[8].workerType,
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
                                              0.090,
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            workers[9].workerType,
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
                                              0.090,
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            workers[10].workerType,
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
                                              0.090,
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            workers[11].workerType,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 15),
                                          ))),
                                ),
                              ],
                            ),
                          ),
                          //textfield
                          Flexible(
                            flex: 2,
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 20, 8, 8),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: MediaQuery.of(context).size.height *
                                        0.090,
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        helperText: ' ',
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 0),
                                        ), // this is new
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            !regex.hasMatch(value)) {
                                          return '';
                                        }
                                        return null;
                                      },
                                      initialValue:
                                          workers[0].rate.toStringAsFixed(2),
                                      onChanged: (value) {
                                        rate[0] = value;
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: MediaQuery.of(context).size.height *
                                        0.090,
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        helperText: ' ',
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 0),
                                        ), // this is new
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            !regex.hasMatch(value)) {
                                          return '';
                                        }
                                        return null;
                                      },
                                      initialValue:
                                          workers[1].rate.toStringAsFixed(2),
                                      onChanged: (value) {
                                        rate[1] = value;
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: MediaQuery.of(context).size.height *
                                        0.090,
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        helperText: ' ',
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 0),
                                        ), // this is new
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            !regex.hasMatch(value)) {
                                          return '';
                                        }
                                        return null;
                                      },
                                      initialValue:
                                          workers[2].rate.toStringAsFixed(2),
                                      onChanged: (value) {
                                        rate[2] = value;
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: MediaQuery.of(context).size.height *
                                        0.090,
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        helperText: ' ',
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 0),
                                        ), // this is new
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            !regex.hasMatch(value)) {
                                          return '';
                                        }
                                        return null;
                                      },
                                      initialValue:
                                          workers[3].rate.toStringAsFixed(2),
                                      onChanged: (value) {
                                        rate[3] = value;
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: MediaQuery.of(context).size.height *
                                        0.090,
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        helperText: ' ',
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 0),
                                        ), // this is new
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            !regex.hasMatch(value)) {
                                          return '';
                                        }
                                        return null;
                                      },
                                      initialValue:
                                          workers[4].rate.toStringAsFixed(2),
                                      onChanged: (value) {
                                        rate[4] = value;
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: MediaQuery.of(context).size.height *
                                        0.090,
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        helperText: ' ',
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 0),
                                        ), // this is new
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            !regex.hasMatch(value)) {
                                          return '';
                                        }
                                        return null;
                                      },
                                      initialValue:
                                          workers[5].rate.toStringAsFixed(2),
                                      onChanged: (value) {
                                        rate[5] = value;
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: MediaQuery.of(context).size.height *
                                        0.090,
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        helperText: ' ',
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 0),
                                        ), // this is new
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            !regex.hasMatch(value)) {
                                          return '';
                                        }
                                        return null;
                                      },
                                      initialValue:
                                          workers[6].rate.toStringAsFixed(2),
                                      onChanged: (value) {
                                        rate[6] = value;
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: MediaQuery.of(context).size.height *
                                        0.090,
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        helperText: ' ',
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 0),
                                        ), // this is new
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            !regex.hasMatch(value)) {
                                          return '';
                                        }
                                        return null;
                                      },
                                      initialValue:
                                          workers[7].rate.toStringAsFixed(2),
                                      onChanged: (value) {
                                        rate[7] = value;
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: MediaQuery.of(context).size.height *
                                        0.090,
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        helperText: ' ',
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 0),
                                        ), // this is new
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            !regex.hasMatch(value)) {
                                          return '';
                                        }
                                        return null;
                                      },
                                      initialValue:
                                          workers[8].rate.toStringAsFixed(2),
                                      onChanged: (value) {
                                        rate[8] = value;
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: MediaQuery.of(context).size.height *
                                        0.090,
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        helperText: ' ',
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 0),
                                        ), // this is new
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            !regex.hasMatch(value)) {
                                          return '';
                                        }
                                        return null;
                                      },
                                      initialValue:
                                          workers[9].rate.toStringAsFixed(2),
                                      onChanged: (value) {
                                        rate[9] = value;
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: MediaQuery.of(context).size.height *
                                        0.090,
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        helperText: ' ',
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 0),
                                        ), // this is new
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            !regex.hasMatch(value)) {
                                          return '';
                                        }
                                        return null;
                                      },
                                      initialValue:
                                          workers[10].rate.toStringAsFixed(2),
                                      onChanged: (value) {
                                        rate[10] = value;
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: MediaQuery.of(context).size.height *
                                        0.090,
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        helperText: ' ',
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 0),
                                        ), // this is new
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            !regex.hasMatch(value)) {
                                          return '';
                                        }
                                        return null;
                                      },
                                      initialValue:
                                          workers[11].rate.toStringAsFixed(2),
                                      onChanged: (value) {
                                        rate[11] = value;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  for (int i = 0; i < workers.length; i++) {
                                    await DatabaseHelper.instance.updateWorker(
                                        WorkerType(
                                            id: workers[i].id,
                                            workerType: workers[i].workerType,
                                            rate: double.parse(rate[i]),
                                            fk: workers[i].fk));
                                    refreshState();
                                  }
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text('Save'),
                                  SizedBox(
                                    width: 15,
                                  ),
                                ],
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  saveRateofWorkers() {
    for (int i = 0; i <= 11; i++) {
      print(myController[i].text);
    }
  }
}
