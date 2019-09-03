// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboardKeyword.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardKeyword _$DashboardKeywordFromJson(Map<String, dynamic> json) {
  return DashboardKeyword()
    ..page1 = json['page1'] as num
    ..page2 = json['page2'] as num
    ..page3 = json['page3'] as num
    ..keywordCount = json['_count'] as num;
}

Map<String, dynamic> _$DashboardKeywordToJson(DashboardKeyword instance) =>
    <String, dynamic>{
      'page1': instance.page1,
      'page2': instance.page2,
      'page3': instance.page3,
      '_count': instance.keywordCount
    };
