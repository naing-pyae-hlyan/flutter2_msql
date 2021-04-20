import 'package:flutter/foundation.dart';
import 'package:flutter2_mysql/models/user_model.dart';
import 'package:flutter2_mysql/services/db_services.dart';

class DbController with ChangeNotifier {
  Future<void> insertUserData(
    UserModel data, {
    @required ValueChanged<String> onSuccess,
    @required ValueChanged<String> onFailure,
  }) async {
    await DbServices.insetUserData(
      data,
      onSuccess: onSuccess,
      onFailure: onFailure,
    );
    notifyListeners();
  }

  Future<void> get getUsers => DbServices.getUsers;
}
