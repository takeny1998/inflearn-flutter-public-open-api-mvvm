import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:public_open_api_mvvm/view/widget/remain_stat_list_tile.dart';
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
            '${storeModel.stores.length}곳'),
        actions: [
          IconButton(
              onPressed: storeModel.fetch, icon: const Icon(Icons.refresh))
        ],
      ),
      body: storeModel.isLoading
          ? loadingWidget()
          : Center(
              child: ListView(
              children: storeModel.stores.map((e) {
                return RemainStatListTile(e);
              }).toList(),
            )),
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
