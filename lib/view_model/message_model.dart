import 'package:waimao/model/message.dart';
import 'package:waimao/provider/view_state_refresh_list_model.dart';
import 'package:waimao/utils/data_utils.dart';

class MessageModel extends ViewStateRefreshListModel<Message> {
  final num _type;
  int pageSize = 12;
  MessageModel(this._type);
  Future<List<Message>> loadData({int pageNum}) async {
    return await DataUtils.message({'type': _type, 'page': pageNum, 'limit': pageSize});
  }
}