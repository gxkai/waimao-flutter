// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboardMessage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardMessage _$DashboardMessageFromJson(Map<String, dynamic> json) {
  return DashboardMessage()
    ..unread = json['unread'] as num
    ..read = json['read'] as num
    ..messageCount = json['_count'] as num;
}

Map<String, dynamic> _$DashboardMessageToJson(DashboardMessage instance) =>
    <String, dynamic>{
      'unread': instance.unread,
      'read': instance.read,
      '_count': instance.messageCount
    };
