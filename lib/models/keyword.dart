import 'package:json_annotation/json_annotation.dart';
import "keywordData.dart";
part 'keyword.g.dart';

@JsonSerializable()
class Keyword {
    Keyword();

    @JsonKey(name: 'current_page') num currentPage;
    List<KeywordData> data;
    @JsonKey(name: 'last_page') num lastPage;
    
    factory Keyword.fromJson(Map<String,dynamic> json) => _$KeywordFromJson(json);
    Map<String, dynamic> toJson() => _$KeywordToJson(this);
}
