import 'package:json_annotation/json_annotation.dart';

part 'dashboardVisit.g.dart';

@JsonSerializable()
class DashboardVisit {
    DashboardVisit();

    String key;
    num pv;
    num uv;
    
    factory DashboardVisit.fromJson(Map<String,dynamic> json) => _$DashboardVisitFromJson(json);
    Map<String, dynamic> toJson() => _$DashboardVisitToJson(this);
}
