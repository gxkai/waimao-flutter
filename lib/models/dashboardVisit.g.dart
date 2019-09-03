// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboardVisit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardVisit _$DashboardVisitFromJson(Map<String, dynamic> json) {
  return DashboardVisit()
    ..key = json['key'] as String
    ..pv = json['pv'] as num
    ..uv = json['uv'] as num;
}

Map<String, dynamic> _$DashboardVisitToJson(DashboardVisit instance) =>
    <String, dynamic>{
      'key': instance.key,
      'pv': instance.pv,
      'uv': instance.uv
    };
