// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keyword.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Keyword _$KeywordFromJson(Map<String, dynamic> json) {
  return Keyword()
    ..current_page = json['current_page'] as num
    ..data = (json['data'] as List)
        ?.map((e) =>
            e == null ? null : KeywordData.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..last_page = json['last_page'] as num;
}

Map<String, dynamic> _$KeywordToJson(Keyword instance) => <String, dynamic>{
      'current_page': instance.current_page,
      'data': instance.data,
      'last_page': instance.last_page
    };
