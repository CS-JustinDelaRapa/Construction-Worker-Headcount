import 'package:engineering/screens/mainProject/architectural/items/bungalowArchitecturalItem.dart';
import 'package:engineering/screens/mainProject/electricalAndPlumbing/items/electricalAndPlumbingItem.dart';
import 'package:engineering/screens/mainProject/structural/items/bungalowStructuralItem.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/ProjectModel.dart';
import '../model/formModel.dart';
import '../model/workerModel.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper();

  static Database? _database;

  int count=0;

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
    ${TblWorkerField.workerType} TEXT NOT NUll,
    ${TblWorkerField.rate} REAL NOT NUll,
    ${TblWorkerField.fk} INTEGER NOT NUll    
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
    ${TblFormDataField.date_start} TEXT,
    ${TblFormDataField.date_end} TEXT,
    ${TblFormDataField.col_1} TEXT NOT NUll,
    ${TblFormDataField.col_1_val} REAL NOT NUll,
    ${TblFormDataField.col_2} REAL,
    ${TblFormDataField.pref_time} INTEGER,
    ${TblFormDataField.num_days} INTEGER,
    ${TblFormDataField.num_workers} INTEGER,
    ${TblFormDataField.worker_1} INTEGER,
    ${TblFormDataField.worker_2} INTEGER,    
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

    createDefaultWorkers(id);
    if(projectItem.type == "Bungalow"){
    createDefaultProductivityRateBunagalow(id);
    }else{
      //create two storey
    }

    return id;
  }

  Future<List<ProjectItem>> readAllProject() async {
    final reference = await instance.database;

    //SELECT * FROM tbl_diary ORDER BY dateTime
    final fromTable = await reference.query(tableProject,
        orderBy: '${TblProjectField.id} DESC');
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

    print(count);
    count++;

    //irereturn nito ang Primary key ng table, which is ID
    await reference.insert(tableAllData, formTwo.toJson());
  }

  Future<FormData?> readFormData(int fk, String type, String work) async {
    final reference = await instance.database;

    final specificID = await reference.query(tableAllData,
        columns: TblFormDataField.formTwoFieldNames,
        where:
            '${TblFormDataField.fk} = ? and ${TblFormDataField.work} = ? and ${TblFormDataField.type} = ?',
        whereArgs: [fk, type, work]);

    if (specificID.isNotEmpty) {
      return FormData.fromJson(specificID.first);
    } else {
      return null;
    }
  }

  Future<FormData?> readAllFormData(int fk) async {
    final reference = await instance.database;

    final specificID = await reference.query(tableAllData,
        columns: TblFormDataField.formTwoFieldNames,
        where:
            '${TblFormDataField.fk} = ?',
        whereArgs: [fk]);

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
    final fromTable = await reference.query(tableProject,
        orderBy: '${TblWorkerField.id} DESC');
    return fromTable.map((fromSQL) => WorkerType.fromJson(fromSQL)).toList();
  }

  Future<List<WorkerType>> readWorkers(int fk) async {
    final reference = await instance.database;

    final specificID = await reference.query(tableWorker,
        columns: TblWorkerField.workerFieldNames,
        where: '${TblWorkerField.fk} = ?',
        whereArgs: [fk]);

    return specificID.map((fromSQL) => WorkerType.fromJson(fromSQL)).toList();
  }

  Future<int> updateWorker(WorkerType workerInstance) async {
    final reference = await instance.database;

    return reference.update(tableWorker, workerInstance.toJson(),
        where: '${TblWorkerField.id} = ?', whereArgs: [workerInstance.id]);
  }

    Future createDefaultWorkers(int fk) async {
    List<WorkerType> defaultWorker = [
      WorkerType(workerType: 'CARPENTER', rate: 600, fk: fk),
      WorkerType(workerType: 'LABORER', rate: 400, fk: fk),
      WorkerType(workerType: 'MASON', rate: 550, fk: fk),
      WorkerType(workerType: 'STEEL MAN', rate: 550, fk: fk),
      WorkerType(workerType: 'PAINTER', rate: 600, fk: fk),
      WorkerType(workerType: 'TILE MAN', rate: 600, fk: fk),
      WorkerType(workerType: 'DOOR INSTALLER', rate: 500, fk: fk),
      WorkerType(workerType: 'WINDOW INSTALLER', rate: 500, fk: fk),
      WorkerType(workerType: 'ELECTRICIAN', rate: 600, fk: fk),
      WorkerType(workerType: 'PLUMBER', rate: 550, fk: fk),
      WorkerType(workerType: 'WELDER', rate: 600, fk: fk),
      WorkerType(workerType: 'TINSMITH', rate: 600, fk: fk),
    ];

    for (int x = 0; x < defaultWorker.length; x++) {
      await createWorker(defaultWorker[x]);
    }
  }

//Bungalow
    Future createDefaultProductivityRateBunagalow(int fk) async {
    List<FormData> defaultFormData = [];

//**
//structural works
// */
//earthworks
    for(int x = 0; x < BungalowStructuralItems.listEarthWorks.length; x++ ){
      defaultFormData.add(FormData(fk: fk, 
              col_1: BungalowStructuralItems.defValEarthworks[x].col_1,
              col_1_val: BungalowStructuralItems.defValEarthworks[x].col_1_val,
              type: BungalowStructuralItems.listEarthWorks[x],
              work: BungalowStructuralItems.earthWorks.title));
    }

//formworks
    for(int x = 0; x < BungalowStructuralItems.listFormWorks.length; x++ ){
      defaultFormData.add(FormData(fk: fk, 
              col_1: BungalowStructuralItems.defValFormworks[x].col_1,
              col_1_val: BungalowStructuralItems.defValFormworks[x].col_1_val,
              type: BungalowStructuralItems.listFormWorks[x],
              work: BungalowStructuralItems.formWorks.title));
    }

//masonry works
    for(int x = 0; x < BungalowStructuralItems.listMasonryWorks.length; x++ ){
      
      defaultFormData.add(FormData(fk: fk, 
              col_1: BungalowStructuralItems.defValMasonry[x].col_1,
              col_1_val: BungalowStructuralItems.defValMasonry[x].col_1_val,
              type: BungalowStructuralItems.listMasonryWorks[x],
              work: BungalowStructuralItems.masonryWorks.title));
    }

//reinforecedWorks
    for(int x = 0; x < BungalowStructuralItems.listReinforecedWorks.length; x++ ){
      
      defaultFormData.add(FormData(fk: fk, 
              col_1: BungalowStructuralItems.defValRCC[x].col_1,
              col_1_val: BungalowStructuralItems.defValRCC[x].col_1_val,
              type: BungalowStructuralItems.listReinforecedWorks[x],
              work: BungalowStructuralItems.reiforecedCementConcrete.title));
    }

//reinforecedWorks
    for(int x = 0; x < BungalowStructuralItems.listSteelReinforecedWorks.length; x++ ){
      
      defaultFormData.add(FormData(fk: fk, 
              col_1: BungalowStructuralItems.defValSRW[x].col_1,
              col_1_val: BungalowStructuralItems.defValSRW[x].col_1_val,
              type: BungalowStructuralItems.listSteelReinforecedWorks[x],
              work: BungalowStructuralItems.steelReinforcedmentWork.title));
    }

//**
//Architectural works
// */

//flooring
    for(int x = 0; x < BungalowArchitechturalItems.listFlooringWorks.length; x++ ){
      
      defaultFormData.add(FormData(fk: fk, 
              col_1: BungalowArchitechturalItems.defValFlooringWorks[x].col_1,
              col_1_val: BungalowArchitechturalItems.defValFlooringWorks[x].col_1_val,
              type: BungalowArchitechturalItems.listFlooringWorks[x],
              work: BungalowArchitechturalItems.flooring.title));
    }

//plastering
    for(int x = 0; x < BungalowArchitechturalItems.listPlasteringWorks.length; x++ ){
      
      defaultFormData.add(FormData(fk: fk, 
              col_1: BungalowArchitechturalItems.defValPlasteringWorks[x].col_1,
              col_1_val: BungalowArchitechturalItems.defValPlasteringWorks[x].col_1_val,
              type: BungalowArchitechturalItems.listPlasteringWorks[x],
              work: BungalowArchitechturalItems.plastering.title));
    }

//painting
    for(int x = 0; x < BungalowArchitechturalItems.listPaintingWorks.length; x++ ){
      
      defaultFormData.add(FormData(fk: fk, 
              col_1: BungalowArchitechturalItems.defValPaintingWorks[x].col_1,
              col_1_val: BungalowArchitechturalItems.defValPaintingWorks[x].col_1_val,
              type: BungalowArchitechturalItems.listPaintingWorks[x],
              work: BungalowArchitechturalItems.paintingWorks.title));
    }

//doors and window
    for(int x = 0; x < BungalowArchitechturalItems.listDoornWindowsWorks.length; x++ ){
      
      defaultFormData.add(FormData(fk: fk, 
              col_1: BungalowArchitechturalItems.defValDoorsAndWindowsWorks[x].col_1,
              col_1_val: BungalowArchitechturalItems.defValDoorsAndWindowsWorks[x].col_1_val,
              type: BungalowArchitechturalItems.listDoornWindowsWorks[x],
              work: BungalowArchitechturalItems.doorsAndWindows.title));
    }

//ceiling
    for(int x = 0; x < BungalowArchitechturalItems.listCeilingWorks.length; x++ ){
      
      defaultFormData.add(FormData(fk: fk, 
              col_1: BungalowArchitechturalItems.defValCeilingWorks[x].col_1,
              col_1_val: BungalowArchitechturalItems.defValCeilingWorks[x].col_1_val,
              type: BungalowArchitechturalItems.listCeilingWorks[x],
              work: BungalowArchitechturalItems.ceiling.title));
    }

//roof
    for(int x = 0; x < BungalowArchitechturalItems.listRoofingWorks.length; x++ ){
      
      defaultFormData.add(FormData(fk: fk, 
              col_1: BungalowArchitechturalItems.defValRoofingngWorks[x].col_1,
              col_1_val: BungalowArchitechturalItems.defValRoofingngWorks[x].col_1_val,
              type: BungalowArchitechturalItems.listRoofingWorks[x],
              work: BungalowArchitechturalItems.roofingWorks.title));
    }

//**
//Electrical works
// */

//roof
    for(int x = 0; x < ElectricalAndPlumbingItems.listPlumbingWorks.length; x++ ){
      
      defaultFormData.add(FormData(fk: fk, 
              col_1: ElectricalAndPlumbingItems.defValPlumbingWorks[x].col_1,
              col_1_val: ElectricalAndPlumbingItems.defValPlumbingWorks[x].col_1_val,
              type: ElectricalAndPlumbingItems.listPlumbingWorks[x],
              work: ElectricalAndPlumbingItems.plumbingWorks.title));
    }

//electrical
    for(int x = 0; x < ElectricalAndPlumbingItems.listElectricalWorks.length; x++ ){
      
      defaultFormData.add(FormData(fk: fk, 
              col_1: ElectricalAndPlumbingItems.defValElectricalWorks[x].col_1,
              col_1_val: ElectricalAndPlumbingItems.defValElectricalWorks[x].col_1_val,
              type: ElectricalAndPlumbingItems.listElectricalWorks[x],
              work: ElectricalAndPlumbingItems.electricalWorks.title));
    }

//insert into formtable
    for (int x = 0; x < defaultFormData.length; x++) {
      await createFormData(defaultFormData[x]);
    }
    
  }
}
