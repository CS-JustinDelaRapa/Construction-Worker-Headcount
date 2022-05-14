// ignore_for_file: file_names
// import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:engineering/screens/hamburgerMenu/openDrawer.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'mobile.dart';

class ManpowerDistribution extends StatefulWidget {
  final VoidCallback openDrawer;

  const ManpowerDistribution({Key? key, required this.openDrawer})
      : super(key: key);

  @override
  _ManpowerDistributionState createState() => _ManpowerDistributionState();
}

class _ManpowerDistributionState extends State<ManpowerDistribution> {
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
      body: Center(),
    );
  }

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
        page: page,
        bounds: Rect.fromLTWH(10, result.bounds.bottom + 25, 0, 0))!;

    PdfFont timesRoman = PdfStandardFont(PdfFontFamily.timesRoman, 14);

    element = PdfTextElement(
        text: 'Project Manager: Engr.Tolentino \tEnd Date: March 29,2022',
        font: PdfStandardFont(PdfFontFamily.timesRoman, 14,
            style: PdfFontStyle.bold));
    element.brush = PdfBrushes.black;
    result = element.draw(
        page: page,
        bounds: Rect.fromLTWH(10, result.bounds.bottom + 25, 0, 0))!;

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

  Widget printpdfButton() => ElevatedButton(
        child: const Text('Create PDF'),
        onPressed: _createPDF,
      );
}
