// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keyword.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Keyword _$KeywordFromJson(Map<String, dynamic> json) {
  return Keyword()
    ..currentPage = json['current_page'] as num
    ..data = (json['data'] as List)
        ?.map((e) =>
            e == null ? null : KeywordData.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..lastPage = json['last_page'] as num;
}

Map<String, dynamic> _$KeywordToJson(Keyword instance) => <String, dynamic>{
      'current_page': instance.currentPage,
      'data': instance.data,
      'last_page': instance.lastPage
    };
