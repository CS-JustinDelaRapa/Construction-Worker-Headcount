final String tableWorker = 'tbl_worker';

//minimize class for table field names
class TblWorkerField {
  static final List<String> workerFieldNames = [
    id,
    workerType,
    rate,
    fk
  ];

  //this are the variables that will hold the column field name of our tblDiary
  static final String id = '_id';
  static final String workerType = 'worker_type';
  static final String rate = 'rate';
  static final String fk = 'fk';
}

class WorkerType {
  //this are the attributes of our object Diary
  //final meaning when this attributes value are set in a current object instance, it can never be changed.
  final int? id;
  final String workerType;
  final double rate; 
  final int fk;
//const will just let a function to just read the value of our Diary class current value (context)
  const WorkerType({
    //initializing our parameter, title = this, this refer's to a current method value.
    this.id,
    required this.workerType,
    required this.rate,
    required this.fk
  });

  Map<String, Object?> toJson() => {
        //Key: Value, Column Field: Value
        TblWorkerField.id: id,
        TblWorkerField.workerType: workerType,
        TblWorkerField.rate: rate,
        TblWorkerField.fk: fk
        //INSERT INTO tbl_Diary('_id',..) Values ('null','Tiltle'..)
      };

  //explain this well, Diary returnID is a constuctor
  WorkerType returnID(
          { //edited here
          int? parameterID,
          String? worker_type,
          double? rate,
          int? fk}) =>
      WorkerType(
          //?? = Null-Coalsing Operator, meaning, if ParameterID is null then use the value of this(context) id, else it will return the value of ParameterID
          //if parameterID is null this line 41 will cause then an error because a ?? operator right operand must not be null.
          id: parameterID ?? this.id,
          workerType: worker_type ?? this.workerType,
          rate: rate ?? this.rate,
          fk: fk ?? this.fk
      );

  static WorkerType fromJson(Map<String, Object?> fromSQL) => WorkerType(
      id: fromSQL[TblWorkerField.id] as int?,
      workerType: fromSQL[TblWorkerField.workerType] as String,
      rate: fromSQL[TblWorkerField.rate] as double,
      fk: fromSQL[TblWorkerField.fk] as int
      );
}
