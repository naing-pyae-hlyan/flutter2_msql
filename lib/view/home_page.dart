import 'package:flutter/material.dart';
import 'package:flutter2_mysql/controller/db_controller.dart';
import 'package:flutter2_mysql/models/user_model.dart';
import 'package:flutter2_mysql/view/widget/crud_dialog.dart';
import 'package:flutter2_mysql/view/widget/dialog_utils.dart';
import 'package:flutter2_mysql/view/widget/user_listview.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  Future<void> _insertUser(BuildContext context, UserModel data) async {
    context.read<DbController>().insertUserData(
      data,
      onSuccess: (msg) async {
        DialogUtils.okCancelDialog(context, text: msg);
      },
      onFailure: (msg) async {
        DialogUtils.okCancelDialog(context, text: msg);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sample CRUD'),
        centerTitle: false,
      ),
      body: UserListView(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => openCrudDialog(
          context,
          saveOnPressed: (user) => _insertUser(context, user),
        ),
      ),
    );
  }
}
