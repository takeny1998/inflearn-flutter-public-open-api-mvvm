import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:public_open_api_mvvm/view/page/main_page.dart';
import 'package:public_open_api_mvvm/viewmodel/store_model.dart';


void main() {
  runApp(ChangeNotifierProvider.value(
    value: StoreModel(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}

