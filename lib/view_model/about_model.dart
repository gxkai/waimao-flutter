import 'package:waimao/provider/view_state_plain_model.dart';

import '../main.dart';

class AboutModel extends ViewStatePlainModel {
  String _version;
  String get version => _version;
  @override
  Future loadData()  async {
    _version = await sp.get('version');
  }
}