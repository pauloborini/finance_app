import 'package:sqflite/sqflite.dart';
import '../models/user.dart';
import 'database.dart';

class UserDao {
  static const String tableSql3 = 'CREATE TABLE $_userTable('
      '$_id TEXT, '
      '$_name TEXT, '
      '$_email TEXT, '
      '$_password TEXT)';

  static const String _userTable = 'userTable';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _email = 'email';
  static const String _password = 'password';

  save(User user) async {
    final Database dataBaseUser = await getDatabase4();
    var itemExists = await find(user.name);
    if (itemExists.isEmpty) {
      return await dataBaseUser.insert(_userTable, _toMap(user));
    } else {
      return await dataBaseUser.update(_userTable, _toMap(user),
          where: '$_name = ?', whereArgs: [user.name]);
    }
  }

  Future<List<User>> findAll() async {
    final Database dataBaseUser = await getDatabase4();
    final List<Map<String, dynamic>> result =
        await dataBaseUser.query(_userTable);
    return toList(result);
  }

  Future<List<User>> find(String selectedName) async {
    final Database dataBaseUser = await getDatabase4();
    final List<Map<String, dynamic>> result = await dataBaseUser
        .query(_userTable, where: '$_name = ?', whereArgs: [selectedName]);
    return toList(result);
  }

  delete(String name) async {
    final Database dataBaseUser = await getDatabase4();
    return dataBaseUser
        .delete(_userTable, where: '$_name = ?', whereArgs: [name]);
  }

  List<User> toList(List<Map<String, dynamic>> userList) {
    final List<User> users = [];
    for (Map<String, dynamic> row in userList) {
      final User user =
          User(id: row[_id],
              name: row[_name], email: row[_email], password: row[_password]);
      users.add(user);
    }
    return users;
  }

  Map<String, dynamic> _toMap(User user) {
    final Map<String, dynamic> userMap = {};
    userMap[_id] = user.id;
    userMap[_name] = user.name;
    userMap[_email] = user.email;
    userMap[_password] = user.password;
    return userMap;
  }
}
