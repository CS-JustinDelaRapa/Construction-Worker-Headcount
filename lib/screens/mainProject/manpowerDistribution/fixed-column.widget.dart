import 'package:data_table_2/data_table_2.dart';
import 'package:engineering/screens/hamburgerMenu/openDrawer.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'data.dart';
import 'mobile.dart';

class FixedColumnWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 10,
      headingRowColor: MaterialStateProperty.all(Colors.green[300]),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.grey,
            width: 2,
          ),
        ),
      ),
      columns: [
        DataColumn(label: Text('Team')),
      ],
      rows: [
        ...teamsData.map((team) => DataRow(
              cells: [
                DataCell(Text(
                  '${team.position.toString()}  ${team.name}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
              ],
            ))
      ],
    );
  }
}
