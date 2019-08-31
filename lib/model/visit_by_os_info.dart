class VisitByOsInfo {
  String key;
  int docCount ;

  VisitByOsInfo({
    this.key,
    this.docCount,
  });

  factory VisitByOsInfo.fromJson(Map<String, dynamic> json) {
    return VisitByOsInfo(
        key: json['key'],
        docCount: json['doc_count'],
    );
  }
}
