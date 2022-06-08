import 'package:engineering/databaseHelper/DataBaseHelper.dart';
import 'package:engineering/model/formModel.dart';
import 'package:engineering/screens/hamburgerMenu/openDrawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../../../model/ProjectModel.dart';
import 'mobile.dart';

class DateScchedule extends StatefulWidget {
  final VoidCallback openDrawer;
  final int fk;
  const DateScchedule({required this.openDrawer, required this.fk, Key? key})
      : super(key: key);

  @override
  State<DateScchedule> createState() => _DateSccheduleState();
}

class _DateSccheduleState extends State<DateScchedule> {
  List<FormData>? allForms;
  List<FormData>? formData;
  ProjectItem? itemProject;
  bool isLoading = false;

  @override
  void initState() {
    refreshState();
    super.initState();
  }

  Future refreshState() async {
    setState(() {
      isLoading = true;
    });
    allForms = await DatabaseHelper.instance.readAllFormData(widget.fk);
    formData = await DatabaseHelper.instance.readForm(widget.fk);
    itemProject = await DatabaseHelper.instance.readProject(widget.fk);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [printpdfButton(itemProject, allForms, formData)],
          leading: OpenDrawerWidget(
            onClicked: widget.openDrawer,
          ),
          title: const Text('Date Schedule'),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SfCalendar(
                view: CalendarView.month,
                dataSource: MeetingDataSource(_getDataSource()),
                onTap: (CalendarTapDetails details) {
                  // List<Meeting> appointments = details.appointments as List<Meeting>;
                  // print(appointments[0].eventName);
                  DateTime date = details.date!;
                  CalendarElement element = details.targetElement;
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text(
                                DateFormat('MM/dd/yyyy').format(details.date!)),
                            content: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.4,
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: ListView.builder(
                                  shrinkWrap: false,
                                  itemCount: details.appointments!.length,
                                  itemBuilder: (context, index) {
                                    Meeting meeting =
                                        details.appointments![index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        decoration: BoxDecoration(
                                            color: meeting.background,
                                            border: Border.all(
                                              color: meeting.background,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                        child: ListTile(
                                            title: Text(meeting.eventName, style: const TextStyle(color: Colors.white,))),
                                      ),
                                    );
                                  }),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text("Done"),
                                onPressed: () {
                                  // print(projectName[index]);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ]);
                      });
                },
                monthViewSettings: const MonthViewSettings(
                    appointmentDisplayMode:
                        MonthAppointmentDisplayMode.appointment,
                        showTrailingAndLeadingDates: false ),
              ));
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];

    setState(() {
      isLoading = true;
    });
         for(int x = 0; x < allForms!.length; x++){
      if(allForms![x].num_days != null){
        final DateTime today = DateTime.parse(allForms![x].date_start!);
        final DateTime startTime = DateTime(today.year, today.month, today.day);
        Color color = getColor(allForms![x].work);
        bool isPassedSaturday = false;  
        int counter =  allForms![x].num_days!;
        int additional = 0;
        for(int y = 0; y < counter; y++){
          final DateTime endTime = startTime.add(Duration(days: y));          

          if(endTime.weekday == DateTime.sunday){
            if(!isPassedSaturday){
              meetings.add(Meeting(allForms![x].type, startTime, endTime.subtract(const Duration(days: 1)), color, false));
              counter = counter+2;
              isPassedSaturday = true;
            }
          }else if(endTime.weekday == DateTime.monday){
            if(((allForms![x].num_days!+2) - y) > 4 ){
              meetings.add(Meeting(allForms![x].type, endTime, endTime.add(const Duration(days:5)), color, false));
              counter = counter+1;
              additional = additional+1;
            }else{
              if(startTime.add(Duration(days:(allForms![x].num_days!+additional))).weekday == DateTime.sunday
              ){
                meetings.add(Meeting(allForms![x].type, endTime, startTime.add(Duration(days:((allForms![x].num_days!+additional)-2))), color, false));
                counter = counter+1;
                additional = additional+1;                
              }              
              else{
                meetings.add(Meeting(allForms![x].type, endTime, startTime.add(Duration(days:(allForms![x].num_days!+additional))), color, false));
              }
            }
          }
          else if(y == allForms![x].num_days!-1 && !isPassedSaturday){
            if(
              startTime.add(Duration(days:allForms![x].num_days!)).weekday != DateTime.sunday
            ){
            meetings.add(Meeting(allForms![x].type, startTime, endTime, color, false));            
            }
          }
        }
      }
    }
    setState(() {
      isLoading = false;
    });
    return meetings;
  }

  Color getColor(String type) {
    Color? color;
    switch (type) {
      case 'Earthworks':
        color = const Color(0xffC16B57);
        break;
      case 'Formworks':
        color = const Color(0xff48398B);
        break;  
      case 'Masonry Works':
        color = const Color(0xff1FA263);
        break;  
      case 'Reinforced Cement Works':
        color = const Color(0xff973332);
        break; 
      case 'Steel Reinforcement Works':
        color = const Color(0xff2BB8B3);
        break;  
      case 'Flooring':
        color = const Color(0xffFB6B90);
        break; 
      case 'Plastering':
        color = const Color(0xffFF8370);
        break;  
      case 'Painting Works':
        color = const Color(0xff00B1B0);
        break; 
      case 'Doors and Windows':
        color = const Color(0xffD18D96);
        break;  
      case 'Ceiling':
        color = const Color(0xffE151AF);
        break; 
      case 'Roofing Works':
        color = const Color(0xffE42256);
        break;  
      case 'Electrical Works':
        color = const Color(0xffffa07a);
        break; 
      case 'Plumbing Works':
        color = const Color(0xffBED7D8);
        break;                                                                
       default:
        color = const Color(0xff6E3562);
        break;
    }

    return color;
  }
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}

Future<void> _createPDF(ProjectItem itemProject, List<FormData> allForms,
    List<FormData> formData) async {
  var outputFormat = DateFormat('MM/dd/yyyy');
  final durations = daysBetween(itemProject.date_start, itemProject.date_end);

  //Creates a new PDF document
  PdfDocument document = PdfDocument();

//Adds page settings
  document.pageSettings.orientation = PdfPageOrientation.landscape;
  document.pageSettings.margins.all = 50;

//Adds a page to the document
  PdfPage page = document.pages.add();
  PdfGraphics graphics = page.graphics;

  PdfBrush solidBrush = PdfSolidBrush(PdfColor(126, 151, 173));
  Rect bounds = Rect.fromLTWH(0, 0, graphics.clientSize.width, 30);

//Draws a rectangle to place the heading in that region
  graphics.drawRectangle(brush: solidBrush, bounds: bounds);

//Creates a font for adding the heading in the page
  PdfFont subHeadingFont = PdfStandardFont(PdfFontFamily.timesRoman, 14);

//Creates a text element to add the invoice number
  PdfTextElement element =
      PdfTextElement(text: 'Construction Schedule', font: subHeadingFont);
  element.brush = PdfBrushes.white;

//Draws the heading on the page
  PdfLayoutResult result = element.draw(
      page: page, bounds: Rect.fromLTWH(300, bounds.top + 8, 0, 0))!;

//Creates text elements to add the address and draw it to the page
  element = PdfTextElement(
      text: 'Project Name: ' +
          itemProject.project_name +
          ' \tStart Date: ' +
          outputFormat.format(itemProject.date_start).toString() +
          ' \tTotal Duration: ' +
          durations.toString() +
          ' Days',
      font: PdfStandardFont(PdfFontFamily.timesRoman, 14,
          style: PdfFontStyle.bold));
  element.brush = PdfBrushes.black;
  result = element.draw(
      page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 25, 0, 0))!;

  PdfFont timesRoman = PdfStandardFont(PdfFontFamily.timesRoman, 14);

  element = PdfTextElement(
      text: 'Project Manager: ' +
          itemProject.project_manager +
          ' \tEnd Date: ' +
          outputFormat.format(itemProject.date_end).toString() +
          '',
      font: PdfStandardFont(PdfFontFamily.timesRoman, 14,
          style: PdfFontStyle.bold));
  element.brush = PdfBrushes.black;
  result = element.draw(
      page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 25, 0, 0))!;

  graphics.drawLine(
      PdfPen(PdfColor(126, 151, 173), width: 0.7),
      Offset(0, result.bounds.bottom + 3),
      Offset(graphics.clientSize.width, result.bounds.bottom + 3));

  //Creates a PDF grid
  PdfGrid grid = PdfGrid();

//Add the columns to the grid
  grid.columns.add(count: 5);

//Add header to the grid
  grid.headers.add(1);

  PdfGridRow header = grid.headers[0];
  header.cells[0].value = 'Task Descriptions';
  header.cells[1].value = 'Status';
  header.cells[2].value = 'Starting Date';
  header.cells[3].value = 'End Date';
  header.cells[4].value = 'Duration';

  //Creates the header style
  PdfGridCellStyle headerStyle = PdfGridCellStyle();
  headerStyle.borders.all = PdfPen(PdfColor(126, 151, 173));
  headerStyle.backgroundBrush = PdfSolidBrush(PdfColor(126, 151, 173));
  headerStyle.textBrush = PdfBrushes.white;
  headerStyle.font = PdfStandardFont(PdfFontFamily.timesRoman, 14,
      style: PdfFontStyle.regular);

//Adds cell customizations
  for (int i = 0; i < header.cells.count; i++) {
    if (i == 0 || i == 1) {
      header.cells[i].stringFormat = PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle);
    } else {
      header.cells[i].stringFormat = PdfStringFormat(
          alignment: PdfTextAlignment.right,
          lineAlignment: PdfVerticalAlignment.middle);
    }
    header.cells[i].style = headerStyle;
  }

  PdfGridCellStyle cellStyle = PdfGridCellStyle();
  cellStyle.borders.all = PdfPens.lightBlue;
  cellStyle.borders.bottom = PdfPens.lightBlue;
  cellStyle.font = PdfStandardFont(PdfFontFamily.timesRoman, 14);
  cellStyle.textBrush = PdfSolidBrush(PdfColor(131, 130, 136));

//Creates layout format settings to allow the table pagination
  PdfLayoutFormat layoutFormat =
      PdfLayoutFormat(layoutType: PdfLayoutType.paginate);

//Draws the grid to the PDF page
  PdfLayoutResult gridResult = grid.draw(
      page: page,
      bounds: Rect.fromLTWH(0, result.bounds.bottom + 20,
          graphics.clientSize.width, graphics.clientSize.height - 100),
      format: layoutFormat)!;

  PdfGrid grid1 = PdfGrid();

//Add the columns to the grid
  grid1.columns.add(count: 5);

//Add header to the grid
  grid1.headers.add(1);

  PdfGridRow header1 = grid1.headers[0];
  header1.cells[0].value = 'Earthworks';
  header1.cells[1].value = '';
  header1.cells[2].value = '';
  header1.cells[3].value = '';
  header1.cells[4].value = '';

  //Creates the header style
  PdfGridCellStyle headerStyle1 = PdfGridCellStyle();
  headerStyle1.borders.all = PdfPen(PdfColor(126, 151, 173));
  headerStyle1.backgroundBrush = PdfSolidBrush(PdfColor(126, 151, 173));
  headerStyle1.textBrush = PdfBrushes.white;
  headerStyle1.font = PdfStandardFont(PdfFontFamily.timesRoman, 14,
      style: PdfFontStyle.regular);

//Adds cell customizations
  for (int i = 0; i < header1.cells.count; i++) {
    if (i == 0 || i == 1) {
      header1.cells[i].stringFormat = PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle);
    } else {
      header1.cells[i].stringFormat = PdfStringFormat(
          alignment: PdfTextAlignment.right,
          lineAlignment: PdfVerticalAlignment.middle);
    }
    header1.cells[i].style = headerStyle1;
  }
  var status = '';
//Add rows to grid
  PdfGridRow row1 = grid1.rows.add();
  for (int i = 0; i < allForms.length; i++) {
    if (allForms[i].date_start != null) {
      DateTime start = DateTime.parse(allForms[i].date_start!);
      DateTime end = DateTime.parse(allForms[i].date_end!);
      final tableDuration = daysBetween(start, end);
      if (end.isBefore(DateTime.now())) {
        status = "Complete";
      } else {
        status = "In Progress";
      }
      if (allForms[i].work == 'Earthworks') {
        if (allForms[i].type != '') {
          row1 = grid1.rows.add();
          row1.cells[0].value = allForms[i].type;
          row1.cells[1].value = status;
          row1.cells[2].value = outputFormat.format(start);
          row1.cells[3].value = outputFormat.format(end);
          row1.cells[4].value = tableDuration.toString() + " Days";
        } else {
          row1 = grid1.rows.add();
          row1.cells[0].value = allForms[i].type;
          row1.cells[1].value = '--';
          row1.cells[2].value = '--';
          row1.cells[3].value = '--';
          row1.cells[4].value = '--';
        }
      }
    }
  }

  //Set padding for grid cells
  grid1.style.cellPadding = PdfPaddings(left: 2, right: 2, top: 2, bottom: 2);

//Creates the grid cell styles
  PdfGridCellStyle cellStyle1 = PdfGridCellStyle();
  cellStyle1.borders.all = PdfPens.lightBlue;
  cellStyle1.borders.bottom = PdfPens.lightBlue;
  cellStyle1.font = PdfStandardFont(PdfFontFamily.timesRoman, 14);
  cellStyle1.textBrush = PdfSolidBrush(PdfColor(131, 130, 136));

//Adds cell customizations
  for (int i = 0; i < grid1.rows.count; i++) {
    PdfGridRow row1 = grid1.rows[i];
    for (int j = 0; j < row1.cells.count; j++) {
      row1.cells[j].style = cellStyle1;
      if (j == 0 || j == 1) {
        row1.cells[j].stringFormat = PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.middle);
      } else {
        row1.cells[j].stringFormat = PdfStringFormat(
            alignment: PdfTextAlignment.right,
            lineAlignment: PdfVerticalAlignment.middle);
      }
    }
  }

//Creates layout format settings to allow the table pagination
  PdfLayoutFormat layoutFormat1 =
      PdfLayoutFormat(layoutType: PdfLayoutType.paginate);

//Draws the grid to the PDF page
  gridResult = grid1.draw(
      page: page,
      bounds: Rect.fromLTWH(0, result.bounds.bottom + 45,
          graphics.clientSize.width, graphics.clientSize.height - 100),
      format: layoutFormat1)!;

  //Creates a PDF grid
  PdfGrid grid2 = PdfGrid();

//Add the columns to the grid
  grid2.columns.add(count: 5);

//Add header to the grid
  grid2.headers.add(1);

  PdfGridRow header2 = grid2.headers[0];
  header2.cells[0].value = 'Formworks';
  header2.cells[1].value = '';
  header2.cells[2].value = '';
  header2.cells[3].value = '';
  header2.cells[4].value = '';

  //Creates the header style
  PdfGridCellStyle headerStyle2 = PdfGridCellStyle();
  headerStyle2.borders.all = PdfPen(PdfColor(126, 151, 173));
  headerStyle2.backgroundBrush = PdfSolidBrush(PdfColor(126, 151, 173));
  headerStyle2.textBrush = PdfBrushes.white;
  headerStyle2.font = PdfStandardFont(PdfFontFamily.timesRoman, 14,
      style: PdfFontStyle.regular);

//Adds cell customizations
  for (int i = 0; i < header2.cells.count; i++) {
    if (i == 0 || i == 1) {
      header2.cells[i].stringFormat = PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle);
    } else {
      header2.cells[i].stringFormat = PdfStringFormat(
          alignment: PdfTextAlignment.right,
          lineAlignment: PdfVerticalAlignment.middle);
    }
    header2.cells[i].style = headerStyle2;
  }

//Add rows to grid
  PdfGridRow row2 = grid2.rows.add();
  for (int i = 0; i < allForms.length; i++) {
    if (allForms[i].date_start != null) {
      DateTime start = DateTime.parse(allForms[i].date_start!);
      DateTime end = DateTime.parse(allForms[i].date_end!);
      final tableDuration = daysBetween(start, end);
      if (end.isBefore(DateTime.now())) {
        status = "Complete";
      } else {
        status = "In Progress";
      }
      if (allForms[i].work == 'Formworks') {
        row2 = grid2.rows.add();
        row2.cells[0].value = allForms[i].type;
        row2.cells[1].value = status;
        row2.cells[2].value = outputFormat.format(start);
        row2.cells[3].value = outputFormat.format(end);
        row2.cells[4].value = tableDuration.toString() + " Days";
      }
    }
  }

  //Set padding for grid cells
  grid2.style.cellPadding = PdfPaddings(left: 2, right: 2, top: 2, bottom: 2);

//Creates the grid cell styles
  PdfGridCellStyle cellStyle2 = PdfGridCellStyle();
  cellStyle2.borders.all = PdfPens.lightBlue;
  cellStyle2.borders.bottom = PdfPens.lightBlue;
  cellStyle2.font = PdfStandardFont(PdfFontFamily.timesRoman, 14);
  cellStyle2.textBrush = PdfSolidBrush(PdfColor(131, 130, 136));

//Adds cell customizations
  for (int i = 0; i < grid2.rows.count; i++) {
    PdfGridRow row2 = grid2.rows[i];
    for (int j = 0; j < row2.cells.count; j++) {
      row2.cells[j].style = cellStyle2;
      if (j == 0 || j == 1) {
        row2.cells[j].stringFormat = PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.middle);
      } else {
        row2.cells[j].stringFormat = PdfStringFormat(
            alignment: PdfTextAlignment.right,
            lineAlignment: PdfVerticalAlignment.middle);
      }
    }
  }

//Creates layout format settings to allow the table pagination
  PdfLayoutFormat layoutFormat2 =
      PdfLayoutFormat(layoutType: PdfLayoutType.paginate);

//Draws the grid to the PDF page
  gridResult = grid2.draw(
      page: page,
      bounds: Rect.fromLTWH(0, result.bounds.bottom + 125,
          graphics.clientSize.width, graphics.clientSize.height - 100),
      format: layoutFormat2)!;

  //Creates a PDF grid
  PdfPage page2 = document.pages.add();
  PdfGrid grid3 = PdfGrid();

//Add the columns to the grid
  grid3.columns.add(count: 5);

//Add header to the grid
  grid3.headers.add(1);

  PdfGridRow header3 = grid3.headers[0];
  header3.cells[0].value = 'Masonry Works';
  header3.cells[1].value = '';
  header3.cells[2].value = '';
  header3.cells[3].value = '';
  header3.cells[4].value = '';

  //Creates the header style
  PdfGridCellStyle headerStyle3 = PdfGridCellStyle();
  headerStyle3.borders.all = PdfPen(PdfColor(126, 151, 173));
  headerStyle3.backgroundBrush = PdfSolidBrush(PdfColor(126, 151, 173));
  headerStyle3.textBrush = PdfBrushes.white;
  headerStyle3.font = PdfStandardFont(PdfFontFamily.timesRoman, 14,
      style: PdfFontStyle.regular);

//Adds cell customizations
  for (int i = 0; i < header3.cells.count; i++) {
    if (i == 0 || i == 1) {
      header3.cells[i].stringFormat = PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle);
    } else {
      header3.cells[i].stringFormat = PdfStringFormat(
          alignment: PdfTextAlignment.right,
          lineAlignment: PdfVerticalAlignment.middle);
    }
    header3.cells[i].style = headerStyle3;
  }

//Add rows to grid
  PdfGridRow row3 = grid3.rows.add();
  for (int i = 0; i < allForms.length; i++) {
    if (allForms[i].date_start != null) {
      DateTime start = DateTime.parse(allForms[i].date_start!);
      DateTime end = DateTime.parse(allForms[i].date_end!);
      final tableDuration = daysBetween(start, end);
      if (end.isBefore(DateTime.now())) {
        status = "Complete";
      } else {
        status = "In Progress";
      }
      if (allForms[i].work == 'Masonry Works') {
        row3 = grid3.rows.add();
        row3.cells[0].value = allForms[i].type;
        row3.cells[1].value = status;
        row3.cells[2].value = outputFormat.format(start);
        row3.cells[3].value = outputFormat.format(end);
        row3.cells[4].value = tableDuration.toString() + " Days";
      }
    }
  }

  //Set padding for grid cells
  grid3.style.cellPadding = PdfPaddings(left: 2, right: 2, top: 2, bottom: 2);

//Creates the grid cell styles
  PdfGridCellStyle cellStyle3 = PdfGridCellStyle();
  cellStyle3.borders.all = PdfPens.lightBlue;
  cellStyle3.borders.bottom = PdfPens.lightBlue;
  cellStyle3.font = PdfStandardFont(PdfFontFamily.timesRoman, 14);
  cellStyle3.textBrush = PdfSolidBrush(PdfColor(131, 130, 136));

//Adds cell customizations
  for (int i = 0; i < grid3.rows.count; i++) {
    PdfGridRow row3 = grid3.rows[i];
    for (int j = 0; j < row2.cells.count; j++) {
      row3.cells[j].style = cellStyle3;
      if (j == 0 || j == 1) {
        row3.cells[j].stringFormat = PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.middle);
      } else {
        row3.cells[j].stringFormat = PdfStringFormat(
            alignment: PdfTextAlignment.right,
            lineAlignment: PdfVerticalAlignment.middle);
      }
    }
  }

//Creates layout format settings to allow the table pagination
  PdfLayoutFormat layoutFormat3 =
      PdfLayoutFormat(layoutType: PdfLayoutType.paginate);

//Draws the grid to the PDF page
  gridResult = grid3.draw(
      page: page2,
      bounds: Rect.fromLTWH(
          0, 0, graphics.clientSize.width, graphics.clientSize.height - 100),
      format: layoutFormat3)!;

  PdfGrid grid4 = PdfGrid();

//Add the columns to the grid
  grid4.columns.add(count: 5);

//Add header to the grid
  grid4.headers.add(1);

  PdfGridRow header4 = grid4.headers[0];
  header4.cells[0].value = 'Reinforced Cement Works';
  header4.cells[1].value = '';
  header4.cells[2].value = '';
  header4.cells[3].value = '';
  header4.cells[4].value = '';

  //Creates the header style
  PdfGridCellStyle headerStyle4 = PdfGridCellStyle();
  headerStyle4.borders.all = PdfPen(PdfColor(126, 151, 173));
  headerStyle4.backgroundBrush = PdfSolidBrush(PdfColor(126, 151, 173));
  headerStyle4.textBrush = PdfBrushes.white;
  headerStyle4.font = PdfStandardFont(PdfFontFamily.timesRoman, 14,
      style: PdfFontStyle.regular);

//Adds cell customizations
  for (int i = 0; i < header4.cells.count; i++) {
    if (i == 0 || i == 1) {
      header4.cells[i].stringFormat = PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle);
    } else {
      header4.cells[i].stringFormat = PdfStringFormat(
          alignment: PdfTextAlignment.right,
          lineAlignment: PdfVerticalAlignment.middle);
    }
    header4.cells[i].style = headerStyle4;
  }

//Add rows to grid
  PdfGridRow row4 = grid4.rows.add();
  for (int i = 0; i < allForms.length; i++) {
    if (allForms[i].date_start != null) {
      DateTime start = DateTime.parse(allForms[i].date_start!);
      DateTime end = DateTime.parse(allForms[i].date_end!);
      final tableDuration = daysBetween(start, end);
      if (end.isBefore(DateTime.now())) {
        status = "Complete";
      } else {
        status = "In Progress";
      }
      if (allForms[i].work == 'Masonry Works') {
        if (allForms[i].type != '') {
          row4 = grid4.rows.add();
          row4.cells[0].value = allForms[i].type;
          row4.cells[1].value = status;
          row4.cells[2].value = outputFormat.format(start);
          row4.cells[3].value = outputFormat.format(end);
          row4.cells[4].value = tableDuration.toString() + " Days";
        } else {
          row4 = grid4.rows.add();
          row4.cells[0].value = allForms[i].type;
          row4.cells[1].value = '--';
          row4.cells[2].value = '--';
          row4.cells[3].value = '--';
          row4.cells[4].value = '--';
        }
      }
    }
  }

  //Set padding for grid cells
  grid4.style.cellPadding = PdfPaddings(left: 2, right: 2, top: 2, bottom: 2);

//Creates the grid cell styles
  PdfGridCellStyle cellStyle4 = PdfGridCellStyle();
  cellStyle4.borders.all = PdfPens.lightBlue;
  cellStyle4.borders.bottom = PdfPens.lightBlue;
  cellStyle4.font = PdfStandardFont(PdfFontFamily.timesRoman, 14);
  cellStyle4.textBrush = PdfSolidBrush(PdfColor(131, 130, 136));

//Adds cell customizations
  for (int i = 0; i < grid4.rows.count; i++) {
    PdfGridRow row4 = grid4.rows[i];
    for (int j = 0; j < row4.cells.count; j++) {
      row4.cells[j].style = cellStyle3;
      if (j == 0 || j == 1) {
        row4.cells[j].stringFormat = PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.middle);
      } else {
        row4.cells[j].stringFormat = PdfStringFormat(
            alignment: PdfTextAlignment.right,
            lineAlignment: PdfVerticalAlignment.middle);
      }
    }
  }

//Creates layout format settings to allow the table pagination
  PdfLayoutFormat layoutFormat4 =
      PdfLayoutFormat(layoutType: PdfLayoutType.paginate);

//Draws the grid to the PDF page
  gridResult = grid4.draw(
      page: page2,
      bounds: Rect.fromLTWH(0, bounds.bottom + 50, graphics.clientSize.width,
          graphics.clientSize.height - 100),
      format: layoutFormat4)!;

  List<int> bytes = document.save();
  document.dispose();

  saveAndLaunchFile(bytes, 'Output.pdf');
}

Widget printpdfButton(ProjectItem? itemProject, List<FormData>? allForms,
        List<FormData>? formData) =>
    ElevatedButton(
      child: const Text('Create PDF'),
      onPressed: () {
        _createPDF(itemProject!, allForms!, formData!);
      },
    );

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}
