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
}

//  Future<void> _getConnection(BuildContext context) async {
//     var settings = new ConnectionSettings(
//       host: 'localhost',
//       port: 3306,
//       db: 'test',
//     );
//
//     var conn;
//     try {
//       conn = await MySqlConnection.connect(settings);
//       print('Success');
//     } catch (e) {
//       print(e.toString());
//     }
//
//     // create a table
//     // await conn.query(
//     //   'CREATE TABLE users (id int NOT NULL AUTO_INCREMENT PRIMARY KEY,'
//     //   'name varchar(255),'
//     //   'email varchar(255),'
//     //   'age int)',
//     // );
//
//     // Insert some data
//     // var result = await conn.query(
//     //   'INSERT INTO users (name, email, age) value (?, ?, ?)',
//     //   ['Bob', 'bob@bob.com', 25],
//     // );
//     // print('Inserted row id=${result.insertId}');
//     //
//     // // Query the db using a param query
//     // var results = await conn.query(
//     //   'SELECT name, email, age FROM users WHERE id = ?',
//     //   [result.insertId],
//     // );
//     //
//     // for (var row in results) {
//     //   print('Name: ${row[0]}, Email: ${row[1]}, Age: ${row[2]}');
//     // }
//     //
//     // // update some data
//     // await conn.query(
//     //   'UPDATE users set age=? WHERE name=?',
//     //   [26, 'Bob'],
//     // );
//     //
//     // // Query again db using param
//     // var results2 = await conn.query(
//     //   'SELECT name, email, age FROM users WHERE id = ?',
//     //   [result.insertId],
//     // );
//     //
//     // for (var row in results2) {
//     //   print('Name: ${row[0]}, Email: ${row[1]}, Age: ${row[2]}');
//     // }
//
//     // finally, close connection
//     await conn.close();
//   }
