import 'package:sqflite/sqflite.dart';
import '../models/dream.dart';
import 'database.dart';

class DreamDao {
  static const String tableSql3 = 'CREATE TABLE $_dreamTable('
      '$_id TEXT, '
      '$_title TEXT, '
      '$_value REAL)';

  static const String _dreamTable = 'dreamTable';
  static const String _id = 'id';
  static const String _title = 'title';
  static const String _value = 'value';

  save(Dream dream) async {
    final Database dataBaseDream = await getDatabase3();
    var itemExists = await find(dream.title);
    if (itemExists.isEmpty) {
      return await dataBaseDream.insert(_dreamTable, _toMap(dream));
    } else {
      return await dataBaseDream.update(_dreamTable, _toMap(dream),
          where: '$_title = ?', whereArgs: [dream.title]);
    }
  }

  Future<List<Dream>> findAll() async {
    final Database dataBaseDream = await getDatabase3();
    final List<Map<String, dynamic>> result =
    await dataBaseDream.query(_dreamTable);
    return toList(result);
  }

  Future<List<Dream>> find(String selectedTitle) async {
    final Database dataBaseDream = await getDatabase3();
    final List<Map<String, dynamic>> result = await dataBaseDream.query(
        _dreamTable,
        where: '$_title = ?',
        whereArgs: [selectedTitle]);
    return toList(result);
  }

  delete(String title) async {
    final Database dataBaseDream = await getDatabase3();
    return dataBaseDream.delete(_dreamTable,
        where: '$_title = ?', whereArgs: [title]);
  }

  List<Dream> toList(List<Map<String, dynamic>> dreamsList) {
    final List<Dream> dreams = [];
    for (Map<String, dynamic> row in dreamsList) {
      final Dream dream = Dream(
        id: row[_id],
        title: row[_title],
        value: row[_value],
      );
      dreams.add(dream);
    }
    return dreams;
  }

  Map<String, dynamic> _toMap(Dream dream) {
    final Map<String, dynamic> dreamMap = {};
    dreamMap[_id] = dream.id;
    dreamMap[_title] = dream.title;
    dreamMap[_value] = dream.value;
    return dreamMap;
  }
}
