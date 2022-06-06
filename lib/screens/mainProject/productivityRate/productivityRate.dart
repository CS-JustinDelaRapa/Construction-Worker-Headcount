// ignore_for_file: file_names

import 'package:engineering/model/ProjectModel.dart';
import 'package:engineering/screens/hamburgerMenu/openDrawer.dart';
import 'package:engineering/screens/mainProject/productivityRate/forms/structural/formworksForm.dart';
import 'package:engineering/screens/mainProject/productivityRate/forms/structural/masonryForm.dart';
import 'package:engineering/screens/mainProject/structural/items/twoStoreyStructuralItems.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:engineering/model/formModel.dart';
import '../../../model/ProductivityModel.dart';
import '../architectural/items/bungalowArchitecturalItem.dart';
import '../architectural/items/twoStoreyArchitecturalItem.dart';
import 'package:engineering/databaseHelper/DataBaseHelper.dart';
import '../structural/items/bungalowStructuralItem.dart';

class ProductivityRate extends StatefulWidget {
  final VoidCallback openDrawer;
  final ProjectItem project;
  const ProductivityRate(
      {Key? key, required this.openDrawer, required this.project})
      : super(key: key);

  @override
  _ProductivityRateState createState() => _ProductivityRateState();
}

class _ProductivityRateState extends State<ProductivityRate> {
  // late List<FormData> formData;
  
  List<FormData>? formData;
  List<ProductivityItem>? productivityData;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshState();
  }

  Future refreshState() async {
    setState(() => isLoading = true);
    formData = await DatabaseHelper.instance.readForm(widget.project.id!);
    productivityData =
        await DatabaseHelper.instance.readAllProductivity(widget.project.id!);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: OpenDrawerWidget(
          onClicked: widget.openDrawer,
        ),
        title: const Text('Productivity Rate'),
      ),
      body: SingleChildScrollView(
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Structural',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Theme.of(context)
                                  .appBarTheme
                                  .foregroundColor),
                        ),
                      ],
                    ),
                  ),                  
                  Column(
                      children: formData!.where((element) => 
                      element.work == 'Earthworks' 
                      || element.work == 'Formworks' 
                      || element.work == 'Masonry Works'
                      || element.work == 'Reinforced Cement Works'
                      || element.work == 'Steel Reinforcement Works')
                      .map((form){
                        List<ProductivityItem> localProductivity=[];

                        for(int x = 0; x < productivityData!.length; x++){
                          if(form.work == productivityData![x].work&& form.type == productivityData![x].type){
                            localProductivity.add(productivityData![x]);
                          }
                        }

                        return ItemRow(item:localProductivity, form: form, );
                      }).toList(),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Architectural',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Theme.of(context)
                                  .appBarTheme
                                  .foregroundColor),
                        ),
                      ],
                    ),
                  ),                  
                  Column(
                      children: formData!.where((element) => 
                      element.work == 'Flooring' 
                      || element.work == 'Plastering' 
                      || element.work == 'Painting Works'
                      || element.work == 'Doors and Windows'
                      || element.work ==  'Ceiling'
                      || element.work == 'Roofing Works')
                      .map((form){
                        List<ProductivityItem> localProductivity=[];

                        for(int x = 0; x < productivityData!.length; x++){
                          if(form.work == productivityData![x].work&& form.type == productivityData![x].type){
                            localProductivity.add(productivityData![x]);
                          }
                        }

                        return ItemRow(item:localProductivity, form: form, );
                      }).toList(),
                    ),  
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Electrical and Plumbing',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Theme.of(context)
                                  .appBarTheme
                                  .foregroundColor),
                        ),
                      ],
                    ),
                  ),                    
                  Column(
                      children: formData!.where((element) => 
                      element.work == 'Electrical Works' 
                      || element.work == 'Plumbing Works')
                      .map((form){
                        List<ProductivityItem> localProductivity=[];

                        for(int x = 0; x < productivityData!.length; x++){
                          if(form.work == productivityData![x].work&& form.type == productivityData![x].type){
                            localProductivity.add(productivityData![x]);
                          }
                        }

                        return ItemRow(item:localProductivity, form: form, );
                      }).toList(),
                    ),                                       
                ],
              )
          ),
    );
  }
}

class ItemRow extends StatefulWidget {
  final FormData form;
  final List<ProductivityItem> item;
  const ItemRow({Key? key, required this.form, required this.item}) : super(key: key);

  @override
  State<ItemRow> createState() => _ItemRowState();
}

class _ItemRowState extends State<ItemRow> {

  late String _selectedType;
  late double _selectedValue;
  List<ProductivityItem>? _prodItem;
  ProductivityItem? selectedItem;
  bool isUpdating = false, isLoading= false; 

  final TextEditingController _valueController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  RegExp regex = RegExp(r'(?!^ +$)^.+$');

  @override
  void initState() {
    _selectedType = widget.form.col_1;
    _selectedValue = widget.form.col_1_val;
    _valueController.text = widget.form.col_1_val.toString();
    _prodItem = widget.item;

    for(int x = 0; x< widget.item.length; x++){
    if(widget.item[x].col_1 == _selectedType){
      selectedItem = widget.item[x];
    }}
    
    super.initState();
  }

  Future getUpdatedProdItem() async {
    setState(() {
      isLoading = true;
    });
    List<ProductivityItem>? allProdItem = await DatabaseHelper.instance.readAllProductivity(widget.form.fk);
    _prodItem = [];
    for(int x = 0; x < allProdItem!.length; x++){
      if(allProdItem[x].type == widget.form.type && allProdItem[x].work == widget.form.work){
        _prodItem!.add(allProdItem[x]);
      }
    }
    
    setState(() {
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: 
                        isLoading? const Center(child: CircularProgressIndicator(),):
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Text(widget.form.type)),
                            //dropdown or null
                            widget.form.col_1 == 'DEFAULT' ? Container() :
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child:   Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: DropdownButtonFormField(
                                  isExpanded: true,
                                  value: _selectedType,
                                  onChanged: (value) {
                                    for(int x = 0; x< _prodItem!.length; x++){
                                      if(_prodItem![x].col_1 == value.toString()){
                                        selectedItem = _prodItem![x];
                                      }
                                    }
                                    setState(() {
                                      _selectedType = value.toString();
                                      _valueController.text = selectedItem!.col_1_val.toString();
                                      _selectedValue = selectedItem!.col_1_val;
                                    });
                                  },
                                  items: _prodItem!.map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item.col_1),
                                      value: item.col_1,
                                    );
                                  }).toList()),
                              )),
                            SizedBox(
                              width: widget.form.col_1 == 'DEFAULT' ?
                              MediaQuery.of(context).size.width * 0.5:
                              MediaQuery.of(context).size.width * 0.20,
                              child: Center(
                                child: 
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: TextFormField(
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty ||
                                                        !regex.hasMatch(value)) {
                                                      return '';
                                                    }
                                                    return null;
                                                  },
                                                  controller: _valueController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onChanged: (value) {
                                                    if(value != selectedItem!.col_1_val.toString()){
                                                      setState(() {
                                                        isUpdating = true;
                                                      });
                                                    }else{
                                                      setState(() {
                                                        isUpdating = false;
                                                      });
                                                    }
                                                    
                                                    setState(() {
                                                     value == ''? 
                                                     isUpdating = false:
                                                      _selectedValue = double.parse(value);
                                                    });
                                                  },
                                                ),
                                )
                                  )),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.20,
                              child: ElevatedButton(
                                
                                onPressed: isUpdating?
                                () async {
                                final itemToUpdate = ProductivityItem(
                                  id: selectedItem!.id,
                                  fk: selectedItem!.fk, 
                                  col_1: _selectedType, 
                                  col_1_val: _selectedValue, 
                                  type: selectedItem!.type, 
                                  work: selectedItem!.work);

                              await DatabaseHelper.instance.updateProductivityWithID(itemToUpdate);
                              setState(() {
                                isUpdating = false;
                              });
                              getUpdatedProdItem();
                              }:null,
                              child: const Text('Save')))                          
                          ]
                        ),
      ),
    );
  }
}