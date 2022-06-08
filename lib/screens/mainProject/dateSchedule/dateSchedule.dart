import 'package:engineering/databaseHelper/DataBaseHelper.dart';
import 'package:engineering/model/formModel.dart';
import 'package:engineering/screens/hamburgerMenu/openDrawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DateScchedule extends StatefulWidget {
  final VoidCallback openDrawer;
  final int fk;
  const DateScchedule({ required this.openDrawer, required this.fk, Key? key }) : super(key: key);

  @override
  State<DateScchedule> createState() => _DateSccheduleState();
}

class _DateSccheduleState extends State<DateScchedule> {

  List<FormData>? allForms;
  bool isLoading = false;

  @override
  void initState() {
    refreshState();
    super.initState();
  }

  Future refreshState() async{
    setState(() {
      isLoading = true;
    });
    allForms = await DatabaseHelper.instance.readAllFormData(widget.fk);
  setState(() {
    isLoading = false;
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        leading: OpenDrawerWidget(
          onClicked: widget.openDrawer,
        ),
        title: const Text('Manpower Distribution'),
      ),
        body: isLoading? const Center(child: CircularProgressIndicator(),) : 
        SfCalendar(
      view: CalendarView.month,
      dataSource: MeetingDataSource(_getDataSource()),
      //  specialRegions: _getTimeRegions(),
      onTap: (CalendarTapDetails details) {
            // List<Meeting> appointments = details.appointments as List<Meeting>;
            // print(appointments[0].eventName);
            DateTime date = details.date!;
            CalendarElement element = details.targetElement;
                showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Text(DateFormat('MM/dd/yyyy').format(details.date!)),
                content: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ListView.builder(
                    shrinkWrap: false,
                    itemCount: details.appointments!.length,
                    itemBuilder: (context, index){
                      Meeting meeting = details.appointments![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical:4.0),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical:4.0),
                          decoration: BoxDecoration(
                            color: meeting.background,
                              border: Border.all(
                                color: meeting.background,
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(10))
                              ),
                          child: ListTile(
                            title: Text(meeting.eventName, style: const TextStyle(color: Colors.white,))
                          ),
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

          }
        );
      },
      monthViewSettings: const MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
          showTrailingAndLeadingDates: false                
        ),
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
        bool isPassedSaturday = false;
        Color color = getColor(allForms![x].work);    
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

  Color getColor(String type){
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