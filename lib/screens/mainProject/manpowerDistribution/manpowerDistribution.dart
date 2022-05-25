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
import 'mobile.dart';

class ManpowerDistribution extends StatefulWidget {
  final VoidCallback openDrawer;
  final ProjectItem project;

  const ManpowerDistribution({Key? key, required this.openDrawer, required this.project})
      : super(key: key);

  @override
  _ManpowerDistributionState createState() => _ManpowerDistributionState();
}

class _ManpowerDistributionState extends State<ManpowerDistribution> {

  
  //database
  List<FormData>? allForms;
  List<WorkerType>? allWorkers;
  List<AdditionalManpower>? allManpower;
  bool isLoading = false;

  
//tile data defaults
//structural
  List<String> earthWorks = ['Laborer'];
  List<int> earthworksNumber = [0];
  List<int> tempEarthworksNumber = [0];

//List<int> addtionalNumber = [0];

  List<double> earthworksRate = [0];
  double earthworksCost = 0;

double AdditionalEarthworksCost = 0;

  List<String> formworks = ['Carpenter', 'Laborer'];
  List<int> formworksNumber = [0,0];
  List<int> tempFormworksNumber = [0,0];
  List<double> formworksRate = [0,0];
  double formworksCost = 0;
  
  List<String> masonry = ['Tile Man', 'Laborer'];
  List<int> masonryNumber = [0,0];
  List<int> tempMasonryNumber = [0,0];
  List<double> masonryRate = [0,0];
  double masonryCost = 0;

  List<String> reinforcedCementWorks = ['Mason', 'Laborer'];
  List<int> reinforcedCementWorksNumber = [0,0];
  List<int> tempReinforcedCementWorksNumber = [0,0];
  List<double> reinforcedCementWorksRate = [0,0];
  double reinforcedCementWorksCost = 0;

  List<String> steelReinforcementWorks = ['Steel Man'];
  List<int> steelReinforcementWorksNumber = [0];
  List<int> tempSteelReinforcementWorksNumber = [0];
  List<double> steelReinforcementWorksRate = [0];
  double steelReinforcementWorksCost = 0;

//architectural
  List<String> flooring = ['Tileman', 'Laborer'];
  List<int> flooringNumber = [0,0];
  List<int> tempeFlooringNumber = [0,0];
  List<double> flooringRate = [0,0];
  double flooringCost = 0;

  List<String> plastering = ['Mason', 'Laborer'];
  List<int> plasteringNumber = [0,0];
  List<int> tempPlasteringNumber = [0,0];
  List<double> plasteringRate = [0,0];
  double plasteringCost = 0;

  List<String> paintingWorks = ['Painter'];
  List<int> paintingWorksNumber = [0];
  List<int> tempPaintingWorksNumber = [0];
  List<double> paintingWorksRate = [0];
  double paintingWorksCost = 0;

  List<String> doorsAndWindows = ['Door Installer', 'Window Installer'];
  List<int> doorAndWindowsNumber = [0,0];
  List<int> tempDoorAndWindowsNumber = [0,0];
  List<double> doorAndWindowsRate = [0,0];
  double doorsAndWindowsCost = 0;

  List<String> ceiling = ['Carpenter', 'Laborer'];
  List<int> ceilingNumber = [0,0];
  List<int> tempCeilingNumber = [0,0];
  List<double> ceilingRate = [0,0];
  double ceilingCost = 0;

  List<String> roofing = ['Tinsmith','Welder', 'Laborer'];
  List<int> roofingNumber = [0,0,0];
  List<int> tempRoofingNumber = [0,0,0];
  List<double> roofingRate = [0,0,0];
  double roofingCost = 0;


//electrical and plumbing
  List<String> electricalWorks = ['Electrician', 'Laborer'];
  List<int> electricalWorksNumber = [0,0];
  List<int> tempElectricalWorksNumber = [0,0];
  List<double> electricalWorksRate = [0,0];
  double electricalWorksCost = 0;

  List<String> plumbing = ['Plumber', 'Laborer'];
  List<int> plumbingNumber = [0,0];
  List<int> tempPlumbingNumber = [0,0];
  List<double> plumbingRate = [0,0];
  double plumbingCost = 0;

  @override
  void initState() {
    super.initState();
    refreshState();
  }

  Future refreshState() async {
    setState(() {isLoading = true;});
    allForms = await DatabaseHelper.instance.readAllFormData(widget.project.id!);
    allWorkers = await DatabaseHelper.instance.readWorkers(widget.project.id!);
    allManpower = await DatabaseHelper.instance.readAddtlManpower(widget.project.id!);

    //update default data
    if(allForms != null){
      for(int x = 0; x < allForms!.length; x++){
          if(allForms![x].work == 'Earthworks' && allForms![x].date_end != null){
          setState(() {
            earthworksNumber[0] += allForms![x].worker_1!;
            tempEarthworksNumber[0] = allForms![x].worker_1!;
          });
          earthworksCost += generateWorkerRate(allForms![x], earthWorks, earthworksRate, tempEarthworksNumber);
          tempEarthworksNumber = [0];
        }else if(allForms![x].work == 'Formworks' && allForms![x].date_end != null){
          setState(() {
            formworksNumber[0] += allForms![x].worker_1!;
            formworksNumber[1] += allForms![x].worker_2!;            
            tempFormworksNumber[0] = allForms![x].worker_1!;
            tempFormworksNumber[1] = allForms![x].worker_2!;            
          });
          formworksCost += generateWorkerRate(allForms![x], formworks, formworksRate, tempFormworksNumber);
          tempFormworksNumber = [0,0];
        }else if(allForms![x].work == 'Masonry Works' && allForms![x].date_end != null){
          setState(() {
            masonryNumber[0] += allForms![x].worker_1!;
            masonryNumber[1] += allForms![x].worker_2!;            
            tempMasonryNumber[0] = allForms![x].worker_1!;
            tempMasonryNumber[1] = allForms![x].worker_2!;                        
          });
          masonryCost += generateWorkerRate(allForms![x], masonry, masonryRate, tempMasonryNumber);
          tempMasonryNumber = [0,0];          
        }else if(allForms![x].work == 'Reinforced Cement Works' && allForms![x].date_end != null){
          setState(() {
            reinforcedCementWorksNumber[0] += allForms![x].worker_1!;
            reinforcedCementWorksNumber[1] += allForms![x].worker_2!;            
            tempReinforcedCementWorksNumber[0] = allForms![x].worker_1!;
            tempReinforcedCementWorksNumber[1] = allForms![x].worker_2!;                        
          });
          reinforcedCementWorksCost += generateWorkerRate(allForms![x], reinforcedCementWorks, reinforcedCementWorksRate, tempReinforcedCementWorksNumber);
          tempReinforcedCementWorksNumber = [0,0];
        }else if(allForms![x].work == 'Steel Reinforcement Works' && allForms![x].date_end != null){
          setState(() {
            steelReinforcementWorksNumber[0] += allForms![x].worker_1!;
            tempSteelReinforcementWorksNumber[0] = allForms![x].worker_1!;     
          });
          steelReinforcementWorksCost += generateWorkerRate(allForms![x], steelReinforcementWorks,steelReinforcementWorksRate,tempSteelReinforcementWorksNumber);
          tempSteelReinforcementWorksNumber = [0,0];
        }else if(allForms![x].work == 'Flooring' && allForms![x].date_end != null){
          setState(() {
            flooringNumber[0] += allForms![x].worker_1!;
            flooringNumber[1] += allForms![x].worker_2!;                 
            tempeFlooringNumber [0] = allForms![x].worker_1!;
            tempeFlooringNumber[1] = allForms![x].worker_2!;                             
          });
          flooringCost += generateWorkerRate(allForms![x], flooring, flooringRate, tempeFlooringNumber);
          tempeFlooringNumber = [0,0];
        }else if(allForms![x].work == 'Plastering' && allForms![x].date_end != null){
          setState(() {
            plasteringNumber[0] += allForms![x].worker_1!;
            plasteringNumber[1] += allForms![x].worker_2!;                 
            tempPlasteringNumber[0] = allForms![x].worker_1!;
            tempPlasteringNumber[1] = allForms![x].worker_2!;                             
          });
          plasteringCost += generateWorkerRate(allForms![x], plastering, plasteringRate, tempPlasteringNumber);
          tempPlasteringNumber = [0,0];
        }else if(allForms![x].work == 'Painting Works' && allForms![x].date_end != null){
          setState(() {
            paintingWorksNumber[0] += allForms![x].worker_1!;               
            tempPaintingWorksNumber[0] = allForms![x].worker_1!;                           
          });
          paintingWorksCost += generateWorkerRate(allForms![x], paintingWorks, paintingWorksRate, tempPaintingWorksNumber);
          tempPaintingWorksNumber = [0];
        }else if(allForms![x].work == 'Doors and Windows' && allForms![x].date_end != null){
          if(allForms![x].type == 'Windows'){
          setState(() {
            doorAndWindowsNumber[1] += allForms![x].worker_1!;    
            tempDoorAndWindowsNumber[1] = allForms![x].worker_1!;                             
          });
          }else{
            doorAndWindowsNumber[0] += allForms![x].worker_1!;
            tempDoorAndWindowsNumber[0] = allForms![x].worker_1!;            
          }
          doorsAndWindowsCost += generateWorkerRate(allForms![x], doorsAndWindows, doorAndWindowsRate , tempDoorAndWindowsNumber);
          tempDoorAndWindowsNumber = [0,0];
        }else if(allForms![x].work == 'Ceiling' && allForms![x].date_end != null){
          setState(() {
            ceilingNumber[0] += allForms![x].worker_1!;
            ceilingNumber[1] += allForms![x].worker_2!;                 
            tempCeilingNumber[0] = allForms![x].worker_1!;
            tempCeilingNumber[1] = allForms![x].worker_2!;                             
          });
          ceilingCost += generateWorkerRate(allForms![x], ceiling, ceilingRate, tempCeilingNumber);
          tempCeilingNumber = [0,0];
        }else if(allForms![x].work == 'Roofing Works' && allForms![x].date_end != null){
          if(allForms![x].type == 'Trusses'){
          setState(() {
            roofingNumber[1] += allForms![x].worker_1!;
            roofingNumber[2] += allForms![x].worker_2!;  
            tempRoofingNumber[1] = allForms![x].worker_1!;
            tempRoofingNumber[2] = allForms![x].worker_2!;                                       
          });          
          }else{
            roofingNumber[0] += allForms![x].worker_1!;
            roofingNumber[2] += allForms![x].worker_2!;            
            tempRoofingNumber[0] = allForms![x].worker_1!;
            tempRoofingNumber[2] = allForms![x].worker_2!;
          }
          roofingCost += generateWorkerRate(allForms![x], roofing, roofingRate, tempRoofingNumber);
          tempRoofingNumber = [0,0,0];
        }else if(allForms![x].work == 'Electrical Works' && allForms![x].date_end != null){
          setState(() {
            electricalWorksNumber[0] += allForms![x].worker_1!;
            electricalWorksNumber[1] += allForms![x].worker_2!;                 
            tempElectricalWorksNumber[0] = allForms![x].worker_1!;
            tempElectricalWorksNumber[1] = allForms![x].worker_2!;                             
          });
          electricalWorksCost += generateWorkerRate(allForms![x], electricalWorks, electricalWorksRate, tempElectricalWorksNumber);
          tempElectricalWorksNumber = [0,0];
        }else if(allForms![x].work == 'Plumbing Works' && allForms![x].date_end != null){
          setState(() {
            plumbingNumber[0] += allForms![x].worker_1!;
            plumbingNumber[1] += allForms![x].worker_2!;                 
            tempPlumbingNumber[0] = allForms![x].worker_1!;
            tempPlumbingNumber[1] = allForms![x].worker_2!;                             
          });
          plumbingCost += generateWorkerRate(allForms![x], plumbing, plumbingRate, plumbingNumber);
          tempPlumbingNumber = [0,0];
        }
      }
    }
    setState(() {isLoading = false;});
    print(AdditionalEarthworksCost);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        actions: [printpdfButton()],
        leading: OpenDrawerWidget(
          onClicked: widget.openDrawer,
        ),
        title: const Text('Manpower Distribution'),
      ),
      body: isLoading? const Center(child: CircularProgressIndicator(),):
      SingleChildScrollView(
        child: Column(
          children: [
            //Structural
            Container(
                  color: Theme.of(context).brightness == Brightness.light? 
                Colors.grey.shade100:
                Theme.of(context).appBarTheme.backgroundColor,  
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Structural', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Theme.of(context).appBarTheme.foregroundColor),),
                  ],
                ),
              ),
            ),            
            tile('Earthworks', earthWorks, earthworksNumber, earthworksCost, Icons.landscape, this.context),
            tile('Formworks', formworks, formworksNumber, formworksCost, Icons.house_siding_outlined, this.context),
            tile('Masonry', masonry, masonryNumber, masonryCost, Icons.construction_rounded, this.context),
            tile('Reinforced Cement Works', reinforcedCementWorks, reinforcedCementWorksNumber, reinforcedCementWorksCost, CustomIcons.cement_works, this.context),
            tile('Steel Reinforcement Works', steelReinforcementWorks, steelReinforcementWorksNumber, steelReinforcementWorksCost, Icons.precision_manufacturing, this.context),
        
            //architectural
            Container(
                  color: Theme.of(context).brightness == Brightness.light? 
                Colors.grey.shade100:
                Theme.of(context).appBarTheme.backgroundColor,  
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Architectural', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Theme.of(context).appBarTheme.foregroundColor),),
                  ],
                ),
              ),
            ),           
            tile('Flooring', flooring, flooringNumber, flooringCost, CustomIcons.flooring, this.context),
            tile('Plastering', plastering, plasteringNumber, plasteringCost, CustomIcons.plastering, this.context),
            tile('Painting Works', paintingWorks, paintingWorksNumber, paintingWorksCost, CustomIcons.painting, this.context),
            tile('Doors and Windows', doorsAndWindows, doorAndWindowsNumber, doorsAndWindowsCost, CustomIcons.doors, this.context),
            tile('Ceiling', ceiling, ceilingNumber, ceilingCost, CustomIcons.ceiling, this.context),            
            tile('Roofing', roofing, roofingNumber, roofingCost, CustomIcons.roofing, this.context),
        
          //architectural
            Container(
                  color: Theme.of(context).brightness == Brightness.light? 
                Colors.grey.shade100:
                Theme.of(context).appBarTheme.backgroundColor,  
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Electrical and Plumbing', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Theme.of(context).appBarTheme.foregroundColor),),
                  ],
                ),
              ),
            ),         
            tile('Electrical Works', electricalWorks, electricalWorksNumber, electricalWorksCost, CustomIcons.electrical, this.context),
            tile('Plumbing', plumbing, plumbingNumber, plumbingCost, CustomIcons.plumbing, this.context),
          ]             
        ),
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

double generateWorkerRate(FormData form, List<String> workerLabel, List<double> rate, List<int> number){
  double totalCost = 0;
  for(int x = 0; x < workerLabel.length; x++){
    for(int y = 0; y < allWorkers!.length; y++){
      if(allWorkers![y].workerType == workerLabel[x].toUpperCase()){
        setState(() {
          rate[x] = (allWorkers![y].rate * form.num_days!) * number[x];
          totalCost += rate[x];
        });
      }
    }
  }

  return totalCost;
}

}

Widget tile( String title, List<String> workers, List<int> numbers, double cost, IconData icon, BuildContext context) => Column(
  children: [
  Container(
      color: Theme.of(context).brightness == Brightness.light? 
    Colors.grey.shade300:
    Colors.grey.shade700,  
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.20,
          child: Container(
            margin: const EdgeInsets.only(left: 7),
            child: Text(title, style: const TextStyle(
              fontWeight: FontWeight.bold,
              ), 
              overflow: TextOverflow.ellipsis,),
          )),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.20,
          child: Center(child: Text(workers[0],
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,))),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.20,
          child: Center(child: Text(workers.length > 1? workers[1] : '',
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,))),              
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.20,
          child: Center(child: Text(workers.length > 2? workers[2] : '',
          textAlign: TextAlign.center))), 
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.20,
          child: const Center(child: Text('Total Cost', 
          style:TextStyle(
              fontWeight: FontWeight.bold,
              ),          
          textAlign: TextAlign.center))),                          
      ],),
    ),
  ),
  Container(
    color: Theme.of(context).brightness == Brightness.light?
    Colors.grey.shade100:
    Theme.of(context).appBarTheme.backgroundColor,    
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,          
        children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.20,
          child: Center(child: Icon(
             icon
          ))),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.20,
          child: Center(child: Text(numbers[0].toString(),
          textAlign: TextAlign.center))),              
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.20,
          child: Center(child: Text(numbers.length > 1? numbers[1].toString() : '',
          textAlign: TextAlign.center))),              
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.20,
          child: Center(child: Text(numbers.length > 2? numbers[2].toString() : '',
          textAlign: TextAlign.center))),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.20,
          child: Center(child: Text(cost.toString(),
          textAlign: TextAlign.center)))              
      ],),
    ),
  )
  // Text(numbers[0].toString()),
],);

Future<void> _createPDF() async {
  //Creates a new PDF document
  PdfDocument document = PdfDocument();

//Adds page settings
  document.pageSettings.orientation = PdfPageOrientation.landscape;
  document.pageSettings.margins.all = 50;

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
      PdfTextElement(text: 'Construction Schedule', font: subHeadingFont);
  element.brush = PdfBrushes.white;

//Draws the heading on the page
  PdfLayoutResult result = element.draw(
      page: page, bounds: Rect.fromLTWH(300, bounds.top + 8, 0, 0))!;

  //Use 'intl' package for date format.
  String currentDate = 'DATE ' + DateFormat.yMMMd().format(DateTime.now());

//Measures the width of the text to place it in the correct location
  Size textSize = subHeadingFont.measureString(currentDate);
  Offset textPosition = Offset(
      graphics.clientSize.width - textSize.width - 10, result.bounds.top);

  //Draws the date by using drawString method
  graphics.drawString(currentDate, subHeadingFont,
      brush: element.brush,
      bounds: Offset(graphics.clientSize.width - textSize.width - 10,
              result.bounds.top) &
          Size(textSize.width + 2, 20));

//Creates text elements to add the address and draw it to the page
  element = PdfTextElement(
      text:
          'Project Name: Walican House \tStart Date: March 07,2022 \tTotal Duration: 19 Days',
      font: PdfStandardFont(PdfFontFamily.timesRoman, 14,
          style: PdfFontStyle.bold));
  element.brush = PdfBrushes.black;
  result = element.draw(
      page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 25, 0, 0))!;

  PdfFont timesRoman = PdfStandardFont(PdfFontFamily.timesRoman, 14);

  element = PdfTextElement(
      text: 'Project Manager: Engr.Tolentino \tEnd Date: March 29,2022',
      font: PdfStandardFont(PdfFontFamily.timesRoman, 14,
          style: PdfFontStyle.bold));
  element.brush = PdfBrushes.black;
  result = element.draw(
      page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 25, 0, 0))!;

  graphics.drawLine(
      PdfPen(PdfColor(126, 151, 173), width: 0.7),
      Offset(0, result.bounds.bottom + 3),
      Offset(graphics.clientSize.width, result.bounds.bottom + 3));

  //Creates a PDF grid
  PdfGrid grid = PdfGrid();

//Add the columns to the grid
  grid.columns.add(count: 5);

//Add header to the grid
  grid.headers.add(1);

  PdfGridRow header = grid.headers[0];
  header.cells[0].value = 'Task Descriptions';
  header.cells[1].value = 'Status';
  header.cells[2].value = 'Starting Date';
  header.cells[3].value = 'End Date';
  header.cells[4].value = 'Duration';

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
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle);
    } else {
      header.cells[i].stringFormat = PdfStringFormat(
          alignment: PdfTextAlignment.right,
          lineAlignment: PdfVerticalAlignment.middle);
    }
    header.cells[i].style = headerStyle;
  }

//Add rows to grid
  PdfGridRow row = grid.rows.add();

  for (int i = 0; i < 20; i++) {
    row = grid.rows.add();
    row.cells[0].value = " Layout and Excavation";
    row.cells[1].value = " Complete";
    row.cells[2].value = "03/07/2022";
    row.cells[3].value = "03/09/2022";
    row.cells[4].value = "3 Days";
  }
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
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.middle);
      } else {
        row.cells[j].stringFormat = PdfStringFormat(
            alignment: PdfTextAlignment.right,
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
      bounds: Rect.fromLTWH(0, result.bounds.bottom + 20,
          graphics.clientSize.width, graphics.clientSize.height - 100),
      format: layoutFormat)!;

  List<int> bytes = document.save();
  document.dispose();

  saveAndLaunchFile(bytes, 'Output.pdf');
}

Widget printpdfButton() => const ElevatedButton(
      child: Text('Create PDF'),
      onPressed: _createPDF,
    );
