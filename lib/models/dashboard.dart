import 'package:json_annotation/json_annotation.dart';
import "dashboardMessage.dart";
import "dashboardKeyword.dart";
import "dashboardVisit.dart";
part 'dashboard.g.dart';

@JsonSerializable()
class Dashboard {
    Dashboard();

    DashboardMessage message;
    DashboardKeyword keyword;
    DashboardVisit visit;
    
    factory Dashboard.fromJson(Map<String,dynamic> json) => _$DashboardFromJson(json);
    Map<String, dynamic> toJson() => _$DashboardToJson(this);
}
