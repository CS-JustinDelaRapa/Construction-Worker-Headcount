final String tableProject = 'tbl_task';

//minimize class for table field names
class TblProjectField {
  static final List<String> projectFieldNames = [
    id,
    date_start,
    date_end,
    project_name,
    project_manager,
    type,
  ];

  //this are the variables that will hold the column field name of our tblDiary
  static final String id = '_id';
  static final String date_start = 'date_start';
  static final String date_end = 'date_end';
  static final String project_name = 'project_name';
  static final String project_manager = 'project_manager';
  static final String type = 'type';
}

class ProjectItem {
  //this are the attributes of our object Diary
  //final meaning when this attributes value are set in a current object instance, it can never be changed.
  final int? id;
  final DateTime date_start;
  final DateTime date_end;
  final String project_name;
  final String project_manager;
  final String type;
//const will just let a function to just read the value of our Diary class current value (context)
  const ProjectItem(
      {
      //initializing our parameter, title = this, this refer's to a current method value.
      this.id,
      required this.project_name,
      required this.project_manager,
      required this.date_start,
      required this.date_end,
      required this.type});

  Map<String, Object?> toJson() => {
        //Key: Value, Column Field: Value
        TblProjectField.id: id,
        TblProjectField.date_start: date_start.toIso8601String(),
        TblProjectField.date_end: date_end.toIso8601String(),
        TblProjectField.project_name: project_name,
        TblProjectField.project_manager: project_manager,
        TblProjectField.type: type
        //INSERT INTO tbl_Diary('_id',..) Values ('null','Tiltle'..)
      };

  //explain this well, Diary returnID is a constuctor
  ProjectItem returnID(
          { //edited here
          int? parameterID,
          DateTime? date_start,
          DateTime? date_end,
          String? project_name,
          String? project_manager,
          String? type}) =>
      ProjectItem(
          //?? = Null-Coalsing Operator, meaning, if ParameterID is null then use the value of this(context) id, else it will return the value of ParameterID
          //if parameterID is null this line 41 will cause then an error because a ?? operator right operand must not be null.
          id: parameterID ?? this.id,
          date_start: date_start ?? this.date_start,
          date_end: date_end ?? this.date_end,
          project_name: project_name ?? this.project_name,
          project_manager: project_manager ?? this.project_manager,
          type: type ?? this.type);

  static ProjectItem fromJson(Map<String, Object?> fromSQL) => ProjectItem(
      id: fromSQL[TblProjectField.id] as int?,
      date_start: DateTime.parse(fromSQL[TblProjectField.date_start] as String),
      date_end: DateTime.parse(fromSQL[TblProjectField.date_end] as String),
      project_name: fromSQL[TblProjectField.project_name] as String,
      project_manager: fromSQL[TblProjectField.project_manager] as String,
      type: fromSQL[TblProjectField.type] as String);
}
