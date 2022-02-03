import 'package:flutter/material.dart';

class CustomWidgets {
//button widget
nav_Button(){
  return Flexible(
    child: FractionallySizedBox(
                widthFactor: .7,
                heightFactor: .9,
                child: ElevatedButton(
                  onPressed: (){}, 
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text('Project List'),
                      SizedBox(width: 15,),
                      Icon(Icons.list)
                    ],
                  )
                  ),
              ),
  );
}


}