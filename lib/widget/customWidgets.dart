// ignore: file_names
import 'package:flutter/material.dart';

class CustomWidgets {
  /// PUSH parameter for forms that needs an arrow back at the appbar /
  /// PUSHREPLACEMENT to totally leave the current form, no arrowback at the appbar
  /// NOTE: do not use both PUSH and PUSHREPLACEMENT in once instance, one parameter must be null

//button widget
// ignore: non_constant_identifier_names
  nav_Button(
    String name,
    Widget icon,
    BuildContext context,
    double width,
    double height,
    Widget Function()? push,
    Widget Function()? pushReplacement,
  ) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * height,
      width: MediaQuery.of(context).size.width * width,
      child: ElevatedButton(
          onPressed: () {
            // ignore: unnecessary_null_comparison
            if (push != null) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => push()),
              );
              // ignore: unnecessary_null_comparison
            } else if (pushReplacement != null) {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => pushReplacement()), (Route<dynamic> route) => false);
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(name),
              const SizedBox(
                width: 15,
              ),
              icon
            ],
          )),
    );
  }

//title widget
// ignore: non_constant_identifier_names
  text_title(String text, double size) {
    return Text(
      text,
      style: TextStyle(fontSize: size, fontWeight: FontWeight.bold),
    );
  }

//subtitle widget
// ignore: non_constant_identifier_names
  text_subtitle(String text, double size) {
    return Text(
      text,
      style: TextStyle(fontSize: size),
    );
  }

//text form field widget
// ignore: non_constant_identifier_names
  textFormField_widget(String hintText, Color borderColor, double width) {
    return TextFormField(
      decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: width),
          )),
    );
  }
}
