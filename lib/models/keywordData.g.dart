// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keywordData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeywordData _$KeywordDataFromJson(Map<String, dynamic> json) {
  return KeywordData()
    ..page = json['page'] as num
    ..number = json['num'] as num
    ..keyword = json['keyword'] as String;
}

Map<String, dynamic> _$KeywordDataToJson(KeywordData instance) =>
    <String, dynamic>{
      'page': instance.page,
      'num': instance.number,
      'keyword': instance.keyword
    };
