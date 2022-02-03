import 'package:flutter/material.dart';

class CustomWidgets {
//button widget
// ignore: non_constant_identifier_names
nav_Button(String name, Widget icon, int flex, BuildContext context, Widget Function() JumpPage,){
  return Flexible(
    flex: flex,
    child: FractionallySizedBox(
                widthFactor: .7,
                heightFactor: .9,
                child: ElevatedButton(
                  onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => JumpPage()),);
                  }, 
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children:[
                      Text(name),
                      const SizedBox(width: 15,),
                      icon
                    ],
                  )
                  ),
              ),
  );
}

// ignore: non_constant_identifier_names
text_title(String text, double size, int flex){
  return Flexible(
    flex: flex,
  child: Text(text, style: TextStyle(fontSize: size, fontWeight: FontWeight.bold),)
  );
}

// ignore: non_constant_identifier_names
text_subtitle(String text, double size, int flex){
  return Flexible(
    flex: flex,
  child: Text(text, style: TextStyle(fontSize: size),)
  );
}

}