class VisitByDayInfo {
  DateTime key;
  int pv;
  int uv;

  VisitByDayInfo({
    this.key,
    this.pv,
    this.uv
  });

  factory VisitByDayInfo.fromJson(Map<String, dynamic> json) {
    return VisitByDayInfo(
        key: DateTime.parse(json['key']),
        pv: json['pv'],
        uv: json['uv']
    );
  }
}
