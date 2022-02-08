import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:sqlbrite/sqlbrite.dart';
import 'package:path/path.dart';
import '../extension/extension.dart';

class MCSDBService {

  Database? _db;
  final String dbName = 'mcs_platform.db';
  final int version = 1;

  // final String createVersionTable = 'CREATE TABLE IF NOT EXISTS tb_version (id INTEGER PRIMARY KEY AUTOINCREMENT, version INTEGER DEFAULT 1)';
  final String createVisualTable = 'CREATE TABLE IF NOT EXISTS $visualTableName (id INTEGER PRIMARY KEY AUTOINCREMENT, version INTEGER, useable INTEGER, productId TEXT, guid TEXT, mcs_visual TEXT)';
  final String createAccountTable = 'CREATE TABLE IF NOT EXISTS $accountTableName (id INTEGER PRIMARY KEY AUTOINCREMENT, userId TEXT, password TEXT, nickname TEXT, headUrl TEXT, active INTEGER, timestamp INTEGER, accessToken TEXT, refreshToken TEXT, expire INTEGER)';

  static final MCSDBService singleton = MCSDBService._();
  MCSDBService._() {}

  Future<void> openDB() async {
    String dir = await getDatabasesPath();
    String path = join(dir, dbName);
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // 1. 创建tb_version表
        // await db.execute(createVersionTable);
        // 2. 创建tb_visual表
        await db.execute(createVisualTable);
        // 3. 创建tb_user表
        await db.execute(createAccountTable);
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        for (int i = oldVersion + 1; i <= newVersion; i++) {
          switch(i) {
            // onUpgrade
          }
        }
      }
    );
    return Future.value(null);
  }

  void closeDB() {
    _db?.close();
  }

  Future<bool> insert(String table, Map<String, Object?> values) async {
    if (_db == null || !_db!.isOpen) {
      await openDB();
    }

    int id = await _db?.insert(table, values.convertBoolToInt()) ?? 0;
    return Future.value(id != 0);
  }

  Future<int> delete(String table, {String? where, List<Object?>? whereArgs}) async {
    if (_db == null || !_db!.isOpen) {
      await openDB();
    }
    return _db?.delete(table, where: where, whereArgs: whereArgs) ?? Future.value(0);
  }

  Future<List<Map<String, Object?>>> query(String table,
      {bool? distinct,
        List<String>? columns,
        String? where,
        List<Object?>? whereArgs,
        String? groupBy,
        String? having,
        String? orderBy,
        int? limit,
        int? offset}) async {
    if (_db == null || !_db!.isOpen) {
      await openDB();
    }
    return _db?.query(
      table,
      distinct: distinct,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      groupBy: groupBy,
      having: having,
      orderBy: orderBy,
      limit: limit,
      offset: offset
    ) ?? Future.value([]);
  }

  Future<int> update(String table, Map<String, Object?> values,
      {String? where,
        List<Object?>? whereArgs}) async {
    if (_db == null || !_db!.isOpen) {
      await openDB();
    }
    return _db?.update(table, values.convertBoolToInt(), where: where, whereArgs: whereArgs) ?? Future.value(0);
  }
}