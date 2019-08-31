class VisitByCountryInfo {
  String key;
  int pv;
  int uv;

  VisitByCountryInfo({
    this.key,
    this.pv,
    this.uv
  });

  factory VisitByCountryInfo.fromJson(Map<String, dynamic> json) {
    return VisitByCountryInfo(
        key: json['key'],
        pv: json['pv'],
        uv: json['uv']
    );
  }
}
