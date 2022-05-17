import 'package:engineering/screens/hamburgerMenu/stack.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';
import '../homePage.dart';

// ignore: camel_case_types
class about extends StatefulWidget {
  const about({Key? key}) : super(key: key);

  @override
  _about createState() => _about();
}

// ignore: camel_case_types
class _about extends State<about> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("About"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(children: [
              const Padding(
                  padding: EdgeInsets.fromLTRB(16, 50, 16, 50),
                  child: Text(
                    'Don Honorio Ventura State University',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  )),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomWidgets().text_subtitle('Binuya, Rodel L.', 20),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomWidgets().text_subtitle('Castro, Jericho G.', 20),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child:
                    CustomWidgets().text_subtitle('Lingat, Joyce Anne S.', 20),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child:
                    CustomWidgets().text_subtitle('Pamandanan, Janella M.', 20),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomWidgets().text_subtitle('Simbulan, Demi C.', 20),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomWidgets()
                    .text_subtitle('Tolentino, Aaron Marc W.', 20),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 50, 16, 50),
                child: CustomWidgets().text_title('January 2022', 20),
              ),
            ]),
          ),
        ));
  }
}
