class Product {
  String name;
  String package;
  String started;
  int year;

  Product({
    this.name,
    this.package,
    this.started,
    this.year
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        name: json['name'],
        package: json['package'],
        started: json['started_at'],
        year: json['year']
    );
  }
}
