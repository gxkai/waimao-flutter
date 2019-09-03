import 'package:json_annotation/json_annotation.dart';

part 'dashboardKeyword.g.dart';

@JsonSerializable()
class DashboardKeyword {
    DashboardKeyword();

    num page1;
    num page2;
    num page3;
    @JsonKey(name: '_count') num keywordCount;
    
    factory DashboardKeyword.fromJson(Map<String,dynamic> json) => _$DashboardKeywordFromJson(json);
    Map<String, dynamic> toJson() => _$DashboardKeywordToJson(this);
}
