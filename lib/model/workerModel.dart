final String tableWorker = 'tbl_worker';

//minimize class for table field names
class TblWorkerField {
  static final List<String> projectFieldNames = [
    id,
    worker_type,
    rate,
  ];

  //this are the variables that will hold the column field name of our tblDiary
  static final String id = '_id';
  static final String worker_type = 'worker_type';
  static final String rate = 'rate';
}

class WorkerType {
  //this are the attributes of our object Diary
  //final meaning when this attributes value are set in a current object instance, it can never be changed.
  final int? id;
  final String worker_type;
  final double rate; 
//const will just let a function to just read the value of our Diary class current value (context)
  const WorkerType({
    //initializing our parameter, title = this, this refer's to a current method value.
    this.id,
    required this.worker_type,
    required this.rate
  });

  Map<String, Object?> toJson() => {
        //Key: Value, Column Field: Value
        TblWorkerField.id: id,
        TblWorkerField.worker_type: worker_type,
        TblWorkerField.rate: rate
        //INSERT INTO tbl_Diary('_id',..) Values ('null','Tiltle'..)
      };

  //explain this well, Diary returnID is a constuctor
  WorkerType returnID(
          { //edited here
          int? parameterID,
          String? worker_type,
          double? rate}) =>
      WorkerType(
          //?? = Null-Coalsing Operator, meaning, if ParameterID is null then use the value of this(context) id, else it will return the value of ParameterID
          //if parameterID is null this line 41 will cause then an error because a ?? operator right operand must not be null.
          id: parameterID ?? this.id,
          worker_type: worker_type ?? this.worker_type,
          rate: rate ?? this.rate
      );

  static WorkerType fromJson(Map<String, Object?> fromSQL) => WorkerType(
      id: fromSQL[TblWorkerField.id] as int?,
      worker_type: fromSQL[TblWorkerField.worker_type] as String,
      rate: fromSQL[TblWorkerField.rate] as double);
}
