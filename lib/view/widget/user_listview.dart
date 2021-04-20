import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter2_mysql/controller/db_controller.dart';
import 'package:flutter2_mysql/models/user_model.dart';
import 'package:provider/provider.dart';

class UserListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DbController>(
      builder: (context, controller, child) {
        return _futureListView(context, controller);
      },
    );
  }

  Widget _futureListView(BuildContext context, DbController controller) {
    return FutureBuilder(
      future: controller.getUsers,
      builder: (context, snapshot) {
        if (snapshot.hasError) return Center(child: Text('${snapshot.error}'));

        if (snapshot.hasData) {
          return GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            childAspectRatio: 1.6,
            children: [
              for (var data in snapshot.data)
                _listTiles(
                  data['id'],
                  UserModel(
                    data['name'],
                    data['email'],
                    data['age'].toString(),
                  ),
                ),
            ],
          );
        }

        return LinearProgressIndicator();
      },
    );
  }

  Widget _listTiles(int id, UserModel data) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.blueGrey,
      ),
      child: Wrap(
        direction: Axis.vertical,
        runAlignment: WrapAlignment.spaceBetween,
        children: <Widget>[
          _softText('$id'),
          _softText(data.name),
          _softText(data.email),
          _softText(data.age),
        ],
      ),
    );
  }

  Widget _softText(String text) => AutoSizeText(
        text,
        softWrap: true,
        maxLines: 1,
        minFontSize: 1,
        overflow: TextOverflow.ellipsis,
      );
}
