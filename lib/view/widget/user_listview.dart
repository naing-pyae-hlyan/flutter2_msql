import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter2_mysql/controller/db_controller.dart';
import 'package:flutter2_mysql/models/user_model.dart';
import 'package:provider/provider.dart';

class UserListView extends StatelessWidget {
  static double mainWidth = 0.0;
  static double width = 0.0;

  @override
  Widget build(BuildContext context) {
    mainWidth = MediaQuery.of(context).size.width;
    width = mainWidth / 6;

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
          return ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
      ),
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          _softText('$id.', width / 7),
          _softText(data.name, width),
          _softText(data.email, width),
          _softText(data.age, width / 7),
          _textButton('Edit', width, icon: Icons.edit, onPressed: () {}),
          _textButton('Delete', width, icon: Icons.delete, onPressed: () {}),
        ],
      ),
    );
  }

  Widget _softText(String text, double width) => Container(
        width: width,
        child: AutoSizeText(
          text,
          softWrap: true,
          maxLines: 1,
          minFontSize: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );

  Widget _textButton(
    String text,
    double width, {
    @required IconData icon,
    @required VoidCallback onPressed,
  }) =>
      TextButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 18),
        label: _softText(text, width / 2.5),
      );
}
