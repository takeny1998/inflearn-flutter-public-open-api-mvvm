import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:public_open_api_mvvm/model/store.dart';
import 'package:public_open_api_mvvm/viewmodel/store_model.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key key}) : super(key: key);

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
      body: storeModel.isLoading
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
