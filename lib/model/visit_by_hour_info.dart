class VisitByHourInfo {
  String key;
  int docCount ;

  VisitByHourInfo({
    this.key,
    this.docCount,
  });

  factory VisitByHourInfo.fromJson(Map<String, dynamic> json) {
    return VisitByHourInfo(
        key: json['key'],
        docCount: json['doc_count'],
    );
  }
}
