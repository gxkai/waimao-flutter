// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dashboard _$DashboardFromJson(Map<String, dynamic> json) {
  return Dashboard()
    ..message = json['message'] == null
        ? null
        : DashboardMessage.fromJson(json['message'] as Map<String, dynamic>)
    ..keyword = json['keyword'] == null
        ? null
        : DashboardKeyword.fromJson(json['keyword'] as Map<String, dynamic>)
    ..visit = json['visit'] == null
        ? null
        : DashboardVisit.fromJson(json['visit'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DashboardToJson(Dashboard instance) => <String, dynamic>{
      'message': instance.message,
      'keyword': instance.keyword,
      'visit': instance.visit
    };
