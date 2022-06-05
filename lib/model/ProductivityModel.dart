final String tableProductivity = 'tbl_productivity';

//minimize class for table field names
class TblProductivityField {
  static final List<String> productivityFieldNames = [
    id,
    fk,
    col_1,
    col_1_val,
    work,
    type,
  ];

  //this are the variables that will hold the column field name of our tblDiary
  static const String id = '_id';
  static const String fk = 'fk';
  static const String col_1 = 'col_1';
  static const String col_1_val = 'col_1_val';
  static const String work = 'work';
  static const String type = 'type';
}

class ProductivityItem {
  //this are the attributes of our object Diary
  //final meaning when this attributes value are set in a current object instance, it can never be changed.
  final int? id;
  final int fk;
  final String col_1;
  final double col_1_val;
  final String type;
  final String work;
//const will just let a function to just read the value of our Diary class current value (context)
  const ProductivityItem(
      {
      //initializing our parameter, title = this, this refer's to a current method value.
      this.id,
      required this.fk,
      required this.col_1,
      required this.col_1_val,
      required this.type,
      required this.work});

  Map<String, Object?> toJson() => {
        //Key: Value, Column Field: Value
        TblProductivityField.id: id,
        TblProductivityField.fk: fk,
        TblProductivityField.col_1: col_1,
        TblProductivityField.col_1_val: col_1_val,
        TblProductivityField.type: type,
        TblProductivityField.work: work
        //INSERT INTO tbl_Diary('_id',..) Values ('null','Tiltle'..)
      };

  //explain this well, Diary returnID is a constuctor
  ProductivityItem returnID(
          { //edited here
          int? parameterID,
          int? fk,
          String? col_1,
          double? col_1_val,
          String? type,
          String? work}) =>
      ProductivityItem(
          //?? = Null-Coalsing Operator, meaning, if ParameterID is null then use the value of this(context) id, else it will return the value of ParameterID
          //if parameterID is null this line 41 will cause then an error because a ?? operator right operand must not be null.
          id: parameterID ?? this.id,
          fk: fk ?? this.fk,
          col_1: col_1 ?? this.col_1,
          col_1_val: col_1_val ?? this.col_1_val,
          type: type ?? this.type,
          work: work ?? this.work);

  static ProductivityItem fromJson(Map<String, Object?> fromSQL) =>
      ProductivityItem(
          id: fromSQL[TblProductivityField.id] as int?,
          fk: fromSQL[TblProductivityField.fk] as int,
          col_1: fromSQL[TblProductivityField.col_1] as String,
          col_1_val: fromSQL[TblProductivityField.col_1_val] as double,
          type: fromSQL[TblProductivityField.type] as String,
          work: fromSQL[TblProductivityField.work] as String);

  @override
  String toString() {
    return 'id: $id, fk: $fk, work: $work, col_1: $col_1, col_1_val: $col_1_val';
  }
}
