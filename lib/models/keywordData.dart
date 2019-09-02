import 'package:json_annotation/json_annotation.dart';

part 'keywordData.g.dart';

@JsonSerializable()
class KeywordData {
    KeywordData();

    num page;
    @JsonKey(name: 'num') num number;
    String keyword;
    
    factory KeywordData.fromJson(Map<String,dynamic> json) => _$KeywordDataFromJson(json);
    Map<String, dynamic> toJson() => _$KeywordDataToJson(this);
}
