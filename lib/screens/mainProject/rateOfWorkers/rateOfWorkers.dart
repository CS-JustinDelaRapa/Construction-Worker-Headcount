// ignore_for_file: file_names
import 'package:engineering/screens/hamburgerMenu/openDrawer.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';

class RateOfWorkers extends StatefulWidget {
  final VoidCallback openDrawer;

  const RateOfWorkers({Key? key, required this.openDrawer}) : super(key: key);

  @override
  _RateOfWorkersState createState() => _RateOfWorkersState();
}

List<TextEditingController> myController = [
  for (int i = 1; i <= 12; i++) TextEditingController()
];

class _RateOfWorkersState extends State<RateOfWorkers> {
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomWidgets().text_subtitle('Carpenter', 15),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: CustomWidgets().textFormField_widget(
                        '', Colors.white, 0, myController[1]),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomWidgets().text_subtitle('Laborer', 15),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: CustomWidgets().textFormField_widget(
                        '', Colors.white, 0, myController[2]),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomWidgets().text_subtitle('Mason', 15),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: CustomWidgets().textFormField_widget(
                        '', Colors.white, 0, myController[3]),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomWidgets().text_subtitle('Steel Man', 15),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: CustomWidgets().textFormField_widget(
                        '', Colors.white, 0, myController[4]),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomWidgets().text_subtitle('Painter', 15),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: CustomWidgets().textFormField_widget(
                        '', Colors.white, 0, myController[5]),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomWidgets().text_subtitle('Tile Man', 15),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: CustomWidgets().textFormField_widget(
                        '', Colors.white, 0, myController[6]),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomWidgets()
                      .text_subtitle('Door and Window\n Installer', 15),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: CustomWidgets().textFormField_widget(
                        '', Colors.white, 0, myController[7]),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomWidgets().text_subtitle('Electrician', 15),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: CustomWidgets().textFormField_widget(
                        '', Colors.white, 0, myController[8]),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomWidgets().text_subtitle('Plumber', 15),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: CustomWidgets().textFormField_widget(
                        '', Colors.white, 0, myController[9]),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomWidgets().text_subtitle('Welder', 15),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: CustomWidgets().textFormField_widget(
                        '', Colors.white, 0, myController[10]),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomWidgets().text_subtitle('Tinsmith', 15),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: CustomWidgets().textFormField_widget(
                        '', Colors.white, 0, myController[11]),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            CustomWidgets().funtion_Button('Save', const Icon(Icons.menu_open),
                0.6, 0.07, context, saveRateofWorkers)
          ],
        ),
      ),
    );
  }

  saveRateofWorkers() {
    for (int i = 0; i <= 12; i++) {
      print(myController[i]);
    }
  }
}
