class KeywordCount {
  num first;
  num second;
  num third;

  KeywordCount({this.first, this.second, this.third});

  factory KeywordCount.fromJson(Map<String, dynamic> json) {
    return KeywordCount(
      first: json['1'],
      second: json['2'],
      third: json['3'],
    );
  }
}
