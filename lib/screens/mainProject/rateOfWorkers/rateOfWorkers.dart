// ignore_for_file: file_names
import 'package:engineering/databaseHelper/DataBaseHelper.dart';
import 'package:engineering/model/workerModel.dart';
import 'package:engineering/screens/hamburgerMenu/openDrawer.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';

class RateOfWorkers extends StatefulWidget {
  final VoidCallback openDrawer;
  final int projectFk;

  const RateOfWorkers({Key? key, required this.openDrawer, required this.projectFk }) : super(key: key);

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

    Future refreshState() async {
    setState(() => isLoading = true);
    workers = await DatabaseHelper.instance.readWorkers(widget.projectFk);
    print(workers[0].workerType);
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
      body: isLoading? const Center(child: CircularProgressIndicator()): 
      SingleChildScrollView(
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
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.height * 0.07,
                            child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Carpenter',
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
                                  'Laborer',
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
                                  'Mason',
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
                                  'Steel Man',
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
                                  'Painter',
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
                                  'Tile Man',
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
                                  'Door and Window Installer',
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
                                  'Electrician',
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
                                  'Plumber',
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
                                  'Welder',
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
                                  'Tinsmith',
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
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: CustomWidgets().textFormField_widget(
                              '', Colors.white, 0, myController[0]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: CustomWidgets().textFormField_widget(
                              '', Colors.white, 0, myController[1]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: CustomWidgets().textFormField_widget(
                              '', Colors.white, 0, myController[2]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: CustomWidgets().textFormField_widget(
                              '', Colors.white, 0, myController[3]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: CustomWidgets().textFormField_widget(
                              '', Colors.white, 0, myController[4]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: CustomWidgets().textFormField_widget(
                              '', Colors.white, 0, myController[5]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: CustomWidgets().textFormField_widget(
                              '', Colors.white, 0, myController[6]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: CustomWidgets().textFormField_widget(
                              '', Colors.white, 0, myController[7]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: CustomWidgets().textFormField_widget(
                              '', Colors.white, 0, myController[8]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: CustomWidgets().textFormField_widget(
                              '', Colors.white, 0, myController[9]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: CustomWidgets().textFormField_widget(
                              '', Colors.white, 0, myController[10]),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            CustomWidgets().funtion_Button('Save', const Icon(Icons.menu_open),
                0.6, 0.07, context, saveRateofWorkers),
            const SizedBox(height: 30),
          ],
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
