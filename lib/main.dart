import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:public_open_api_mvvm/repository/store_repository.dart';
import 'package:public_open_api_mvvm/viewmodel/store_model.dart';

import 'model/store.dart';

void main() {
  runApp(ChangeNotifierProvider.value(
    value: StoreModel(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var isLoading = false;

  @override
  void initState() {
    super.initState();

    // setState(() {
    //   isLoading = true;
    // });
  }

  @override
  Widget build(BuildContext context) {
    final storeModel = Provider.of<StoreModel>(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('마스크 재고 있는 곳 : '
            '${storeModel.stores.where((element) => element.remainStat == 'plenty' || element.remainStat == 'some' || element.remainStat == 'few').length}곳'),
        actions: [
          IconButton(
              onPressed: storeModel.fetch, icon: const Icon(Icons.refresh))
        ],
      ),
      body: isLoading
          ? loadingWidget()
          : Center(
              child: ListView(
              children: storeModel.stores
                  .where((element) =>
                      element.remainStat == 'plenty' ||
                      element.remainStat == 'some' ||
                      element.remainStat == 'few')
                  .map((e) {
                return ListTile(
                  title: Text(e.name),
                  subtitle: Text(e.addr),
                  trailing: _buildRemainStatWidget(e),
                );
              }).toList(),
            )),
    );
  }

  Widget _buildRemainStatWidget(Store store) {
    var remainStat = '판매중지';
    var description = '판매중지';
    var color = Colors.black;

    switch (store.remainStat) {
      case 'plenty':
        remainStat = '충분';
        description = '100개 이상';
        color = Colors.green;
        break;
      case 'some':
        remainStat = '보통';
        description = '30 ~ 100개';
        color = Colors.yellow;
        break;
      case 'few':
        remainStat = '부족';
        description = '2 ~ 30개';
        color = Colors.red;
        break;
      case 'empty':
        remainStat = '소진임박';
        description = '1개 이하';
        color = Colors.grey;
        break;
    }

    return Column(
      children: [
        Text(remainStat,
            style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        Text(description, style: TextStyle(color: color)),
      ],
    );
  }

  Widget loadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [Text('정보를 가져오는 중'), CircularProgressIndicator()],
      ),
    );
  }
}
