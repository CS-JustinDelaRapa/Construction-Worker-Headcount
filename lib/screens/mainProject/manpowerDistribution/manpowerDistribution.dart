// ignore_for_file: file_names
// import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:engineering/custom_icons_icons.dart';
import 'package:engineering/databaseHelper/DataBaseHelper.dart';
import 'package:engineering/model/AdditionalManpowerModel.dart';
import 'package:engineering/model/ProjectModel.dart';
import 'package:engineering/model/formModel.dart';
import 'package:engineering/model/workerModel.dart';
import 'package:engineering/screens/hamburgerMenu/openDrawer.dart';
import 'package:engineering/screens/mainProject/manpowerDistribution/scrollable-column-widget.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'fixed-column.widget.dart';
import '../dateSchedule/mobile.dart';

class ManpowerDistribution extends StatefulWidget {
  final VoidCallback openDrawer;
  final ProjectItem project;

  const ManpowerDistribution(
      {Key? key, required this.openDrawer, required this.project})
      : super(key: key);

  @override
  _ManpowerDistributionState createState() => _ManpowerDistributionState();
}

class _ManpowerDistributionState extends State<ManpowerDistribution> {
  //database
  List<FormData>? allForms;
  List<WorkerType>? allWorkers;
  List<AdditionalManpower>? allManpower;
  bool isLoading = false, isChecked = false;

//tile data defaults
//structural
  List<String> earthWorks = ['Laborer'];
  List<int> earthworksNumber = [0];
  List<int> tempEarthworksNumber = [0];
  List<int> additionalEarthworksNumber = [0];
  List<double> earthworksRate = [0];
  double earthworksCost = 0;
  double additionalEarthworksCost = 0;

  List<String> formworks = ['Carpenter', 'Laborer'];
  List<int> formworksNumber = [0, 0];
  List<int> additionalformworksNumber = [0, 0];
  List<int> tempFormworksNumber = [0, 0];
  List<double> formworksRate = [0, 0];
  double formworksCost = 0;
  double additionalformworksCost = 0;

  List<String> masonry = ['Tile Man', 'Laborer'];
  List<int> masonryNumber = [0, 0];
  List<int> additionalmasonryNumber = [0, 0];
  List<int> tempMasonryNumber = [0, 0];
  List<double> masonryRate = [0, 0];
  double masonryCost = 0;
  double additionalmasonryCost = 0;

  List<String> reinforcedCementWorks = ['Mason', 'Laborer'];
  List<int> reinforcedCementWorksNumber = [0, 0];
  List<int> additionalreinforcedCementWorksNumber = [0, 0];
  List<int> tempReinforcedCementWorksNumber = [0, 0];
  List<double> reinforcedCementWorksRate = [0, 0];
  double reinforcedCementWorksCost = 0;
  double additionalreinforcedCementWorksCost = 0;

  List<String> steelReinforcementWorks = ['Steel Man'];
  List<int> steelReinforcementWorksNumber = [0];
  List<int> additionalsteelReinforcementWorksNumber = [0];
  List<int> tempSteelReinforcementWorksNumber = [0];
  List<double> steelReinforcementWorksRate = [0];
  double steelReinforcementWorksCost = 0;
  double additionalsteelReinforcementWorksCost = 0;

//architectural
  List<String> flooring = ['Tileman', 'Laborer'];
  List<int> flooringNumber = [0, 0];
  List<int> additionalflooringNumber = [0, 0];
  List<int> tempeFlooringNumber = [0, 0];
  List<double> flooringRate = [0, 0];
  double flooringCost = 0;
  double additionalflooringCost = 0;

  List<String> plastering = ['Mason', 'Laborer'];
  List<int> plasteringNumber = [0, 0];
  List<int> additionalplasteringNumber = [0, 0];
  List<int> tempPlasteringNumber = [0, 0];
  List<double> plasteringRate = [0, 0];
  double plasteringCost = 0;
  double additionalplasteringCost = 0;

  List<String> paintingWorks = ['Painter'];
  List<int> paintingWorksNumber = [0];
  List<int> additionalpaintingWorksNumber = [0];
  List<int> tempPaintingWorksNumber = [0];
  List<double> paintingWorksRate = [0];
  double paintingWorksCost = 0;
  double additionalpaintingWorksCost = 0;

  List<String> doorsAndWindows = ['Door Installer', 'Window Installer'];
  List<int> doorAndWindowsNumber = [0, 0];
  List<int> additionaldoorAndWindowsNumber = [0, 0];
  List<int> tempDoorAndWindowsNumber = [0, 0];
  List<double> doorAndWindowsRate = [0, 0];
  double doorsAndWindowsCost = 0;
  double additionaldoorsAndWindowsCost = 0;

  List<String> ceiling = ['Carpenter', 'Laborer'];
  List<int> ceilingNumber = [0, 0];
  List<int> additionalceilingNumber = [0, 0];
  List<int> tempCeilingNumber = [0, 0];
  List<double> ceilingRate = [0, 0];
  double ceilingCost = 0;
  double additionalceilingCost = 0;

  List<String> roofing = ['Tinsmith', 'Welder', 'Laborer'];
  List<int> roofingNumber = [0, 0, 0];
  List<int> additionalroofingNumber = [0, 0, 0];
  List<int> tempRoofingNumber = [0, 0, 0];
  List<double> roofingRate = [0, 0, 0];
  double roofingCost = 0;
  double additionalroofingCost = 0;

//electrical and plumbing
  List<String> electricalWorks = ['Electrician', 'Laborer'];
  List<int> electricalWorksNumber = [0, 0];
  List<int> additionalelectricalWorksNumber = [0, 0];
  List<int> tempElectricalWorksNumber = [0, 0];
  List<double> electricalWorksRate = [0, 0];
  double electricalWorksCost = 0;
  double additionalelectricalWorksCost = 0;

  List<String> plumbing = ['Plumber', 'Laborer'];
  List<int> plumbingNumber = [0, 0];
  List<int> additionalplumbingNumber = [0, 0];
  List<int> tempPlumbingNumber = [0, 0];
  List<double> plumbingRate = [0, 0];
  double plumbingCost = 0;
  double additionalplumbingCost = 0;
  List<FormData>? formData;
  ProjectItem? itemProject;
  @override
  void initState() {
    super.initState();
    refreshState();
  }

  Future refreshState() async {
    setState(() {
      isLoading = true;
    });
    formData = await DatabaseHelper.instance.readForm(widget.project.id!);
    allForms =
        await DatabaseHelper.instance.readAllFormData(widget.project.id!);
    allWorkers = await DatabaseHelper.instance.readWorkers(widget.project.id!);
    allManpower =
        await DatabaseHelper.instance.readAddtlManpower(widget.project.id!);
    itemProject = await DatabaseHelper.instance.readProject(widget.project.id!);

    earthworksNumber = [0];
    tempEarthworksNumber = [0];
    additionalEarthworksNumber = [0];
    earthworksRate = [0];
    earthworksCost = 0;
    additionalEarthworksCost = 0;

    formworksNumber = [0, 0];
    additionalformworksNumber = [0, 0];
    tempFormworksNumber = [0, 0];
    formworksRate = [0, 0];
    formworksCost = 0;
    additionalformworksCost = 0;
    masonryNumber = [0, 0];
    additionalmasonryNumber = [0, 0];
    tempMasonryNumber = [0, 0];
    masonryRate = [0, 0];
    masonryCost = 0;
    additionalmasonryCost = 0;

    reinforcedCementWorksNumber = [0, 0];
    additionalreinforcedCementWorksNumber = [0, 0];
    tempReinforcedCementWorksNumber = [0, 0];
    reinforcedCementWorksRate = [0, 0];
    reinforcedCementWorksCost = 0;
    additionalreinforcedCementWorksCost = 0;

    steelReinforcementWorksNumber = [0];
    additionalsteelReinforcementWorksNumber = [0];
    tempSteelReinforcementWorksNumber = [0];
    steelReinforcementWorksRate = [0];
    steelReinforcementWorksCost = 0;
    additionalsteelReinforcementWorksCost = 0;

//architectural
    flooringNumber = [0, 0];
    additionalflooringNumber = [0, 0];
    tempeFlooringNumber = [0, 0];
    flooringRate = [0, 0];
    flooringCost = 0;
    additionalflooringCost = 0;

    plasteringNumber = [0, 0];
    additionalplasteringNumber = [0, 0];
    tempPlasteringNumber = [0, 0];
    plasteringRate = [0, 0];
    plasteringCost = 0;
    additionalplasteringCost = 0;

    paintingWorksNumber = [0];
    additionalpaintingWorksNumber = [0];
    tempPaintingWorksNumber = [0];
    paintingWorksRate = [0];
    paintingWorksCost = 0;
    additionalpaintingWorksCost = 0;

    doorAndWindowsNumber = [0, 0];
    additionaldoorAndWindowsNumber = [0, 0];
    tempDoorAndWindowsNumber = [0, 0];
    doorAndWindowsRate = [0, 0];
    doorsAndWindowsCost = 0;
    additionaldoorsAndWindowsCost = 0;

    ceilingNumber = [0, 0];
    additionalceilingNumber = [0, 0];
    tempCeilingNumber = [0, 0];
    ceilingRate = [0, 0];
    ceilingCost = 0;
    additionalceilingCost = 0;

    roofingNumber = [0, 0, 0];
    additionalroofingNumber = [0, 0, 0];
    tempRoofingNumber = [0, 0, 0];
    roofingRate = [0, 0, 0];
    roofingCost = 0;
    additionalroofingCost = 0;

//electrical and plumbing
    electricalWorksNumber = [0, 0];
    additionalelectricalWorksNumber = [0, 0];
    tempElectricalWorksNumber = [0, 0];
    List<double> electricalWorksRate = [0, 0];
    electricalWorksCost = 0;
    additionalelectricalWorksCost = 0;

    plumbingNumber = [0, 0];
    additionalplumbingNumber = [0, 0];
    tempPlumbingNumber = [0, 0];
    List<double> plumbingRate = [0, 0];
    plumbingCost = 0;
    additionalplumbingCost = 0;

    //update default data
    if (allForms != null) {
      for (int x = 0; x < allForms!.length; x++) {
        if (allForms![x].work == 'Earthworks' &&
            allForms![x].date_end != null) {
          setState(() {
            earthworksNumber[0] += allForms![x].worker_1!;
            tempEarthworksNumber[0] = allForms![x].worker_1!;
          });
          earthworksCost += generateWorkerRate(
              allForms![x], earthWorks, earthworksRate, tempEarthworksNumber);
          tempEarthworksNumber = [0];
          additionalEarthworksCost += getAdditionals(
              allForms![x],
              allManpower![x],
              additionalEarthworksNumber,
              tempEarthworksNumber,
              earthWorks);
        } else if (allForms![x].work == 'Formworks' &&
            allForms![x].date_end != null) {
          setState(() {
            formworksNumber[0] += allForms![x].worker_1!;
            formworksNumber[1] += allForms![x].worker_2!;
            tempFormworksNumber[0] = allForms![x].worker_1!;
            tempFormworksNumber[1] = allForms![x].worker_2!;
          });
          formworksCost += generateWorkerRate(
              allForms![x], formworks, formworksRate, tempFormworksNumber);
          tempFormworksNumber = [0, 0];
          additionalformworksCost += getAdditionals(
              allForms![x],
              allManpower![x],
              additionalformworksNumber,
              tempFormworksNumber,
              formworks);
        } else if (allForms![x].work == 'Masonry Works' &&
            allForms![x].date_end != null) {
          setState(() {
            masonryNumber[0] += allForms![x].worker_1!;
            masonryNumber[1] += allForms![x].worker_2!;
            tempMasonryNumber[0] = allForms![x].worker_1!;
            tempMasonryNumber[1] = allForms![x].worker_2!;
          });
          masonryCost += generateWorkerRate(
              allForms![x], masonry, masonryRate, tempMasonryNumber);
          tempMasonryNumber = [0, 0];
        } else if (allForms![x].work == 'Reinforced Cement Works' &&
            allForms![x].date_end != null) {
          setState(() {
            reinforcedCementWorksNumber[0] += allForms![x].worker_1!;
            reinforcedCementWorksNumber[1] += allForms![x].worker_2!;
            tempReinforcedCementWorksNumber[0] = allForms![x].worker_1!;
            tempReinforcedCementWorksNumber[1] = allForms![x].worker_2!;
          });
          reinforcedCementWorksCost += generateWorkerRate(
              allForms![x],
              reinforcedCementWorks,
              reinforcedCementWorksRate,
              tempReinforcedCementWorksNumber);
          tempReinforcedCementWorksNumber = [0, 0];
          additionalreinforcedCementWorksCost += getAdditionals(
              allForms![x],
              allManpower![x],
              additionalreinforcedCementWorksNumber,
              tempReinforcedCementWorksNumber,
              reinforcedCementWorks);
        } else if (allForms![x].work == 'Steel Reinforcement Works' &&
            allForms![x].date_end != null) {
          setState(() {
            steelReinforcementWorksNumber[0] += allForms![x].worker_1!;
            tempSteelReinforcementWorksNumber[0] = allForms![x].worker_1!;
          });
          steelReinforcementWorksCost += generateWorkerRate(
              allForms![x],
              steelReinforcementWorks,
              steelReinforcementWorksRate,
              tempSteelReinforcementWorksNumber);
          tempSteelReinforcementWorksNumber = [0, 0];
          additionalsteelReinforcementWorksCost += getAdditionals(
              allForms![x],
              allManpower![x],
              additionalsteelReinforcementWorksNumber,
              tempSteelReinforcementWorksNumber,
              steelReinforcementWorks);
        } else if (allForms![x].work == 'Flooring' &&
            allForms![x].date_end != null) {
          setState(() {
            flooringNumber[0] += allForms![x].worker_1!;
            flooringNumber[1] += allForms![x].worker_2!;
            tempeFlooringNumber[0] = allForms![x].worker_1!;
            tempeFlooringNumber[1] = allForms![x].worker_2!;
          });
          flooringCost += generateWorkerRate(
              allForms![x], flooring, flooringRate, tempeFlooringNumber);
          tempeFlooringNumber = [0, 0];
          additionalflooringCost += getAdditionals(
              allForms![x],
              allManpower![x],
              additionalflooringNumber,
              tempeFlooringNumber,
              flooring);
        } else if (allForms![x].work == 'Plastering' &&
            allForms![x].date_end != null) {
          setState(() {
            plasteringNumber[0] += allForms![x].worker_1!;
            plasteringNumber[1] += allForms![x].worker_2!;
            tempPlasteringNumber[0] = allForms![x].worker_1!;
            tempPlasteringNumber[1] = allForms![x].worker_2!;
          });
          plasteringCost += generateWorkerRate(
              allForms![x], plastering, plasteringRate, tempPlasteringNumber);
          tempPlasteringNumber = [0, 0];
          additionalplasteringCost += getAdditionals(
              allForms![x],
              allManpower![x],
              additionalplasteringNumber,
              tempPlasteringNumber,
              plastering);
        } else if (allForms![x].work == 'Painting Works' &&
            allForms![x].date_end != null) {
          setState(() {
            paintingWorksNumber[0] += allForms![x].worker_1!;
            tempPaintingWorksNumber[0] = allForms![x].worker_1!;
          });
          paintingWorksCost += generateWorkerRate(allForms![x], paintingWorks,
              paintingWorksRate, tempPaintingWorksNumber);
          tempPaintingWorksNumber = [0];
          additionalpaintingWorksCost += getAdditionals(
              allForms![x],
              allManpower![x],
              additionalpaintingWorksNumber,
              tempPaintingWorksNumber,
              paintingWorks);
        } else if (allForms![x].work == 'Doors and Windows' &&
            allForms![x].date_end != null) {
          if (allForms![x].type == 'Windows') {
            setState(() {
              doorAndWindowsNumber[1] += allForms![x].worker_1!;
              tempDoorAndWindowsNumber[1] = allForms![x].worker_1!;
            });
          } else {
            doorAndWindowsNumber[0] += allForms![x].worker_1!;
            tempDoorAndWindowsNumber[0] = allForms![x].worker_1!;
          }
          doorsAndWindowsCost += generateWorkerRate(allForms![x],
              doorsAndWindows, doorAndWindowsRate, tempDoorAndWindowsNumber);
          tempDoorAndWindowsNumber = [0, 0];
          additionaldoorsAndWindowsCost += getAdditionals(
              allForms![x],
              allManpower![x],
              additionaldoorAndWindowsNumber,
              tempDoorAndWindowsNumber,
              doorsAndWindows);
        } else if (allForms![x].work == 'Ceiling' &&
            allForms![x].date_end != null) {
          setState(() {
            ceilingNumber[0] += allForms![x].worker_1!;
            ceilingNumber[1] += allForms![x].worker_2!;
            tempCeilingNumber[0] = allForms![x].worker_1!;
            tempCeilingNumber[1] = allForms![x].worker_2!;
          });
          ceilingCost += generateWorkerRate(
              allForms![x], ceiling, ceilingRate, tempCeilingNumber);
          tempCeilingNumber = [0, 0];
          additionalceilingCost += getAdditionals(allForms![x], allManpower![x],
              additionalceilingNumber, tempCeilingNumber, ceiling);
        } else if (allForms![x].work == 'Roofing Works' &&
            allForms![x].date_end != null) {
          if (allForms![x].type == 'Trusses') {
            setState(() {
              roofingNumber[1] += allForms![x].worker_1!;
              roofingNumber[2] += allForms![x].worker_2!;
              tempRoofingNumber[1] = allForms![x].worker_1!;
              tempRoofingNumber[2] = allForms![x].worker_2!;
            });
          } else {
            roofingNumber[0] += allForms![x].worker_1!;
            roofingNumber[2] += allForms![x].worker_2!;
            tempRoofingNumber[0] = allForms![x].worker_1!;
            tempRoofingNumber[2] = allForms![x].worker_2!;
          }
          roofingCost += generateWorkerRate(
              allForms![x], roofing, roofingRate, tempRoofingNumber);
          tempRoofingNumber = [0, 0, 0];
          additionalroofingCost += getAdditionals(allForms![x], allManpower![x],
              additionalroofingNumber, tempRoofingNumber, roofing);
        } else if (allForms![x].work == 'Electrical Works' &&
            allForms![x].date_end != null) {
          setState(() {
            electricalWorksNumber[0] += allForms![x].worker_1!;
            electricalWorksNumber[1] += allForms![x].worker_2!;
            tempElectricalWorksNumber[0] = allForms![x].worker_1!;
            tempElectricalWorksNumber[1] = allForms![x].worker_2!;
          });
          electricalWorksCost += generateWorkerRate(allForms![x],
              electricalWorks, electricalWorksRate, tempElectricalWorksNumber);
          tempElectricalWorksNumber = [0, 0];
          additionalelectricalWorksCost += getAdditionals(
              allForms![x],
              allManpower![x],
              additionalelectricalWorksNumber,
              tempElectricalWorksNumber,
              electricalWorks);
        } else if (allForms![x].work == 'Plumbing Works' &&
            allForms![x].date_end != null) {
          setState(() {
            plumbingNumber[0] += allForms![x].worker_1!;
            plumbingNumber[1] += allForms![x].worker_2!;
            tempPlumbingNumber[0] = allForms![x].worker_1!;
            tempPlumbingNumber[1] = allForms![x].worker_2!;
          });
          plumbingCost += generateWorkerRate(
              allForms![x], plumbing, plumbingRate, plumbingNumber);
          tempPlumbingNumber = [0, 0];
          additionalplumbingCost += getAdditionals(
              allForms![x],
              allManpower![x],
              additionalplumbingNumber,
              tempPlumbingNumber,
              plumbing);
        }
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          actions: [
            printpdfButton(
                plumbingNumber,
                additionalplumbingNumber,
                plumbingCost,
                additionalplumbingCost,
                earthworksNumber,
                earthworksCost,
                additionalEarthworksCost,
                additionalEarthworksNumber,
                formworksNumber,
                formworksCost,
                additionalformworksCost,
                additionalformworksNumber,
                masonryNumber,
                masonryCost,
                additionalmasonryCost,
                additionalmasonryNumber,
                reinforcedCementWorksNumber,
                reinforcedCementWorksCost,
                additionalreinforcedCementWorksCost,
                additionalreinforcedCementWorksNumber,
                steelReinforcementWorksNumber,
                steelReinforcementWorksCost,
                additionalsteelReinforcementWorksCost,
                additionalsteelReinforcementWorksNumber,
                flooringNumber,
                flooringCost,
                additionalflooringCost,
                additionalflooringNumber,
                plasteringNumber,
                plasteringCost,
                additionalplasteringCost,
                additionalplasteringNumber,
                paintingWorksNumber,
                paintingWorksCost,
                additionalpaintingWorksCost,
                additionalpaintingWorksNumber,
                doorAndWindowsNumber,
                doorsAndWindowsCost,
                additionaldoorsAndWindowsCost,
                additionaldoorAndWindowsNumber,
                ceilingNumber,
                ceilingCost,
                additionalceilingCost,
                additionalceilingNumber,
                roofingNumber,
                roofingCost,
                additionalroofingCost,
                additionalroofingNumber,
                electricalWorksNumber,
                electricalWorksCost,
                additionalelectricalWorksCost,
                additionalelectricalWorksNumber)
          ],
          leading: OpenDrawerWidget(
            onClicked: widget.openDrawer,
          ),
          title: const Text('Manpower Distribution'),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(children: [
                  //Structural
                  Container(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey.shade100
                        : Theme.of(context).appBarTheme.backgroundColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Checkbox(
                            checkColor: Colors.white,
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = !isChecked;
                              });
                              refreshState();
                            },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8, top: 8, right: 8),
                          child: Text(
                            'Additional Manpower',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey.shade100
                        : Theme.of(context).appBarTheme.backgroundColor,
                    child: Padding(
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
                  ),
                  tile(
                      'Earthworks',
                      earthWorks,
                      earthworksNumber,
                      earthworksCost,
                      Icons.landscape,
                      this.context,
                      additionalEarthworksCost,
                      additionalEarthworksNumber,
                      isChecked),
                  tile(
                      'Formworks',
                      formworks,
                      formworksNumber,
                      formworksCost,
                      Icons.house_siding_outlined,
                      this.context,
                      additionalformworksCost,
                      additionalformworksNumber,
                      isChecked),
                  tile(
                      'Masonry',
                      masonry,
                      masonryNumber,
                      masonryCost,
                      Icons.construction_rounded,
                      this.context,
                      additionalmasonryCost,
                      additionalmasonryNumber,
                      isChecked),
                  tile(
                      'Reinforced Cement Works',
                      reinforcedCementWorks,
                      reinforcedCementWorksNumber,
                      reinforcedCementWorksCost,
                      CustomIcons.cement_works,
                      this.context,
                      additionalreinforcedCementWorksCost,
                      additionalreinforcedCementWorksNumber,
                      isChecked),
                  tile(
                      'Steel Reinforcement Works',
                      steelReinforcementWorks,
                      steelReinforcementWorksNumber,
                      steelReinforcementWorksCost,
                      Icons.precision_manufacturing,
                      this.context,
                      additionalsteelReinforcementWorksCost,
                      additionalsteelReinforcementWorksNumber,
                      isChecked),

                  //architectural
                  Container(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey.shade100
                        : Theme.of(context).appBarTheme.backgroundColor,
                    child: Padding(
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
                  ),
                  tile(
                      'Flooring',
                      flooring,
                      flooringNumber,
                      flooringCost,
                      CustomIcons.flooring,
                      this.context,
                      additionalflooringCost,
                      additionalflooringNumber,
                      isChecked),
                  tile(
                      'Plastering',
                      plastering,
                      plasteringNumber,
                      plasteringCost,
                      CustomIcons.plastering,
                      this.context,
                      additionalplasteringCost,
                      additionalplasteringNumber,
                      isChecked),
                  tile(
                      'Painting Works',
                      paintingWorks,
                      paintingWorksNumber,
                      paintingWorksCost,
                      CustomIcons.painting,
                      this.context,
                      additionalpaintingWorksCost,
                      additionalpaintingWorksNumber,
                      isChecked),
                  tile(
                      'Doors and Windows',
                      doorsAndWindows,
                      doorAndWindowsNumber,
                      doorsAndWindowsCost,
                      CustomIcons.doors,
                      this.context,
                      additionaldoorsAndWindowsCost,
                      additionaldoorAndWindowsNumber,
                      isChecked),
                  tile(
                      'Ceiling',
                      ceiling,
                      ceilingNumber,
                      ceilingCost,
                      CustomIcons.ceiling,
                      this.context,
                      additionalceilingCost,
                      additionalceilingNumber,
                      isChecked),
                  tile(
                      'Roofing',
                      roofing,
                      roofingNumber,
                      roofingCost,
                      CustomIcons.roofing,
                      this.context,
                      additionalroofingCost,
                      additionalroofingNumber,
                      isChecked),

                  //architectural
                  Container(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey.shade100
                        : Theme.of(context).appBarTheme.backgroundColor,
                    child: Padding(
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
                  ),
                  tile(
                      'Electrical Works',
                      electricalWorks,
                      electricalWorksNumber,
                      electricalWorksCost,
                      CustomIcons.electrical,
                      this.context,
                      additionalelectricalWorksCost,
                      additionalelectricalWorksNumber,
                      isChecked),
                  tile(
                      'Plumbing',
                      plumbing,
                      plumbingNumber,
                      plumbingCost,
                      CustomIcons.plumbing,
                      this.context,
                      additionalplumbingCost,
                      additionalplumbingNumber,
                      isChecked),
                ]),
              )

        //********************************************************* */
        //code below for backup don't delete
        //********************************************************* */

        // SafeArea(
        //     child: SingleChildScrollView(
        //   child: Row(
        //     children: [
        //       FixedColumnWidget(),
        //       ScrollableColumnWidget(),
        //     ],
        //   ),
        // )),
        );
  }

  double generateWorkerRate(FormData form, List<String> workerLabel,
      List<double> rate, List<int> number) {
    double totalCost = 0;
    for (int x = 0; x < workerLabel.length; x++) {
      for (int y = 0; y < allWorkers!.length; y++) {
        if (allWorkers![y].workerType == workerLabel[x].toUpperCase()) {
          setState(() {
            rate[x] = (allWorkers![y].rate * form.num_days!) * number[x];
            totalCost += rate[x];
          });
        }
      }
    }
    return totalCost;
  }
  // double getAdditionals(FormData formData, AdditionalManpower manpower, List<int> numbers){
  //   double additinalCost = 0;
  //   double _additionalManpower = 0;
  //   double decimalValue = 0;
  //   _additionalManpower = (formData.num_workers! * manpower.totalPercentage);
  //   decimalValue = _additionalManpower - _additionalManpower.toInt();
  //     if (decimalValue <= 0.09) {
  //       setState(() {
  //         _additionalManpower = (_additionalManpower.floor()).toDouble();
  //       });
  //     } else {
  //       setState(() {
  //         _additionalManpower = (_additionalManpower.ceil()).toDouble();
  //       });
  //     }
  //   return additinalCost;
  // }

  double getAdditionals(FormData formData, AdditionalManpower manpower,
      List<int> numbers, List<int> tempNumbers, List<String> workerLabel) {
    double totalCost = 0;

    double additionalManpowerW1 = 0;
    double additionalManpowerW2 = 0;
    double decimalValue = 0;
    double decimalValue2 = 0;
    double tempRate = 0;

    additionalManpowerW1 = (formData.worker_1! * manpower.totalPercentage);
    decimalValue = additionalManpowerW1 - additionalManpowerW1.toInt();
    if (decimalValue <= 0.09) {
      additionalManpowerW1 = (additionalManpowerW1.floor()).toDouble();
    } else {
      additionalManpowerW1 = (additionalManpowerW1.ceil()).toDouble();
    }
    //twoWorkers
    if (formData.worker_2 != null) {
      additionalManpowerW2 = (formData.worker_2! * manpower.totalPercentage);
      decimalValue2 = additionalManpowerW2 - additionalManpowerW2.toInt();
      if (decimalValue2 <= 0.09) {
        additionalManpowerW2 = (additionalManpowerW2.floor()).toDouble();
      } else {
        additionalManpowerW2 = (additionalManpowerW2.ceil()).toDouble();
      }
    }

    switch (formData.type) {
      case "Trusses":
        setState(() {
          numbers[1] += additionalManpowerW1.toInt();
          tempNumbers[1] = additionalManpowerW1.toInt();
          numbers[2] += additionalManpowerW2.toInt();
          tempNumbers[2] = additionalManpowerW2.toInt();
        });
        break;
      case "GI Sheets":
      case "Gutter":
        setState(() {
          numbers[0] += additionalManpowerW1.toInt();
          tempNumbers[0] = additionalManpowerW1.toInt();
          numbers[2] += additionalManpowerW2.toInt();
          tempNumbers[2] = additionalManpowerW2.toInt();
        });
        break;
      default:
        setState(() {
          numbers[0] += additionalManpowerW1.toInt();
          tempNumbers[0] = additionalManpowerW1.toInt();
        });
        if (formData.worker_2 != null) {
          setState(() {
            numbers[1] += additionalManpowerW2.toInt();
            tempNumbers[1] = additionalManpowerW2.toInt();
          });
        }
        break;
    }

    for (int x = 0; x < workerLabel.length; x++) {
      for (int y = 0; y < allWorkers!.length; y++) {
        if (allWorkers![y].workerType == workerLabel[x].toUpperCase()) {
          setState(() {
            tempRate =
                (allWorkers![y].rate * formData.num_days!) * tempNumbers[x];
            totalCost += tempRate;
            tempRate = 0;
          });
        }
      }
    }

    return totalCost;
  }

  Widget tile(
          String title,
          List<String> workers,
          List<int> numbers,
          double cost,
          IconData icon,
          BuildContext context,
          double additionalCost,
          List<int> additionalNumbers,
          bool isChecked) =>
      Column(
        children: [
          Container(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.grey.shade300
                : Colors.grey.shade700,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.20,
                      child: Container(
                        margin: const EdgeInsets.only(left: 7),
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.20,
                      child: Center(
                          child: Text(
                        workers[0],
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ))),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.20,
                      child: Center(
                          child: Text(
                        workers.length > 1 ? workers[1] : '',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ))),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.20,
                      child: Center(
                          child: Text(workers.length > 2 ? workers[2] : '',
                              textAlign: TextAlign.center))),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.20,
                      child: const Center(
                          child: Text('Total Cost',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center))),
                ],
              ),
            ),
          ),
          Container(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.grey.shade100
                : Theme.of(context).appBarTheme.backgroundColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.20,
                      child: Center(child: Icon(icon))),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.20,
                      child: Center(
                          child: Text(
                              numbers[0].toString() +
                                  (isChecked
                                      ? additionalNumbers[0] == 0
                                          ? ''
                                          : ' + ' +
                                              additionalNumbers[0].toString()
                                      : ''),
                              textAlign: TextAlign.center))),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.20,
                      child: Center(
                          child: Text(
                              numbers.length > 1
                                  ? numbers[1].toString() +
                                      (isChecked
                                          ? additionalNumbers[1] == 0
                                              ? ''
                                              : ' + ' +
                                                  additionalNumbers[1]
                                                      .toString()
                                          : '')
                                  : '',
                              textAlign: TextAlign.center))),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.20,
                      child: Center(
                          child: Text(
                              numbers.length > 2
                                  ? numbers[2].toString() +
                                      (isChecked
                                          ? additionalNumbers[2] == 0
                                              ? ''
                                              : ' + ' +
                                                  additionalNumbers[2]
                                                      .toString()
                                          : '')
                                  : '',
                              textAlign: TextAlign.center))),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.20,
                      child: Center(
                          child: Text(
                              cost.toString() +
                                  (isChecked
                                      ? additionalCost == 0
                                          ? ''
                                          : ' + ' + additionalCost.toString()
                                      : ''),
                              textAlign: TextAlign.center)))
                ],
              ),
            ),
          )
          // Text(numbers[0].toString()),
        ],
      );
  Future<void> _createPDF(
      List<int> plumbingNumber,
      List<int> additionalplumbingNumber,
      double plumbingCost,
      double additionalplumbingCost,
      List<int> earthworksNumber,
      double earthworksCost,
      double additionalEarthworksCost,
      List<int> additionalEarthworksNumber,
      List<int> formworksNumber,
      double formworksCost,
      double additionalformworksCost,
      List<int> additionalformworksNumber,
      List<int> masonryNumber,
      double masonryCost,
      double additionalmasonryCost,
      List<int> additionalmasonryNumber,
      List<int> reinforcedCementWorksNumber,
      double reinforcedCementWorksCost,
      double additionalreinforcedCementWorksCost,
      List<int> additionalreinforcedCementWorksNumber,
      List<int> steelReinforcementWorksNumber,
      double steelReinforcementWorksCost,
      double additionalsteelReinforcementWorksCost,
      List<int> additionalsteelReinforcementWorksNumber,
      List<int> flooringNumber,
      double flooringCost,
      double additionalflooringCost,
      List<int> additionalflooringNumber,
      List<int> plasteringNumber,
      double plasteringCost,
      double additionalplasteringCost,
      List<int> additionalplasteringNumber,
      List<int> paintingWorksNumber,
      double paintingWorksCost,
      double additionalpaintingWorksCost,
      List<int> additionalpaintingWorksNumber,
      List<int> doorAndWindowsNumber,
      double doorsAndWindowsCost,
      double additionaldoorsAndWindowsCost,
      List<int> additionaldoorAndWindowsNumber,
      List<int> ceilingNumber,
      double ceilingCost,
      double additionalceilingCost,
      List<int> additionalceilingNumber,
      List<int> roofingNumber,
      double roofingCost,
      double additionalroofingCost,
      List<int> additionalroofingNumber,
      List<int> electricalWorksNumber,
      double electricalWorksCost,
      double additionalelectricalWorksCost,
      List<int> additionalelectricalWorksNumber) async {
    //Creates a new PDF document
    PdfDocument document = PdfDocument();

//Adds page settings
    document.pageSettings.orientation = PdfPageOrientation.landscape;
    document.pageSettings.margins.all = 40;

//Adds a page to the document
    PdfPage page = document.pages.add();
    PdfGraphics graphics = page.graphics;

    PdfBrush solidBrush = PdfSolidBrush(PdfColor(126, 151, 173));
    Rect bounds = Rect.fromLTWH(0, 0, graphics.clientSize.width, 30);

//Draws a rectangle to place the heading in that region
    graphics.drawRectangle(brush: solidBrush, bounds: bounds);

//Creates a font for adding the heading in the page
    PdfFont subHeadingFont = PdfStandardFont(PdfFontFamily.timesRoman, 14);

//Creates a text element to add the invoice number
    PdfTextElement element =
        PdfTextElement(text: 'Manpower Distribution', font: subHeadingFont);
    element.brush = PdfBrushes.white;

//Draws the heading on the page
    PdfLayoutResult result = element.draw(
        page: page, bounds: Rect.fromLTWH(300, bounds.top + 8, 0, 0))!;

//Creates text elements to add the address and draw it to the page
    //Creates a PDF grid
    PdfGrid grid = PdfGrid();

//Add the columns to the grid
    grid.columns.add(count: 5);

//Add header to the grid
    grid.headers.add(1);

    PdfGridRow header = grid.headers[0];
    header.cells[0].value = 'Work Type';
    header.cells[1].value = 'Workers';
    header.cells[2].value = '';
    header.cells[3].value = '';
    header.cells[4].value = 'Total Cost';

    //Creates the header style
    PdfGridCellStyle headerStyle = PdfGridCellStyle();
    headerStyle.borders.all = PdfPen(PdfColor(126, 151, 173));
    headerStyle.backgroundBrush = PdfSolidBrush(PdfColor(126, 151, 173));
    headerStyle.textBrush = PdfBrushes.white;
    headerStyle.font = PdfStandardFont(PdfFontFamily.timesRoman, 14,
        style: PdfFontStyle.regular);

//Adds cell customizations
    for (int i = 0; i < header.cells.count; i++) {
      if (i == 0 || i == 1) {
        header.cells[i].stringFormat = PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle);
      } else {
        header.cells[i].stringFormat = PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle);
      }
      header.cells[i].style = headerStyle;
    }
    var temp = '';
//Add rows to grid

    PdfGridRow row = grid.rows.add();
//1st Earthworks
    row = grid.rows.add();
    row.cells[0].value = 'Earthworks';
    row.cells[1].value = 'Laborer: ' +
        earthworksNumber[0].toString() +
        add(additionalEarthworksNumber[0]);
    row.cells[2].value = '--';
    row.cells[3].value = '--';
    row.cells[4].value =
        earthworksCost.toString() + cost(additionalEarthworksCost);
//2nd Formworks
    row = grid.rows.add();
    row.cells[0].value = 'Formworks';
    row.cells[1].value = 'Carpenter: ' +
        formworksNumber[0].toString() +
        add(additionalformworksNumber[0]);
    row.cells[2].value = 'Laborer: ' +
        formworksNumber[1].toString() +
        add(additionalformworksNumber[1]);
    row.cells[3].value = '--';
    row.cells[4].value =
        formworksCost.toString() + cost(additionalformworksCost);
//3rd Masonry
    row = grid.rows.add();
    row.cells[0].value = 'Masonry';
    row.cells[1].value = 'Tile Man: ' +
        masonryNumber[0].toString() +
        add(additionalmasonryNumber[0]);
    row.cells[2].value = 'Laborer: ' +
        masonryNumber[1].toString() +
        add(additionalmasonryNumber[1]);
    row.cells[3].value = '--';
    row.cells[4].value = masonryCost.toString() + cost(additionalmasonryCost);
//4th Reinforced Cement
    row = grid.rows.add();
    row.cells[0].value = 'Reinforced Cement Works';
    row.cells[1].value = 'Mason: ' +
        reinforcedCementWorksNumber[0].toString() +
        add(additionalreinforcedCementWorksNumber[0]);
    row.cells[2].value = 'Laborer: ' +
        reinforcedCementWorksNumber[1].toString() +
        add(additionalreinforcedCementWorksNumber[1]);
    row.cells[3].value = '--';
    row.cells[4].value = reinforcedCementWorksCost.toString() +
        cost(additionalreinforcedCementWorksCost);

//5th Steel Reinforcement
    row = grid.rows.add();
    row.cells[0].value = 'Steel Reinforcement Works';
    row.cells[1].value = 'Steel Man: ' +
        steelReinforcementWorksNumber[0].toString() +
        add(additionalsteelReinforcementWorksNumber[0]);
    row.cells[2].value = '--';
    row.cells[3].value = '--';
    row.cells[4].value = steelReinforcementWorksCost.toString() +
        cost(additionalsteelReinforcementWorksCost);

//6th Flooring
    row = grid.rows.add();
    row.cells[0].value = 'Flooring';
    row.cells[1].value = 'Tile Man: ' +
        flooringNumber[0].toString() +
        add(additionalflooringNumber[0]);
    row.cells[2].value = 'Laborer: ' +
        flooringNumber[1].toString() +
        add(additionalflooringNumber[1]);
    row.cells[3].value = '--';
    row.cells[4].value = flooringCost.toString() + cost(additionalflooringCost);

//7th Plastering

    row = grid.rows.add();
    row.cells[0].value = 'Plastering';
    row.cells[1].value = 'Mason: ' +
        plasteringNumber[0].toString() +
        add(additionalplasteringNumber[0]);
    row.cells[2].value = 'Laborer: ' +
        plasteringNumber[1].toString() +
        add(additionalplasteringNumber[1]);
    row.cells[3].value = '--';
    row.cells[4].value =
        plasteringCost.toString() + cost(additionalplasteringCost);

//8th Painting Works

    row = grid.rows.add();
    row.cells[0].value = 'Painting Works';
    row.cells[1].value = 'Painter: ' +
        paintingWorksNumber[0].toString() +
        add(additionalpaintingWorksNumber[0]);
    row.cells[2].value = '--';
    row.cells[3].value = '--';
    row.cells[4].value =
        paintingWorksCost.toString() + cost(additionalpaintingWorksCost);

//9th Doors and Windows
    row = grid.rows.add();
    row.cells[0].value = 'Doors and Windows';
    row.cells[1].value = 'Doors: ' +
        doorAndWindowsNumber[0].toString() +
        add(additionaldoorAndWindowsNumber[0]);
    row.cells[2].value = 'Windows: ' +
        doorAndWindowsNumber[1].toString() +
        add(additionaldoorAndWindowsNumber[1]);
    row.cells[3].value = '--';
    row.cells[4].value =
        doorsAndWindowsCost.toString() + cost(additionaldoorsAndWindowsCost);
//10th Ceiling
    row = grid.rows.add();
    row.cells[0].value = 'Ceiling';
    row.cells[1].value = 'Carpenter: ' +
        ceilingNumber[0].toString() +
        add(additionalceilingNumber[0]);
    row.cells[2].value = 'Laborer: ' +
        ceilingNumber[1].toString() +
        add(additionalceilingNumber[1]);
    row.cells[3].value = '--';
    row.cells[4].value = ceilingCost.toString() + cost(additionalceilingCost);

//11th Roofing
    row = grid.rows.add();
    row.cells[0].value = 'Roofing';
    row.cells[1].value = 'Tinsmith: ' +
        roofingNumber[0].toString() +
        add(additionalroofingNumber[0]);
    row.cells[2].value = 'Welder: ' +
        roofingNumber[1].toString() +
        add(additionalroofingNumber[1]);
    row.cells[3].value = 'Laborer: ' +
        roofingNumber[2].toString() +
        add(additionalroofingNumber[2]);
    row.cells[4].value = roofingCost.toString() + cost(additionalroofingCost);

//12th Electrical
    row = grid.rows.add();
    row.cells[0].value = 'Electrical';
    row.cells[1].value = 'Electrician: ' +
        electricalWorksNumber[0].toString() +
        add(additionalelectricalWorksNumber[0]);
    row.cells[2].value = 'Laborer: ' +
        electricalWorksNumber[1].toString() +
        add(additionalelectricalWorksNumber[1]);
    row.cells[3].value = '--';
    row.cells[4].value =
        electricalWorksCost.toString() + cost(additionalelectricalWorksCost);

//last
    row = grid.rows.add();
    row.cells[0].value = 'Plumbing';
    row.cells[1].value = 'Plumber: ' +
        plumbingNumber[0].toString() +
        add(additionalplumbingNumber[0]);
    row.cells[2].value = 'Laborer: ' +
        plumbingNumber[1].toString() +
        add(additionalplumbingNumber[1]);
    row.cells[3].value = '--';
    row.cells[4].value = plumbingCost.toString() + cost(additionalplumbingCost);

    //Set padding for grid cells
    grid.style.cellPadding = PdfPaddings(left: 2, right: 2, top: 2, bottom: 2);

//Creates the grid cell styles
    PdfGridCellStyle cellStyle = PdfGridCellStyle();
    cellStyle.borders.all = PdfPens.lightBlue;
    cellStyle.borders.bottom = PdfPens.lightBlue;
    cellStyle.font = PdfStandardFont(PdfFontFamily.timesRoman, 14);
    cellStyle.textBrush = PdfSolidBrush(PdfColor(131, 130, 136));
//Adds cell customizations
    for (int i = 0; i < grid.rows.count; i++) {
      PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        row.cells[j].style = cellStyle;
        if (j == 0 || j == 1) {
          row.cells[j].stringFormat = PdfStringFormat(
              alignment: PdfTextAlignment.center,
              lineAlignment: PdfVerticalAlignment.middle);
        } else {
          row.cells[j].stringFormat = PdfStringFormat(
              alignment: PdfTextAlignment.center,
              lineAlignment: PdfVerticalAlignment.middle);
        }
      }
    }

//Creates layout format settings to allow the table pagination
    PdfLayoutFormat layoutFormat =
        PdfLayoutFormat(layoutType: PdfLayoutType.paginate);

//Draws the grid to the PDF page
    PdfLayoutResult gridResult = grid.draw(
        page: page,
        bounds: Rect.fromLTWH(0, result.bounds.bottom + 10,
            graphics.clientSize.width, graphics.clientSize.height - 100),
        format: layoutFormat)!;

    List<int> bytes = document.save();
    document.dispose();

    saveAndLaunchFile(bytes, 'Output.pdf');
  }

  Widget printpdfButton(
          List<int> plumbingNumber,
          List<int> additionalplumbingNumber,
          double plumbingCost,
          double additionalplumbingCost,
          List<int> earthworksNumber,
          double earthworksCost,
          double additionalEarthworksCost,
          List<int> additionalEarthworksNumber,
          List<int> formworksNumber,
          double formworksCost,
          double additionalformworksCost,
          List<int> additionalformworksNumber,
          List<int> masonryNumber,
          double masonryCost,
          double additionalmasonryCost,
          List<int> additionalmasonryNumber,
          List<int> reinforcedCementWorksNumber,
          double reinforcedCementWorksCost,
          double additionalreinforcedCementWorksCost,
          List<int> additionalreinforcedCementWorksNumber,
          List<int> steelReinforcementWorksNumber,
          double steelReinforcementWorksCost,
          double additionalsteelReinforcementWorksCost,
          List<int> additionalsteelReinforcementWorksNumber,
          List<int> flooringNumber,
          double flooringCost,
          double additionalflooringCost,
          List<int> additionalflooringNumber,
          List<int> plasteringNumber,
          double plasteringCost,
          double additionalplasteringCost,
          List<int> additionalplasteringNumber,
          List<int> paintingWorksNumber,
          double paintingWorksCost,
          double additionalpaintingWorksCost,
          List<int> additionalpaintingWorksNumber,
          List<int> doorAndWindowsNumber,
          double doorsAndWindowsCost,
          double additionaldoorsAndWindowsCost,
          List<int> additionaldoorAndWindowsNumber,
          List<int> ceilingNumber,
          double ceilingCost,
          double additionalceilingCost,
          List<int> additionalceilingNumber,
          List<int> roofingNumber,
          double roofingCost,
          double additionalroofingCost,
          List<int> additionalroofingNumber,
          List<int> electricalWorksNumber,
          double electricalWorksCost,
          double additionalelectricalWorksCost,
          List<int> additionalelectricalWorksNumber) =>
      ElevatedButton(
        child: const Text('Create PDF'),
        onPressed: () {
          _createPDF(
            plumbingNumber,
            additionalplumbingNumber,
            plumbingCost,
            additionalplumbingCost,
            earthworksNumber,
            earthworksCost,
            additionalEarthworksCost,
            additionalEarthworksNumber,
            formworksNumber,
            formworksCost,
            additionalformworksCost,
            additionalformworksNumber,
            masonryNumber,
            masonryCost,
            additionalmasonryCost,
            additionalmasonryNumber,
            reinforcedCementWorksNumber,
            reinforcedCementWorksCost,
            additionalreinforcedCementWorksCost,
            additionalreinforcedCementWorksNumber,
            steelReinforcementWorksNumber,
            steelReinforcementWorksCost,
            additionalsteelReinforcementWorksCost,
            additionalsteelReinforcementWorksNumber,
            flooringNumber,
            flooringCost,
            additionalflooringCost,
            additionalflooringNumber,
            plasteringNumber,
            plasteringCost,
            additionalplasteringCost,
            additionalplasteringNumber,
            paintingWorksNumber,
            paintingWorksCost,
            additionalpaintingWorksCost,
            additionalpaintingWorksNumber,
            doorAndWindowsNumber,
            doorsAndWindowsCost,
            additionaldoorsAndWindowsCost,
            additionaldoorAndWindowsNumber,
            ceilingNumber,
            ceilingCost,
            additionalceilingCost,
            additionalceilingNumber,
            roofingNumber,
            roofingCost,
            additionalroofingCost,
            additionalroofingNumber,
            electricalWorksNumber,
            electricalWorksCost,
            additionalelectricalWorksCost,
            additionalelectricalWorksNumber,
          );
        },
      );

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}

String add(int num) {
  var temp = '';
  if (num == 0) {
    temp = '';
  } else {
    temp = ' + ' + num.toString();
  }
  return temp;
}

String cost(double num) {
  var temp = '';
  if (num == 0) {
    temp = '';
  } else {
    temp = ' + ' + num.toString();
  }
  return temp;
}
