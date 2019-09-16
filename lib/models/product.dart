import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
    Product();

    String name;
    String package;
    @JsonKey(name: 'started_at') String startedAt;
    num year;
    
    factory Product.fromJson(Map<String,dynamic> json) => _$ProductFromJson(json);
    Map<String, dynamic> toJson() => _$ProductToJson(this);
}
