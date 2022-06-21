// ignore_for_file: file_names

import 'package:engineering/model/ProjectModel.dart';
import 'package:engineering/screens/hamburgerMenu/openDrawer.dart';
import 'package:flutter/material.dart';
import 'package:engineering/model/formModel.dart';
import '../../../model/ProductivityModel.dart';
import 'package:engineering/databaseHelper/DataBaseHelper.dart';

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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Productivity Rate',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'unit/day',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Theme.of(context).appBarTheme.foregroundColor
                            : const Color.fromRGBO(139, 216, 189, 1),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Structural',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 25,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.white
                                      : const Color.fromARGB(255, 35, 28, 59)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Earthworks',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Theme.of(context)
                                      .appBarTheme
                                      .foregroundColor
                                  : const Color.fromRGBO(139, 216, 189, 1)),
                        ),
                      ),
                      Column(
                        children: formData!
                            .where((element) => element.work == 'Earthworks')
                            .map((form) {
                          List<ProductivityItem> localProductivity = [];

                          for (int x = 0; x < productivityData!.length; x++) {
                            if (form.work == productivityData![x].work &&
                                form.type == productivityData![x].type) {
                              localProductivity.add(productivityData![x]);
                            }
                          }

                          return Row(
                            children: [
                              ItemRow(
                                  item: localProductivity,
                                  form: form,
                                  unit: 'cum'),
                            ],
                          );
                        }).toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Formworks',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Theme.of(context)
                                      .appBarTheme
                                      .foregroundColor
                                  : const Color.fromRGBO(139, 216, 189, 1)),
                        ),
                      ),
                      Column(
                        children: formData!
                            .where((element) => element.work == 'Formworks')
                            .map((form) {
                          List<ProductivityItem> localProductivity = [];

                          for (int x = 0; x < productivityData!.length; x++) {
                            if (form.work == productivityData![x].work &&
                                form.type == productivityData![x].type) {
                              localProductivity.add(productivityData![x]);
                            }
                          }

                          return ItemRow(
                              item: localProductivity, form: form, unit: 'sqm');
                        }).toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Masonry Works',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Theme.of(context)
                                      .appBarTheme
                                      .foregroundColor
                                  : const Color.fromRGBO(139, 216, 189, 1)),
                        ),
                      ),
                      Column(
                        children: formData!
                            .where((element) => element.work == 'Masonry Works')
                            .map((form) {
                          List<ProductivityItem> localProductivity = [];

                          for (int x = 0; x < productivityData!.length; x++) {
                            if (form.work == productivityData![x].work &&
                                form.type == productivityData![x].type) {
                              localProductivity.add(productivityData![x]);
                            }
                          }

                          return ItemRow(
                              item: localProductivity, form: form, unit: 'sqm');
                        }).toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Reinforced Cement Works',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Theme.of(context)
                                      .appBarTheme
                                      .foregroundColor
                                  : const Color.fromRGBO(139, 216, 189, 1)),
                        ),
                      ),
                      Column(
                        children: formData!
                            .where((element) =>
                                element.work == 'Reinforced Cement Works')
                            .map((form) {
                          List<ProductivityItem> localProductivity = [];

                          for (int x = 0; x < productivityData!.length; x++) {
                            if (form.work == productivityData![x].work &&
                                form.type == productivityData![x].type) {
                              localProductivity.add(productivityData![x]);
                            }
                          }

                          return ItemRow(
                              item: localProductivity, form: form, unit: 'cum');
                        }).toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Steel Reinforcement Works',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Theme.of(context)
                                      .appBarTheme
                                      .foregroundColor
                                  : const Color.fromRGBO(139, 216, 189, 1)),
                        ),
                      ),
                      Column(
                        children: formData!
                            .where((element) =>
                                element.work == 'Steel Reinforcement Works')
                            .map((form) {
                          List<ProductivityItem> localProductivity = [];

                          for (int x = 0; x < productivityData!.length; x++) {
                            if (form.work == productivityData![x].work &&
                                form.type == productivityData![x].type) {
                              localProductivity.add(productivityData![x]);
                            }
                          }

                          return ItemRow(
                              item: localProductivity, form: form, unit: 'kg');
                        }).toList(),
                      ),
                      Container(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Theme.of(context).appBarTheme.foregroundColor
                            : const Color.fromRGBO(139, 216, 189, 1),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Architectural',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 25,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.white
                                      : const Color.fromARGB(255, 35, 28, 59)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Flooring',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Theme.of(context)
                                      .appBarTheme
                                      .foregroundColor
                                  : const Color.fromRGBO(139, 216, 189, 1)),
                        ),
                      ),
                      Column(
                        children: formData!
                            .where((element) => element.work == 'Flooring')
                            .map((form) {
                          List<ProductivityItem> localProductivity = [];

                          for (int x = 0; x < productivityData!.length; x++) {
                            if (form.work == productivityData![x].work &&
                                form.type == productivityData![x].type) {
                              localProductivity.add(productivityData![x]);
                            }
                          }

                          return ItemRow(
                              item: localProductivity, form: form, unit: 'sqm');
                        }).toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Plastering',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Theme.of(context)
                                      .appBarTheme
                                      .foregroundColor
                                  : const Color.fromRGBO(139, 216, 189, 1)),
                        ),
                      ),
                      Column(
                        children: formData!
                            .where((element) => element.work == 'Plastering')
                            .map((form) {
                          List<ProductivityItem> localProductivity = [];

                          for (int x = 0; x < productivityData!.length; x++) {
                            if (form.work == productivityData![x].work &&
                                form.type == productivityData![x].type) {
                              localProductivity.add(productivityData![x]);
                            }
                          }

                          return ItemRow(
                              item: localProductivity, form: form, unit: 'sqm');
                        }).toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Painting Works',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Theme.of(context)
                                      .appBarTheme
                                      .foregroundColor
                                  : const Color.fromRGBO(139, 216, 189, 1)),
                        ),
                      ),
                      Column(
                        children: formData!
                            .where(
                                (element) => element.work == 'Painting Works')
                            .map((form) {
                          List<ProductivityItem> localProductivity = [];

                          for (int x = 0; x < productivityData!.length; x++) {
                            if (form.work == productivityData![x].work &&
                                form.type == productivityData![x].type) {
                              localProductivity.add(productivityData![x]);
                            }
                          }

                          return ItemRow(
                              item: localProductivity, form: form, unit: 'sqm');
                        }).toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Doors and Windows',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Theme.of(context)
                                      .appBarTheme
                                      .foregroundColor
                                  : const Color.fromRGBO(139, 216, 189, 1)),
                        ),
                      ),
                      Column(
                        children: formData!
                            .where((element) =>
                                element.work == 'Doors and Windows')
                            .map((form) {
                          List<ProductivityItem> localProductivity = [];

                          for (int x = 0; x < productivityData!.length; x++) {
                            if (form.work == productivityData![x].work &&
                                form.type == productivityData![x].type) {
                              localProductivity.add(productivityData![x]);
                            }
                          }

                          return ItemRow(
                              item: localProductivity,
                              form: form,
                              unit: form.type.toLowerCase() == 'doors' ||
                                      form.type.toLowerCase() == 'windows'
                                  ? 'sqm'
                                  : 'sets');
                        }).toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Ceiling',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Theme.of(context)
                                      .appBarTheme
                                      .foregroundColor
                                  : const Color.fromRGBO(139, 216, 189, 1)),
                        ),
                      ),
                      Column(
                        children: formData!
                            .where((element) => element.work == 'Ceiling')
                            .map((form) {
                          List<ProductivityItem> localProductivity = [];

                          for (int x = 0; x < productivityData!.length; x++) {
                            if (form.work == productivityData![x].work &&
                                form.type == productivityData![x].type) {
                              localProductivity.add(productivityData![x]);
                            }
                          }

                          return ItemRow(
                              item: localProductivity, form: form, unit: 'sqm');
                        }).toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Roofing Works',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Theme.of(context)
                                      .appBarTheme
                                      .foregroundColor
                                  : const Color.fromRGBO(139, 216, 189, 1)),
                        ),
                      ),
                      Column(
                        children: formData!
                            .where((element) => element.work == 'Roofing Works')
                            .map((form) {
                          List<ProductivityItem> localProductivity = [];

                          for (int x = 0; x < productivityData!.length; x++) {
                            if (form.work == productivityData![x].work &&
                                form.type == productivityData![x].type) {
                              localProductivity.add(productivityData![x]);
                            }
                          }

                          return ItemRow(
                              item: localProductivity, form: form, unit: 'sqm');
                        }).toList(),
                      ),
                      Container(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Theme.of(context).appBarTheme.foregroundColor
                            : const Color.fromRGBO(139, 216, 189, 1),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Electrical and Plumbing',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 25,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.white
                                      : const Color.fromARGB(255, 35, 28, 59)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Electrical Works',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Theme.of(context)
                                      .appBarTheme
                                      .foregroundColor
                                  : const Color.fromRGBO(139, 216, 189, 1)),
                        ),
                      ),
                      Column(
                        children: formData!
                            .where(
                                (element) => element.work == 'Electrical Works')
                            .map((form) {
                          List<ProductivityItem> localProductivity = [];

                          for (int x = 0; x < productivityData!.length; x++) {
                            if (form.work == productivityData![x].work &&
                                form.type == productivityData![x].type) {
                              localProductivity.add(productivityData![x]);
                            }
                          }

                          return ItemRow(
                              item: localProductivity,
                              form: form,
                              unit: form.type.toLowerCase() == 'fixtures'
                                  ? 'sets'
                                  : 'm');
                        }).toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Plumbing Works',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Theme.of(context)
                                      .appBarTheme
                                      .foregroundColor
                                  : const Color.fromRGBO(139, 216, 189, 1)),
                        ),
                      ),
                      Column(
                        children: formData!
                            .where(
                                (element) => element.work == 'Plumbing Works')
                            .map((form) {
                          List<ProductivityItem> localProductivity = [];

                          for (int x = 0; x < productivityData!.length; x++) {
                            if (form.work == productivityData![x].work &&
                                form.type == productivityData![x].type) {
                              localProductivity.add(productivityData![x]);
                            }
                          }

                          return ItemRow(
                              item: localProductivity,
                              form: form,
                              unit: form.type.toLowerCase() == 'fixtures'
                                  ? 'sets'
                                  : 'm');
                        }).toList(),
                      ),
                    ],
                  )),
      ),
    );
  }
}

class ItemRow extends StatefulWidget {
  final FormData form;
  final List<ProductivityItem> item;
  final String unit;
  const ItemRow(
      {Key? key, required this.form, required this.item, required this.unit})
      : super(key: key);

  @override
  State<ItemRow> createState() => _ItemRowState();
}

class _ItemRowState extends State<ItemRow> {
  late String _selectedType;
  late double _selectedValue;
  List<ProductivityItem>? _prodItem;
  ProductivityItem? selectedItem;
  bool isUpdating = false, isLoading = false;

  final TextEditingController _valueController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  RegExp regex = RegExp(r'(?!^ +$)^.+$');

  @override
  void initState() {
    _selectedType = widget.form.col_1;
    _selectedValue = widget.form.col_1_val;
    _valueController.text = widget.form.col_1_val.toString();
    _prodItem = widget.item;

    for (int x = 0; x < widget.item.length; x++) {
      if (widget.item[x].col_1 == _selectedType) {
        selectedItem = widget.item[x];
      }
    }

    super.initState();
  }

  Future getUpdatedProdItem() async {
    setState(() {
      isLoading = true;
    });
    List<ProductivityItem>? allProdItem =
        await DatabaseHelper.instance.readAllProductivity(widget.form.fk);
    _prodItem = [];
    for (int x = 0; x < allProdItem!.length; x++) {
      if (allProdItem[x].type == widget.form.type &&
          allProdItem[x].work == widget.form.work) {
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
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Row(children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.20,
                    child: Text(widget.form.type)),
                //dropdown or null
                widget.form.col_1 == 'DEFAULT'
                    ? Container()
                    : SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: DropdownButtonFormField(
                              isExpanded: true,
                              value: _selectedType,
                              onChanged: (value) {
                                for (int x = 0; x < _prodItem!.length; x++) {
                                  if (_prodItem![x].col_1 == value.toString()) {
                                    selectedItem = _prodItem![x];
                                  }
                                }
                                setState(() {
                                  _selectedType = value.toString();
                                  _valueController.text =
                                      selectedItem!.col_1_val.toString();
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
                    width: widget.form.col_1 == 'DEFAULT'
                        ? MediaQuery.of(context).size.width * 0.45
                        : MediaQuery.of(context).size.width * 0.15,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
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
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value != selectedItem!.col_1_val.toString()) {
                            setState(() {
                              isUpdating = true;
                            });
                          } else {
                            setState(() {
                              isUpdating = false;
                            });
                          }

                          setState(() {
                            value == ''
                                ? isUpdating = false
                                : _selectedValue = double.parse(value);
                          });
                        },
                      ),
                    ))),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: Text(widget.unit)),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: ElevatedButton(
                        onPressed: isUpdating
                            ? () async {
                                final itemToUpdate = ProductivityItem(
                                    id: selectedItem!.id,
                                    fk: selectedItem!.fk,
                                    col_1: _selectedType,
                                    col_1_val: _selectedValue,
                                    type: selectedItem!.type,
                                    work: selectedItem!.work);

                                await DatabaseHelper.instance
                                    .updateProductivityWithID(itemToUpdate);
                                setState(() {
                                  isUpdating = false;
                                });
                                getUpdatedProdItem();
                              }
                            : null,
                        child: const Text('Save')))
              ]),
      ),
    );
  }
}
