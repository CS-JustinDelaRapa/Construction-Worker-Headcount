import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/ProjectItem.dart';
import '../model/formOneModel.dart';
import '../model/formTwoModel.dart';

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
  CREATE TABLE $tableProject(
    ${TblProjectField.id} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${TblProjectField.date_start} TEXT NOT NULL,
    ${TblProjectField.date_end} TEXT NOT NULL,
    ${TblProjectField.project_name} TEXT NOT NUll,
    ${TblProjectField.type} TEXT NOT NUll    
    )
  ''');
      await query.execute('''
  CREATE TABLE $tableSTREarthworks(
    ${TblFormOneField.id} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${TblFormOneField.fk} INTEGER NOT NUll,
    ${TblFormOneField.date_start} TEXT NOT NULL,
    ${TblFormOneField.date_end} TEXT NOT NULL,
    ${TblFormOneField.col_1} TEXT NOT NUll,
    ${TblFormOneField.col_1_val} REAL NOT NUll,
    ${TblFormOneField.col_2} REAL NOT NUll,
    ${TblFormOneField.pref_time} INTEGER NOT NUll,
    ${TblFormOneField.num_days} INTEGER NOT NUll,
    ${TblFormOneField.num_workers} INTEGER NOT NUll,
    ${TblFormOneField.worker_1} TEXT NOT NUll,
    ${TblFormOneField.cost_of_labor} REAL NOT NUll,
    ${TblFormOneField.type} TEXT NOT NUll
    )
  ''');
      await query.execute('''
  CREATE TABLE $tableSTRSRC(
    ${TblFormOneField.id} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${TblFormOneField.fk} INTEGER NOT NUll,
    ${TblFormOneField.date_start} TEXT NOT NULL,
    ${TblFormOneField.date_end} TEXT NOT NULL,
    ${TblFormOneField.col_1} TEXT NOT NUll,
    ${TblFormOneField.col_1_val} REAL NOT NUll,
    ${TblFormOneField.col_2} REAL NOT NUll,
    ${TblFormOneField.pref_time} INTEGER NOT NUll,
    ${TblFormOneField.num_days} INTEGER NOT NUll,
    ${TblFormOneField.num_workers} INTEGER NOT NUll,
    ${TblFormOneField.worker_1} TEXT NOT NUll,
    ${TblFormOneField.cost_of_labor} REAL NOT NUll,
    ${TblFormOneField.type} TEXT NOT NUll
    )
  ''');
      await query.execute('''
  CREATE TABLE $tableARCDoorsAndWindows(
    ${TblFormOneField.id} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${TblFormOneField.fk} INTEGER NOT NUll,
    ${TblFormOneField.date_start} TEXT NOT NULL,
    ${TblFormOneField.date_end} TEXT NOT NULL,
    ${TblFormOneField.col_1} TEXT NOT NUll,
    ${TblFormOneField.col_1_val} REAL NOT NUll,
    ${TblFormOneField.col_2} REAL NOT NUll,
    ${TblFormOneField.pref_time} INTEGER NOT NUll,
    ${TblFormOneField.num_days} INTEGER NOT NUll,
    ${TblFormOneField.num_workers} INTEGER NOT NUll,
    ${TblFormOneField.worker_1} TEXT NOT NUll,
    ${TblFormOneField.cost_of_labor} REAL NOT NUll,
    ${TblFormOneField.type} TEXT NOT NUll
    )
  ''');      
      await query.execute('''
  CREATE TABLE $tableARCPaintingWorks(
    ${TblFormOneField.id} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${TblFormOneField.fk} INTEGER NOT NUll,
    ${TblFormOneField.date_start} TEXT NOT NULL,
    ${TblFormOneField.date_end} TEXT NOT NULL,
    ${TblFormOneField.col_1} TEXT NOT NUll,
    ${TblFormOneField.col_1_val} REAL NOT NUll,
    ${TblFormOneField.col_2} REAL NOT NUll,
    ${TblFormOneField.pref_time} INTEGER NOT NUll,
    ${TblFormOneField.num_days} INTEGER NOT NUll,
    ${TblFormOneField.num_workers} INTEGER NOT NUll,
    ${TblFormOneField.worker_1} TEXT NOT NUll,
    ${TblFormOneField.cost_of_labor} REAL NOT NUll,
    ${TblFormOneField.type} TEXT NOT NUll
    )
  '''); 
      await query.execute('''
  CREATE TABLE $tableSTRFormworks(
    ${TblFormTwoField.id} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${TblFormTwoField.fk} INTEGER NOT NUll,
    ${TblFormTwoField.date_start} TEXT NOT NULL,
    ${TblFormTwoField.date_end} TEXT NOT NULL,
    ${TblFormTwoField.col_1} TEXT NOT NUll,
    ${TblFormTwoField.col_1_val} REAL NOT NUll,
    ${TblFormTwoField.col_2} REAL NOT NUll,
    ${TblFormTwoField.pref_time} INTEGER NOT NUll,
    ${TblFormTwoField.num_days} INTEGER NOT NUll,
    ${TblFormTwoField.num_workers} INTEGER NOT NUll,
    ${TblFormTwoField.worker_1} TEXT NOT NUll,
    ${TblFormTwoField.worker_2} TEXT NOT NUll,    
    ${TblFormTwoField.cost_of_labor} REAL NOT NUll,
    ${TblFormTwoField.type} TEXT NOT NUll
    )
  ''');
      await query.execute('''
  CREATE TABLE $tableSTRMasonry(
    ${TblFormTwoField.id} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${TblFormTwoField.fk} INTEGER NOT NUll,
    ${TblFormTwoField.date_start} TEXT NOT NULL,
    ${TblFormTwoField.date_end} TEXT NOT NULL,
    ${TblFormTwoField.col_1} TEXT NOT NUll,
    ${TblFormTwoField.col_1_val} REAL NOT NUll,
    ${TblFormTwoField.col_2} REAL NOT NUll,
    ${TblFormTwoField.pref_time} INTEGER NOT NUll,
    ${TblFormTwoField.num_days} INTEGER NOT NUll,
    ${TblFormTwoField.num_workers} INTEGER NOT NUll,
    ${TblFormTwoField.worker_1} TEXT NOT NUll,
    ${TblFormTwoField.worker_2} TEXT NOT NUll,    
    ${TblFormTwoField.cost_of_labor} REAL NOT NUll,
    ${TblFormTwoField.type} TEXT NOT NUll
    )
  ''');          
      await query.execute('''
  CREATE TABLE $tableSTRRCC(
    ${TblFormTwoField.id} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${TblFormTwoField.fk} INTEGER NOT NUll,
    ${TblFormTwoField.date_start} TEXT NOT NULL,
    ${TblFormTwoField.date_end} TEXT NOT NULL,
    ${TblFormTwoField.col_1} TEXT NOT NUll,
    ${TblFormTwoField.col_1_val} REAL NOT NUll,
    ${TblFormTwoField.col_2} REAL NOT NUll,
    ${TblFormTwoField.pref_time} INTEGER NOT NUll,
    ${TblFormTwoField.num_days} INTEGER NOT NUll,
    ${TblFormTwoField.num_workers} INTEGER NOT NUll,
    ${TblFormTwoField.worker_1} TEXT NOT NUll,
    ${TblFormTwoField.worker_2} TEXT NOT NUll,    
    ${TblFormTwoField.cost_of_labor} REAL NOT NUll,
    ${TblFormTwoField.type} TEXT NOT NUll
    )
  ''');      
      await query.execute('''
  CREATE TABLE $tableARCFlooring(
    ${TblFormTwoField.id} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${TblFormTwoField.fk} INTEGER NOT NUll,
    ${TblFormTwoField.date_start} TEXT NOT NULL,
    ${TblFormTwoField.date_end} TEXT NOT NULL,
    ${TblFormTwoField.col_1} TEXT NOT NUll,
    ${TblFormTwoField.col_1_val} REAL NOT NUll,
    ${TblFormTwoField.col_2} REAL NOT NUll,
    ${TblFormTwoField.pref_time} INTEGER NOT NUll,
    ${TblFormTwoField.num_days} INTEGER NOT NUll,
    ${TblFormTwoField.num_workers} INTEGER NOT NUll,
    ${TblFormTwoField.worker_1} TEXT NOT NUll,
    ${TblFormTwoField.worker_2} TEXT NOT NUll,    
    ${TblFormTwoField.cost_of_labor} REAL NOT NUll,
    ${TblFormTwoField.type} TEXT NOT NUll
    )
  ''');      
      await query.execute('''
  CREATE TABLE $tableARCPlastering(
    ${TblFormTwoField.id} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${TblFormTwoField.fk} INTEGER NOT NUll,
    ${TblFormTwoField.date_start} TEXT NOT NULL,
    ${TblFormTwoField.date_end} TEXT NOT NULL,
    ${TblFormTwoField.col_1} TEXT NOT NUll,
    ${TblFormTwoField.col_1_val} REAL NOT NUll,
    ${TblFormTwoField.col_2} REAL NOT NUll,
    ${TblFormTwoField.pref_time} INTEGER NOT NUll,
    ${TblFormTwoField.num_days} INTEGER NOT NUll,
    ${TblFormTwoField.num_workers} INTEGER NOT NUll,
    ${TblFormTwoField.worker_1} TEXT NOT NUll,
    ${TblFormTwoField.worker_2} TEXT NOT NUll,    
    ${TblFormTwoField.cost_of_labor} REAL NOT NUll,
    ${TblFormTwoField.type} TEXT NOT NUll
    )
  ''');        
      await query.execute('''
  CREATE TABLE $tableARCCeilings(
    ${TblFormTwoField.id} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${TblFormTwoField.fk} INTEGER NOT NUll,
    ${TblFormTwoField.date_start} TEXT NOT NULL,
    ${TblFormTwoField.date_end} TEXT NOT NULL,
    ${TblFormTwoField.col_1} TEXT NOT NUll,
    ${TblFormTwoField.col_1_val} REAL NOT NUll,
    ${TblFormTwoField.col_2} REAL NOT NUll,
    ${TblFormTwoField.pref_time} INTEGER NOT NUll,
    ${TblFormTwoField.num_days} INTEGER NOT NUll,
    ${TblFormTwoField.num_workers} INTEGER NOT NUll,
    ${TblFormTwoField.worker_1} TEXT NOT NUll,
    ${TblFormTwoField.worker_2} TEXT NOT NUll,    
    ${TblFormTwoField.cost_of_labor} REAL NOT NUll,
    ${TblFormTwoField.type} TEXT NOT NUll
    )
  ''');        
      await query.execute('''
  CREATE TABLE $tableARCRoofing(
    ${TblFormTwoField.id} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${TblFormTwoField.fk} INTEGER NOT NUll,
    ${TblFormTwoField.date_start} TEXT NOT NULL,
    ${TblFormTwoField.date_end} TEXT NOT NULL,
    ${TblFormTwoField.col_1} TEXT NOT NUll,
    ${TblFormTwoField.col_1_val} REAL NOT NUll,
    ${TblFormTwoField.col_2} REAL NOT NUll,
    ${TblFormTwoField.pref_time} INTEGER NOT NUll,
    ${TblFormTwoField.num_days} INTEGER NOT NUll,
    ${TblFormTwoField.num_workers} INTEGER NOT NUll,
    ${TblFormTwoField.worker_1} TEXT NOT NUll,
    ${TblFormTwoField.worker_2} TEXT NOT NUll,    
    ${TblFormTwoField.cost_of_labor} REAL NOT NUll,
    ${TblFormTwoField.type} TEXT NOT NUll
    )
  ''');        
      await query.execute('''
  CREATE TABLE $tableELCPlumbing(
    ${TblFormTwoField.id} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${TblFormTwoField.fk} INTEGER NOT NUll,
    ${TblFormTwoField.date_start} TEXT NOT NULL,
    ${TblFormTwoField.date_end} TEXT NOT NULL,
    ${TblFormTwoField.col_1} TEXT NOT NUll,
    ${TblFormTwoField.col_1_val} REAL NOT NUll,
    ${TblFormTwoField.col_2} REAL NOT NUll,
    ${TblFormTwoField.pref_time} INTEGER NOT NUll,
    ${TblFormTwoField.num_days} INTEGER NOT NUll,
    ${TblFormTwoField.num_workers} INTEGER NOT NUll,
    ${TblFormTwoField.worker_1} TEXT NOT NUll,
    ${TblFormTwoField.worker_2} TEXT NOT NUll,    
    ${TblFormTwoField.cost_of_labor} REAL NOT NUll,
    ${TblFormTwoField.type} TEXT NOT NUll
    )
  ''');        
      await query.execute('''
  CREATE TABLE $tableELCElectrical(
    ${TblFormTwoField.id} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${TblFormTwoField.fk} INTEGER NOT NUll,
    ${TblFormTwoField.date_start} TEXT NOT NULL,
    ${TblFormTwoField.date_end} TEXT NOT NULL,
    ${TblFormTwoField.col_1} TEXT NOT NUll,
    ${TblFormTwoField.col_1_val} REAL NOT NUll,
    ${TblFormTwoField.col_2} REAL NOT NUll,
    ${TblFormTwoField.pref_time} INTEGER NOT NUll,
    ${TblFormTwoField.num_days} INTEGER NOT NUll,
    ${TblFormTwoField.num_workers} INTEGER NOT NUll,
    ${TblFormTwoField.worker_1} TEXT NOT NUll,
    ${TblFormTwoField.worker_2} TEXT NOT NUll,    
    ${TblFormTwoField.cost_of_labor} REAL NOT NUll,
    ${TblFormTwoField.type} TEXT NOT NUll
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

//formOne
    Future createFormOne(FormOne formOne, String tablename,) async {
    final reference = await instance.database;

    //irereturn nito ang Primary key ng table, which is ID
    await reference.insert(tablename, formOne.toJson());
  }

  Future<FormOne> readFormOne(int fk, String type, String tableName) async {
    final reference = await instance.database;

    final specificID = await reference.query(
      tableName,
      columns: TblFormOneField.formOneFieldNames,
      where: '${TblFormOneField.fk} = ? and ${TblFormOneField.type} = ?',
      whereArgs: [fk, type]
    );

    if (specificID.isNotEmpty) {
      return FormOne.fromJson(specificID.first);
    } else {
      throw Exception('no results');
    }
  }

  Future<int> updateFormOne(FormOne formOneInstance, String tableName) async {
    final reference = await instance.database;

    return reference.update(tableName, formOneInstance.toJson(),
        where: '${TblFormOneField.id} = ?', whereArgs: [formOneInstance.id]);
  }

  Future<int> deleteFormOne(int searchKey, String tableName) async {
    final refererence = await instance.database;

    return refererence.delete(tableName,
        where: '${TblFormOneField.id} = ?', whereArgs: [searchKey]);
  }
  
//formTwo
    Future createFormTwo(FormTwo formTwo, String tablename,) async {
    final reference = await instance.database;

    //irereturn nito ang Primary key ng table, which is ID
    await reference.insert(tablename, formTwo.toJson());
  }

  Future<FormTwo> readFormTwo(int fk, String type, String tableName) async {
    final reference = await instance.database;

    final specificID = await reference.query(
      tableName,
      columns: TblFormTwoField.formTwoFieldNames,
      where: '${TblFormTwoField.fk} = ? and ${TblFormTwoField.type} = ?',
      whereArgs: [fk, type]
    );

    if (specificID.isNotEmpty) {
      return FormTwo.fromJson(specificID.first);
    } else {
      throw Exception('no results');
    }
  }

  Future<int> updateFormTwo(FormTwo formTwoInstance, String tableName) async {
    final reference = await instance.database;

    return reference.update(tableName, formTwoInstance.toJson(),
        where: '${TblFormTwoField.id} = ?', whereArgs: [formTwoInstance.id]);
  }

  Future<int> deleteFormTwo(int searchKey, String tableName) async {
    final refererence = await instance.database;

    return refererence.delete(tableName,
        where: '${TblFormTwoField.id} = ?', whereArgs: [searchKey]);
  }      
}