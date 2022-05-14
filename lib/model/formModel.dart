const String tableAllData = 'tbl_all_data';

//minimize class for table field names
class TblFormDataField {
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
    // cost_of_labor,
    type,
    work
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
  // static const String cost_of_labor = 'cost_of_labor';
  static const String type = 'type';
  static const String work = 'work';
}

class FormData {
  //this are the attributes of our object Diary
  //final meaning when this attributes value are set in a current object instance, it can never be changed.
  final int? id;
  final int fk;
  final String? date_start;
  final String? date_end;
  final String col_1;
  final double col_1_val;
  final double? col_2;
  final int? pref_time;
  final int? num_days;
  final int? num_workers;
  final int? worker_1;
  final int? worker_2;  
  // final double cost_of_labor;
  final String type;
  final String work;

//const will just let a function to just read the value of our Diary class current value (context)
  const FormData({
    //initializing our parameter, title = this, this refer's to a current method value.
    this.id,
    required this.fk,
    this.date_start,
    this.date_end,
    required this.col_1,
    required this.col_1_val,
    this.col_2,
    this.pref_time,
    this.num_days,
    this.num_workers,
    this.worker_1,
    this.worker_2,    
    // required this.cost_of_labor,
    required this.type,
    required this.work
  });

  Map<String, Object?> toJson() => {
        //Key: Value, Column Field: Value
        TblFormDataField.id: id,
        TblFormDataField.fk : fk,
        TblFormDataField.date_start: date_start,
        TblFormDataField.date_end: date_end,
        TblFormDataField.col_1: col_1,
        TblFormDataField.col_1_val: col_1_val,
        TblFormDataField.col_2: col_2,
        TblFormDataField.pref_time:pref_time,
        TblFormDataField.num_days:num_days,
        TblFormDataField.num_workers: num_workers,
        TblFormDataField.worker_1:worker_1,
        TblFormDataField.worker_2:worker_2,
        // TblFormDataField.cost_of_labor:cost_of_labor,
        TblFormDataField.type:type,
        TblFormDataField.work: work
      };

  //explain this well, Diary returnID is a constuctor
  FormData returnID(
          { //edited here
          int? parameterId,
          int? fk,
          String? date_start,
          String? date_end,
          String? col_1,
          double? col_1_val,
          double? col_2,
          int? pref_time,
          int? num_days,
          int? num_workers,
          int? worker_1,
          int? worker_2,
          // double? cost_of_labor,
          String? type,
          String? work
          }) =>
      FormData(
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
          // cost_of_labor: cost_of_labor ?? this.cost_of_labor,
          type: type ?? this.type,
          work: work ?? this.work
      );

  static FormData fromJson(Map<String, Object?> fromSQL) => FormData(
      id: fromSQL[TblFormDataField.id] as int?,
      fk: fromSQL[TblFormDataField.fk] as int,
      date_start: fromSQL[TblFormDataField.date_start] as String?,
      date_end: fromSQL[TblFormDataField.date_end] as String?,
      col_1: fromSQL[TblFormDataField.col_1] as String,
      col_1_val: fromSQL[TblFormDataField.col_1_val] as double,
      col_2: fromSQL[TblFormDataField.col_2] as double?,
      pref_time: fromSQL[TblFormDataField.pref_time] as int?,
      num_days: fromSQL[TblFormDataField.num_days] as int?,
      num_workers: fromSQL[TblFormDataField.num_workers] as int?,
      worker_1: fromSQL[TblFormDataField.worker_1] as int?,
      worker_2: fromSQL[TblFormDataField.worker_2] as int?,
      // cost_of_labor: fromSQL[TblFormDataField.cost_of_labor] as double,
      type: fromSQL[TblFormDataField.type] as String,
      work: fromSQL[TblFormDataField.work] as String
  );

   @override
  String toString() {
    return 'fk: $fk, col_1: $col_1, Col_1_val: $col_1_val, Type: $type, Work: $work';
  }
}
