// ignore_for_file: file_names

import 'package:engineering/screens/hamburgerMenu/openDrawer.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';

class AdditionalManpower extends StatefulWidget {
  final VoidCallback openDrawer;

  const AdditionalManpower({Key? key, required this.openDrawer})
      : super(key: key);

  @override
  _AdditionalManpowerState createState() => _AdditionalManpowerState();
}

class _AdditionalManpowerState extends State<AdditionalManpower> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: OpenDrawerWidget(
            onClicked: widget.openDrawer,
          ),
          title: const Text('Additional Manpower'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: DataTable(
              headingRowHeight: MediaQuery.of(context).size.height * 0.20,
              dataRowHeight: MediaQuery.of(context).size.height * 0.3,
              showBottomBorder: true,
              dividerThickness: 3.0,
              horizontalMargin: 6.0,
              columnSpacing: 30.0,
              border: TableBorder.all(
                width: 1.0,
                color: Colors.black,
              ),
              columns: <DataColumn>[
                DataColumn(
                    label: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: const Text(
                    'Item No.',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                    softWrap: true,
                  ),
                )),
                const DataColumn(
                  label: Text(
                    'Labor-related Factor',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                    softWrap: true,
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: const Text(
                      'Additional\nPercentage\nto the\nManpower\nDistribution',
                      overflow: TextOverflow.visible,
                      softWrap: true,
                    ),
                  ),
                ),
              ],
              rows: const <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(Center(child: Text('1'))),
                    DataCell(Center(
                      child: Text(
                          'Shortage of construction workers due to increase in numbers of construction projects'),
                    )),
                    DataCell(Center(
                      child: Text('40%'),
                    )),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Center(child: Text('2'))),
                    DataCell(Center(
                      child: Text(
                          'Unskilled construction workers due to lack of experience and training'),
                    )),
                    DataCell(Center(
                      child: Text('10%'),
                    )),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Center(child: Text('3'))),
                    DataCell(Center(
                      child: Text(
                          'Language barrier between workers of different dialect'),
                    )),
                    DataCell(Center(child: Text('10%'))),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Center(child: Text('4'))),
                    DataCell(Center(
                      child: Text(
                          'Issues of overtime scheduling with construction workers'),
                    )),
                    DataCell(Center(child: Text('10%'))),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Center(child: Text('5'))),
                    DataCell(Center(
                      child: Text(
                          'Demand of higher salaries from construction workers'),
                    )),
                    DataCell(Center(child: Text('10%'))),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Center(child: Text('6'))),
                    DataCell(Center(
                      child: Text(
                          'Struggle with authority leading to conflict between construction workers and engineers'),
                    )),
                    DataCell(Center(child: Text('10%'))),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Center(child: Text('7'))),
                    DataCell(Center(
                      child: Text(
                          'Sudden absences of construction workers without prior notice to superiors'),
                    )),
                    DataCell(Center(child: Text('10%'))),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Center(child: Text('8'))),
                    DataCell(Center(
                      child: Text(
                          'Usage of electronic devices during working hours'),
                    )),
                    DataCell(Center(child: Text('10%'))),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Center(child: Text('9'))),
                    DataCell(Center(
                      child: Text(
                          'Sudden resignation of workers due to inadequate benefits, low wages, deployment abroad, etc.'),
                    )),
                    DataCell(Center(child: Text('30%'))),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Center(child: Text('10'))),
                    DataCell(Center(
                      child: Text(
                        'Sudden Termination(Serious Injury, relocation, habitual neglect of duties, serious misconduct, fraud, loss of confidence, commission of a crime and analogous causes)',
                        overflow: TextOverflow.visible,
                        softWrap: true,
                      ),
                    )),
                    DataCell(Center(child: Text('10%'))),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
