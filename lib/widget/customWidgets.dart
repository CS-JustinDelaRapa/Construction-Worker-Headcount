import 'package:flutter/material.dart';

class CustomWidgets {

/// PUSH parameter for forms that needs an arrow back at the appbar /
/// PUSHREPLACEMENT to totally leave the current form, no arrowback at the appbar
/// NOTE: do not use both PUSH and PUSHREPLACEMENT in once instance, one parameter must be null

//button widget
// ignore: non_constant_identifier_names
nav_Button(String name, Widget icon, int flex, BuildContext context, Widget Function()? push,Widget Function()? pushReplacement,){
  return Flexible(
    flex: flex,
    child: FractionallySizedBox(
                widthFactor: .7,
                heightFactor: .9,
                child: ElevatedButton(
                  onPressed: (){
                      // ignore: unnecessary_null_comparison
                      if(pushReplacement == null){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => push!()),);                        
                      // ignore: unnecessary_null_comparison
                      }else if(push == null){
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => pushReplacement()), (Route<dynamic> route) => false);
                      }
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