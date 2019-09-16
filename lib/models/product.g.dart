// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product()
    ..name = json['name'] as String
    ..package = json['package'] as String
    ..startedAt = json['started_at'] as String
    ..year = json['year'] as num;
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'name': instance.name,
      'package': instance.package,
      'started_at': instance.startedAt,
      'year': instance.year
    };
