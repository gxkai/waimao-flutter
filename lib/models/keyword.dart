import 'package:json_annotation/json_annotation.dart';
import "keywordData.dart";
part 'keyword.g.dart';

@JsonSerializable()
class Keyword {
    Keyword();

    num current_page;
    List<KeywordData> data;
    num last_page;
    
    factory Keyword.fromJson(Map<String,dynamic> json) => _$KeywordFromJson(json);
    Map<String, dynamic> toJson() => _$KeywordToJson(this);
}
