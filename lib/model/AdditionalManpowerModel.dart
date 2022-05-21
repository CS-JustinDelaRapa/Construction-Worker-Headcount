import 'package:engineering/screens/mainProject/additionalManpower/additionalManpower.dart';

const String tableManPower = 'tbl_Manworker';

//minimize class for table field names
class TblManpowerField {
  static final List<String> manpowerFieldNames = [
    id,
    fk,
    work,
    type,
    cbOne,
    cbTwo,
    cbThree,
    cbFour,
    cbFive,
    cbSix,
    cbSeven,
    cbEight,
    cbNine,
    cbTen,
    totalPercentage,
  ];

  //this are the variables that will hold the column field name of our tblDiary
  static const String id = '_id';
  static const String fk = 'fk';
  static const String work = 'work';
  static const String type = 'type';
  static const String cbOne = 'cb_one';
  static const String cbTwo = 'cb_two';
  static const String cbThree = 'cb_three';
  static const String cbFour = 'cb_four';
  static const String cbFive = 'cb_five';
  static const String cbSix = 'cb_six';
  static const String cbSeven = 'cb_seven';
  static const String cbEight = 'cb_eight';
  static const String cbNine = 'cb_nine';
  static const String cbTen = 'cb_ten';
  static const String totalPercentage = 'total_percentage';
}

class AdditionalManpower {
  //this are the attributes of our object Diary
  //final meaning when this attributes value are set in a current object instance, it can never be changed.
  final int? id;
  final int fk;
  final String work;
  final String type;
  final bool cbOne;
  final bool cbTwo;
  final bool cbThree;
  final bool cbFour;
  final bool cbFive;
  final bool cbSix;
  final bool cbSeven;
  final bool cbEight;
  final bool cbNine;
  final bool cbTen;
  final double totalPercentage;

//const will just let a function to just read the value of our Diary class current value (context)
  const AdditionalManpower(
      {
      //initializing our parameter, title = this, this refer's to a current method value.
      this.id,
      required this.fk,
      required this.work,
      required this.type,
      required this.cbOne,
      required this.cbTwo,
      required this.cbThree,
      required this.cbFour,
      required this.cbFive,
      required this.cbSix,
      required this.cbSeven,
      required this.cbEight,
      required this.cbNine,
      required this.cbTen,
      required this.totalPercentage});

  Map<String, Object?> toJson() => {
        //Key: Value, Column Field: Value
        TblManpowerField.id: id,
        TblManpowerField.fk: fk,
        TblManpowerField.work: work,
        TblManpowerField.type: type,
        TblManpowerField.cbOne: cbOne,
        TblManpowerField.cbTwo: cbTwo,
        TblManpowerField.cbThree: cbThree,
        TblManpowerField.cbFour: cbFour,
        TblManpowerField.cbFive: cbFive,
        TblManpowerField.cbSix: cbSix,
        TblManpowerField.cbSeven: cbSeven,
        TblManpowerField.cbEight: cbEight,
        TblManpowerField.cbNine: cbNine,
        TblManpowerField.cbTen: cbTen,
        TblManpowerField.totalPercentage: totalPercentage
        //INSERT INTO tbl_Diary('_id',..) Values ('null','Tiltle'..)
      };

  //explain this well, Diary returnID is a constuctor
  AdditionalManpower returnID({
    //edited here
    int? parameterID,
    int? fk,
    String? work,
    String? type,
    bool? cbOne,
    bool? cbTwo,
    bool? cbThree,
    bool? cbFour,
    bool? cbFive,
    bool? cbSix,
    bool? cbSeven,
    bool? cbEight,
    bool? cbNine,
    bool? cbTen,
    double? totalPercentage,
  }) =>
      AdditionalManpower(
        //?? = Null-Coalsing Operator, meaning, if ParameterID is null then use the value of this(context) id, else it will return the value of ParameterID
        //if parameterID is null this line 41 will cause then an error because a ?? operator right operand must not be null.
        id: parameterID ?? this.id,
        fk: fk ?? this.fk,
        work: work ?? this.work,
        type: type ?? this.type,
        cbOne: cbOne ?? this.cbOne,
        cbTwo: cbTwo ?? this.cbTwo,
        cbThree: cbThree ?? this.cbThree,
        cbFour: cbFour ?? this.cbFour,
        cbFive: cbFive ?? this.cbFive,
        cbSix: cbSix ?? this.cbSix,
        cbSeven: cbSeven ?? this.cbSeven,
        cbEight: cbEight ?? this.cbEight,
        cbNine: cbNine ?? this.cbNine,
        cbTen: cbTen ?? this.cbTen,
        totalPercentage: totalPercentage ?? this.totalPercentage,
      );

  static AdditionalManpower fromJson(Map<String, Object?> fromSQL) =>
      AdditionalManpower(
        id: fromSQL[TblManpowerField.id] as int?,
        fk: fromSQL[TblManpowerField.fk] as int,
        work: fromSQL[TblManpowerField.work] as String,
        type: fromSQL[TblManpowerField.type] as String,
        cbOne: fromSQL[TblManpowerField.cbOne] == 1,
        cbTwo: fromSQL[TblManpowerField.cbTwo] == 1,
        cbThree: fromSQL[TblManpowerField.cbThree] == 1,
        cbFour: fromSQL[TblManpowerField.cbFour] == 1,
        cbFive: fromSQL[TblManpowerField.cbFive] == 1,
        cbSix: fromSQL[TblManpowerField.cbSix] == 1,
        cbSeven: fromSQL[TblManpowerField.cbSeven] == 1,
        cbEight: fromSQL[TblManpowerField.cbEight] == 1,
        cbNine: fromSQL[TblManpowerField.cbNine] == 1,
        cbTen: fromSQL[TblManpowerField.cbTen] == 1,
        totalPercentage: fromSQL[TblManpowerField.totalPercentage] as double,
      );

  @override
  String toString() {
    return 'id: $id, fk: $fk, work: $work, type: $type, 1: $cbOne, 2: $cbTwo, 3: $cbThree, 4: $cbFour, 5: $cbFive, 6: $cbSix, 7: $cbSeven, 8: $cbEight, 9: $cbNine, 10: $cbTen, totalPercentage: $totalPercentage';
  }
}
