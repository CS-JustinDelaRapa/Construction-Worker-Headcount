// ignore_for_file: non_constant_identifier_names
const String tableSTRFormworks = 'tbl_structural_formworks';
const String tableSTRMasonry = 'tbl_structural_masonry';
const String tableSTRRCC = 'tbl_structural_rcc';
const String tableARCFlooring =   'tbl_architectural_flooring';
const String tableARCPlastering =   'tbl_architectural_plastering_wroks';
const String tableARCCeilings =   'tbl_architectural_ceilings';
const String tableARCRoofing =   'tbl_architectural_roofing';
const String tableELCPlumbing =   'tbl_electrical_plumbing';
const String tableELCElectrical =   'tbl_electrical_electrical';

//minimize class for table field names
class TblFormTwoField {
  static final List<String> formTwoFieldNames = [
    id,
    fk,
    date_start,
    date_end,
    col_1,
    col_1_val,
    col_2,
    pref_time,
    num_days,
    num_workers,
    worker_1,
    worker_2,
    cost_of_labor,
    type
  ];

  //this are the variables that will hold the column field name of our tblDiary
  static const String id = '_id';
  static const String fk = 'fk';
  static const String date_start = 'date_start';
  static const String date_end = 'date_end';
  static const String col_1 = 'col_1';
  static const String col_1_val = 'col_1_value';
  static const String col_2 = 'col_2';
  static const String pref_time = 'pref_time';
  static const String num_days = 'num_days';
  static const String num_workers = 'num_workers';
  static const String worker_1 = 'worker_1';
  static const String worker_2 = 'worker_2';
  static const String cost_of_labor = 'cost_of_labor';
  static const String type = 'type';
}

class FormTwo {
  //this are the attributes of our object Diary
  //final meaning when this attributes value are set in a current object instance, it can never be changed.
  final int? id;
  final int fk;
  final DateTime date_start;
  final DateTime date_end;
  final String col_1;
  final double col_1_val;
  final double col_2;
  final int pref_time;
  final int num_days;
  final int num_workers;
  final String worker_1;
  final String worker_2;  
  final double cost_of_labor;
  final String type;

//const will just let a function to just read the value of our Diary class current value (context)
  const FormTwo({
    //initializing our parameter, title = this, this refer's to a current method value.
    this.id,
    required this.fk,
    required this.date_start,
    required this.date_end,
    required this.col_1,
    required this.col_1_val,
    required this.col_2,
    required this.pref_time,
    required this.num_days,
    required this.num_workers,
    required this.worker_1,
    required this.worker_2,    
    required this.cost_of_labor,
    required this.type
  });

  Map<String, Object?> toJson() => {
        //Key: Value, Column Field: Value
        TblFormTwoField.id: id,
        TblFormTwoField.fk : fk,
        TblFormTwoField.date_start: date_start.toIso8601String(),
        TblFormTwoField.date_end: date_end.toIso8601String(),
        TblFormTwoField.col_1: col_1,
        TblFormTwoField.col_1_val: col_1_val,
        TblFormTwoField.col_2: col_2,
        TblFormTwoField.pref_time:pref_time,
        TblFormTwoField.num_days:num_days,
        TblFormTwoField.num_workers: num_workers,
        TblFormTwoField.worker_1:worker_1,
        TblFormTwoField.worker_2:worker_2,
        TblFormTwoField.cost_of_labor:cost_of_labor,
        TblFormTwoField.type:type
      };

  //explain this well, Diary returnID is a constuctor
  FormTwo returnID(
          { //edited here
          int? parameterId,
          int? fk,
          DateTime? date_start,
          DateTime? date_end,
          String? col_1,
          double? col_1_val,
          double? col_2,
          int? pref_time,
          int? num_days,
          int? num_workers,
          String? worker_1,
          String? worker_2,
          double? cost_of_labor,
          String? type
          }) =>
      FormTwo(
          //?? = Null-Coalsing Operator, meaning, if ParameterID is null then use the value of this(context) id, else it will return the value of ParameterID
          //if parameterID is null this line 41 will cause then an error because a ?? operator right operand must not be null.
          // ignore: unnecessary_this
          id: parameterId ?? this.id,
          fk: fk ?? this.fk,
          date_start: date_start ?? this.date_start,
          date_end: date_end ?? this.date_end,
          col_1: col_1 ?? this.col_1,
          col_1_val: col_1_val ?? this.col_1_val,
          col_2: col_2 ?? this.col_2,
          pref_time: pref_time ?? this.pref_time,
          num_days: num_days ?? this.num_days,
          num_workers: num_workers ?? this.num_workers,
          worker_1: worker_1 ?? this.worker_1,
          worker_2: worker_2 ?? this.worker_2,
          cost_of_labor: cost_of_labor ?? this.cost_of_labor,
          type: type ?? this.type
      );

  static FormTwo fromJson(Map<String, Object?> fromSQL) => FormTwo(
      id: fromSQL[TblFormTwoField.id] as int?,
      fk: fromSQL[TblFormTwoField.fk] as int,
      date_start: DateTime.parse(fromSQL[TblFormTwoField.date_start] as String),
      date_end: DateTime.parse(fromSQL[TblFormTwoField.date_end] as String),
      col_1: fromSQL[TblFormTwoField.col_1] as String,
      col_1_val: fromSQL[TblFormTwoField.col_1_val] as double,
      col_2: fromSQL[TblFormTwoField.col_2] as double,
      pref_time: fromSQL[TblFormTwoField.pref_time] as int,
      num_days: fromSQL[TblFormTwoField.num_days] as int,
      num_workers: fromSQL[TblFormTwoField.num_workers] as int,
      worker_1: fromSQL[TblFormTwoField.worker_1] as String,
      worker_2: fromSQL[TblFormTwoField.worker_2] as String,
      cost_of_labor: fromSQL[TblFormTwoField.cost_of_labor] as double,
      type: fromSQL[TblFormTwoField.type] as String
  );
}
