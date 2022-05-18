import 'package:data_table_2/data_table_2.dart';
import 'package:engineering/screens/hamburgerMenu/openDrawer.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'data.dart';
import 'mobile.dart';

class ScrollableColumnWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
            border: TableBorder.all(
              width: 1,
            ),
            headingRowColor: MaterialStateProperty.all(Colors.green[100]),
            columnSpacing: 40,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            columns: [
              DataColumn(label: Text('Points')),
              DataColumn(label: Text('Won')),
              DataColumn(label: Text('Lost')),
              DataColumn(label: Text('Drawn')),
              DataColumn(label: Text('Against')),
              DataColumn(label: Text('GD')),
            ],
            rows: [
              ...teamsData.map((team) => DataRow(
                    cells: [
                      DataCell(Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            team.points.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))),
                      DataCell(Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(team.won.toString()))),
                      DataCell(Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(team.lost.toString()))),
                      DataCell(Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(team.drawn.toString()))),
                      DataCell(Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(team.against.toString()))),
                      DataCell(Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(team.gd.toString()))),
                    ],
                  ))
            ]),
      ),
    );
  }
}
