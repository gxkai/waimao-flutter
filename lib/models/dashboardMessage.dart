import 'package:json_annotation/json_annotation.dart';

part 'dashboardMessage.g.dart';

@JsonSerializable()
class DashboardMessage {
    DashboardMessage();

    num unread;
    num read;
    @JsonKey(name: '_count') num messageCount;
    
    factory DashboardMessage.fromJson(Map<String,dynamic> json) => _$DashboardMessageFromJson(json);
    Map<String, dynamic> toJson() => _$DashboardMessageToJson(this);
}
