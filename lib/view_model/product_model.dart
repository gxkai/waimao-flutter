
import 'package:waimao/models/product.dart';
import 'package:waimao/provider/view_state_plain_model.dart';
import 'package:waimao/utils/data_utils.dart';



class ProductModel extends ViewStatePlainModel {
  Product _product;
  Product get product => _product;
  @override
  Future loadData() async {
    _product = await DataUtils.myProduct();
  }
}