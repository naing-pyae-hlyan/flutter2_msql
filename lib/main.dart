import 'package:flutter/material.dart';
import 'package:flutter2_mysql/controller/db_controller.dart';
import 'package:flutter2_mysql/view/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DbController()),
      ],
      child: MaterialApp(
        title: 'SQL test',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: HomePage(),
      ),
    );
  }
}
