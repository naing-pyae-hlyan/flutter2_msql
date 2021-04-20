import 'package:flutter/cupertino.dart';
import 'package:flutter2_mysql/models/user_model.dart';
import 'package:mysql1/mysql1.dart';

const TABLE_NAME = 'users';

class DbServices {
  static final _settings = ConnectionSettings(
    host: 'localhost',
    port: 3306,
    db: 'test',
  );

  static Future<void> insetUserData(
    UserModel data, {
    @required ValueChanged<String> onSuccess,
    @required ValueChanged<String> onFailure,
  }) async {
    MySqlConnection connection;
    try {
      connection = await MySqlConnection.connect(_settings);
    } catch (e) {
      onFailure.call(e.toString());
      return;
    }

    if (connection != null) {
      await connection
          .query(
            'INSERT INTO $TABLE_NAME'
            '(name, email, age)'
            'value (?, ?, ?)',
            ['${data.name}', '${data.email}', int.parse(data.age)],
          )
          .then((value) => onSuccess.call('Success'))
          .onError(
            (error, stackTrace) => onFailure.call(error.toString()),
          );
    }
    connection.close();
  }

  static Future<dynamic> get getUsers async {
    MySqlConnection connection;
    try {
      connection = await MySqlConnection.connect(_settings);
    } catch (e) {
      return e.toString();
    }

    if (connection != null) {
      var result;

      try {
        result = await connection.query(
          'SELECT * FROM $TABLE_NAME',
        );

        return result;
      } catch (e) {
        return e.toString();
      }
    }

    connection.close();
  }

  static Future<void> updateUser(
    int id, {
    @required UserModel data,
    @required ValueChanged<String> onSuccess,
    @required ValueChanged<String> onFailure,
  }) async {
    MySqlConnection connection;
    try {
      connection = await MySqlConnection.connect(_settings);
    } catch (e) {
      onFailure.call(e.toString());
      return;
    }

    var d = 'UPDATE $TABLE_NAME'
        'SET name = hello'
        'WHERE id = 1';

    if (connection != null) {
      await connection
          .query("UPDATE $TABLE_NAME "
              "SET name = '${data.name}', email = '${data.email}', age = '${int.parse(data.age)}' "
              "WHERE id = $id")
          .then((value) => onSuccess.call('Success'))
          .onError(
            (error, stackTrace) => onFailure.call(error.toString()),
          );
    }

    connection.close();
  }
}
