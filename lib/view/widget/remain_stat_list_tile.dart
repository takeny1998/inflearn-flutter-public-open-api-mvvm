import 'package:flutter/material.dart';
import 'package:public_open_api_mvvm/model/store.dart';
import 'package:url_launcher/url_launcher.dart';

class RemainStatListTile extends StatelessWidget {
  final Store store;
  const RemainStatListTile(this.store);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      title: Text(store.name),
      subtitle: Text(store.addr),
      trailing: _buildRemainStatWidget(store),
      onTap: () {
        _launchURL(store.lat, store.lng);
      },
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

  _launchURL(double lat, double lng) async {
    final url = 'https://google.com/maps/search/?api=1&query=$lat,$lng';
    print(url);
    await launch(url);
  }

}