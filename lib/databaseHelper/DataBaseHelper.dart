import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/ProjectModel.dart';
import '../model/formModel.dart';
import '../model/workerModel.dart';

class DatabaseHelper{
  
  static final DatabaseHelper instance = DatabaseHelper();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    //
    _database = await _generatePath('db_simplify!');

    return _database!;
  }

  Future<Database> _generatePath(String dbname) async {
    final dbPath = await getDatabasesPath();

    final fullPath = join(dbPath, dbname);

    return await openDatabase(fullPath, version: 1, onCreate: _createTable);
  }

  //**Table */
  Future _createTable(Database query, int version) async {
      await query.execute('''
  CREATE TABLE $tableWorker(
    ${TblWorkerField.id} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${TblWorkerField.worker_type} TEXT NOT NUll,
    ${TblWorkerField.rate} REAL NOT NUll    
    )
  ''');
      await query.execute('''
  CREATE TABLE $tableProject(
    ${TblProjectField.id} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${TblProjectField.date_start} TEXT NOT NULL,
    ${TblProjectField.date_end} TEXT NOT NULL,
    ${TblProjectField.project_name} TEXT NOT NUll,
    ${TblProjectField.type} TEXT NOT NUll    
    )
  ''');
      await query.execute('''
  CREATE TABLE $tableAllData(
    ${TblFormDataField.id} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${TblFormDataField.fk} INTEGER NOT NUll,
    ${TblFormDataField.date_start} TEXT NOT NULL,
    ${TblFormDataField.date_end} TEXT NOT NULL,
    ${TblFormDataField.col_1} TEXT,
    ${TblFormDataField.col_1_val} REAL NOT NUll,
    ${TblFormDataField.col_2} REAL NOT NUll,
    ${TblFormDataField.pref_time} INTEGER NOT NUll,
    ${TblFormDataField.num_days} INTEGER NOT NUll,
    ${TblFormDataField.num_workers} INTEGER NOT NUll,
    ${TblFormDataField.worker_1} TEXT NOT NUll,
    ${TblFormDataField.worker_2} TEXT,    
    ${TblFormDataField.cost_of_labor} REAL NOT NUll,
    ${TblFormDataField.type} TEXT NOT NUll,
    ${TblFormDataField.work} TEXT NOT NUll
    )
  ''');
  }

//project
  Future createProject(ProjectItem projectItem) async {
    final reference = await instance.database;

    //irereturn nito ang Primary key ng table, which is ID
    final id = await reference.insert(tableProject, projectItem.toJson());
    return id;
  }

  Future<List<ProjectItem>> readAllProject() async {
    final reference = await instance.database;

    //SELECT * FROM tbl_diary ORDER BY dateTime
    final fromTable =
        await reference.query(tableProject, orderBy: '${TblProjectField.id} DESC');
    return fromTable.map((fromSQL) => ProjectItem.fromJson(fromSQL)).toList();
  }

  Future<ProjectItem> readProject(int searchKey) async {
    final reference = await instance.database;

    final specificID = await reference.query(
      tableProject,
      columns: TblProjectField.projectFieldNames,
      where: '${TblProjectField.id} = ?',
      whereArgs: [searchKey],
    );

    if (specificID.isNotEmpty) {
      return ProjectItem.fromJson(specificID.first);
    } else {
      throw Exception('ID $searchKey not found');
    }
  }

  Future<int> updateProject(ProjectItem projectInstance) async {
    final reference = await instance.database;

    return reference.update(tableProject, projectInstance.toJson(),
        where: '${TblProjectField.id} = ?', whereArgs: [projectInstance.id]);
  }

  Future<int> deleteProject(int searchKey) async {
    final refererence = await instance.database;

    return refererence.delete(tableProject,
        where: '${TblProjectField.id} = ?', whereArgs: [searchKey]);
  }  
  
//formData
  Future createFormData(FormData formTwo) async {
    final reference = await instance.database;
    print('at create database helper');
    //irereturn nito ang Primary key ng table, which is ID
    await reference.insert(tableAllData, formTwo.toJson());
  }

  Future<FormData?> readFormData(int fk, String type, String work) async {
    final reference = await instance.database;

    final specificID = await reference.query(
      tableAllData,
      columns: TblFormDataField.formTwoFieldNames,
      where: '${TblFormDataField.fk} = ? and ${TblFormDataField.type} = ? and ${TblFormDataField.work} = ?',
      whereArgs: [fk, type, work]
    );

    if (specificID.isNotEmpty) {
      return FormData.fromJson(specificID.first);
    } else {
      return null;
    }
  }

  Future<int> updateFormData(FormData formTwoInstance) async {
    final reference = await instance.database;

    return reference.update(tableAllData, formTwoInstance.toJson(),
        where: '${TblFormDataField.id} = ?', whereArgs: [formTwoInstance.id]);
  }

  // Future<int> deleteForm(int searchKey, String tableName) async {
  //   final refererence = await instance.database;
  //   return refererence.delete(tableName,
  //       where: '${TblFormField.id} = ?', whereArgs: [searchKey]);
  // }      

//worker
  Future createWorker(WorkerType workerType) async {
    final reference = await instance.database;

    //irereturn nito ang Primary key ng table, which is ID
    await reference.insert(tableWorker, workerType.toJson());
  }

  Future<List<WorkerType>> readAllWorkerType() async {
    final reference = await instance.database;

    //SELECT * FROM tbl_diary ORDER BY dateTime
    final fromTable =
        await reference.query(tableProject, orderBy: '${TblWorkerField.id} DESC');
    return fromTable.map((fromSQL) => WorkerType.fromJson(fromSQL)).toList();
  }

  Future<int> updateWorker(WorkerType workerInstance) async {
    final reference = await instance.database;

    return reference.update(tableProject, workerInstance.toJson(),
        where: '${TblWorkerField.id} = ?', whereArgs: [workerInstance.id]);
  }
}