import 'package:engineering/databaseHelper/DataBaseHelper.dart';
import 'package:engineering/model/ProjectModel.dart';
import 'package:engineering/model/formModel.dart';
import 'package:engineering/screens/mainProject/structural/items/twoStoreyStructuralItems.dart';
import 'package:flutter/material.dart';

import '../../../structural/items/bungalowStructuralItem.dart';

class EarthworksForm extends StatefulWidget {
  final ProjectItem projectType;
  const EarthworksForm({Key? key, required this.projectType}) : super(key: key);

  @override
  State<EarthworksForm> createState() => _EarthworksFormState();
}

class _EarthworksFormState extends State<EarthworksForm> {

  late List<FormData> formData;

  RegExp regex = RegExp(r'(?!^ +$)^.+$');
  List<String> soilType = ['Soft Soil', 'Hard Soil'];
  TextEditingController productivityRateController = TextEditingController();
  String? _selectedType;
  bool isLoading = true;
  double? defaultValue;

  @override
  void initState() {
    super.initState();
    refreshState();
  }

  Future refreshState() async {
    setState(() => isLoading = true);

    formData = await DatabaseHelper.instance.readProductivityForm(widget.projectType.id!, BungalowStructuralItems.earthWorks.title);

    for(int x = 0; x < formData.length ;x++){
      if(formData[x].type == "Excavation"){
        _selectedType = formData[x].col_1;
        defaultValue = formData[x].col_1_val;
      }
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Earthworks'),
      ),
      body: isLoading ? const Center(child: CircularProgressIndicator())
      : Form(
        child: Row(
          children: [
            Column(
              children: BungalowStructuralItems.listEarthWorks
                  .map((item) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item,
                          style: TextStyle(fontSize: 16),
                        ),
                      ))
                  .toList(),
            ),
            Column(
              children: formData.map((item) => 
              // Text(item.col_1)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:                                 
                item.type == 'Excavation'? 
                Row(
                  children: [
                    DropdownButtonFormField(
                        decoration:
                            const InputDecoration(
                          helperText:
                              ' ', // this is new
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Required Soil Type';
                          }
                          return null;
                        },                    
                        items: soilType.map((soilType) {
                          return DropdownMenuItem(
                            child: Text(soilType),
                            value: soilType,
                          );
                        }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedType =
                                  value.toString();
                              if (_selectedType ==
                                  "Soft Soil") {
                                defaultValue = 3;
                                productivityRateController
                                        .text =
                                    defaultValue
                                        .toString();
                              } else {  
                                defaultValue = 2;
                                productivityRateController
                                        .text =
                                    defaultValue
                                        .toString();
                              }
                            });
                          },
                      ),
                      Text('sample')
                  ],
                )
                : Text('backfilling')
                // Row(
                //                           children: [
                //                             DropdownButtonFormField(
                //                                 decoration:
                //                                     const InputDecoration(
                //                                   helperText:
                //                                       ' ', // this is new
                //                                 ),
                //                                 validator: (value) {
                //                                   if (value == null) {
                //                                     return 'Required Soil Type';
                //                                   }
                //                                   return null;
                //                                 },
                //                                 hint: const Text(
                //                                     'Soil Type'), // Not necessary for Option 1
                //                                 value: _selectedType,
                //                                 onChanged: (value) {
                //                                   setState(() {
                //                                     _selectedType =
                //                                         value.toString();
                //                                     if (_selectedType ==
                //                                         "Soft Soil") {
                //                                       defaultValue = 3;
                //                                       productivityRateController
                //                                               .text =
                //                                           defaultValue
                //                                               .toString();
                //                                     } else {
                //                                       defaultValue = 2;
                //                                       productivityRateController
                //                                               .text =
                //                                           defaultValue
                //                                               .toString();
                //                                     }
                //                                   });
                //                                 },
                //                                 items: soilType.map((soilType) {
                //                                   return DropdownMenuItem(
                //                                     child: Text(soilType),
                //                                     value: soilType,
                //                                   );
                //                                 }).toList()),
                //                             Padding(
                //                               padding:
                //                                   const EdgeInsets.all(8.0),
                //                               child: Align(
                //                                   alignment:
                //                                       Alignment.centerLeft,
                //                                   child: TextFormField(
                //                                     decoration:
                //                                         const InputDecoration(
                //                                       helperText:
                //                                           ' ', // this is new
                //                                     ),
                //                                     validator: (value) {
                //                                       if (value == null ||
                //                                           value.isEmpty ||
                //                                           !regex.hasMatch(
                //                                               value)) {
                //                                         return '';
                //                                       }
                //                                       return null;
                //                                     },
                //                                     controller:
                //                                         productivityRateController,
                //                                     keyboardType:
                //                                         TextInputType.number,
                //                                   )),
                //                             ),
                //                           ],
                //                         )
                // : Padding(
                //                           padding: const EdgeInsets.fromLTRB(
                //                               8, 25, 8, 0),
                //                           child: SizedBox(
                //                               width: MediaQuery.of(context)
                //                                       .size
                //                                       .width *
                //                                   0.5,
                //                               height: MediaQuery.of(context)
                //                                       .size
                //                                       .height *
                //                                   0.07,
                //                               child: Align(
                //                                   alignment: Alignment.centerLeft,
                //                                   child: TextFormField(
                //                                     decoration:
                //                                         const InputDecoration(
                //                                       helperText:
                //                                           ' ', // this is new
                //                                     ),
                //                                     validator: (value) {
                //                                       if (value == null ||
                //                                           value.isEmpty ||
                //                                           !regex
                //                                               .hasMatch(value)) {
                //                                         return 'This Field is Required';
                //                                       }
                //                                       return null;
                //                                     },
                //                                     controller:
                //                                         productivityRateController,
                //                                     keyboardType:
                //                                         TextInputType.number,
                //                                   ))),
                //                         ),
                
                )
                ).toList(),
            )
          ],
        ),
      ),
    );
  }
}
