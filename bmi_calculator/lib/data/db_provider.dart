import 'package:bmi_calculator/data/models/bmi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  final tableName = 'bmi_table';
  final idColumn = '_id';
  final dateColumn = 'date';
  final ageColumn = 'age';
  final genderColumn = 'gender';
  final bmiColumn = 'bmi';
  final bmiPrimeColumn = 'bmi_prime';
  final categoryNumberColumn = 'category_number';
  final categoryColumn = 'category';

  // bmi table
  // id | date | age | gender | bmi | bmi_prime | category_number | category
  // 0    ''      ''    ''      ''      ''          ''                ''
  // 1    ''      ''    ''      ''      ''          ''                ''

  static final DBProvider instance = DBProvider._instance();
  Database? _db;

  DBProvider._instance();

  Future<Database> get db async {
    if (_db != null) return _db!;

    _db = await initDB('bmi.db');
    return _db!;
  }

  Future<Database> initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    db.execute(
      'CREATE TABLE $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $dateColumn TEXT, $ageColumn INTEGER, $genderColumn TEXT, $bmiColumn REAL, $bmiPrimeColumn REAL, $categoryNumberColumn INTEGER, $categoryColumn TEXT)',
    );
  }

  Future<List<Bmi>> getAllBmi() async {
    Database db = await instance.db;
    List<Map<String, dynamic>> mapList = await db.query(tableName);
    return mapList.map((e) => Bmi.fromMap(e)).toList();
  }

  Future<int> insertBmi(Map<String, dynamic> bmi) async {
    Database db = await instance.db;
    return db.insert(tableName, bmi);
  }

  Future<int> deleteBmi(int id) async {
    Database db = await instance.db;
    return db.delete(tableName, where: '$idColumn = ?', whereArgs: [id]);
  }

  Future<int> deleteAllBmi() async {
    Database db = await instance.db;
    return db.delete(tableName);
  }
}
