class Dashboard {
  String username;
  String name;
  String email;
  String role;
  String lastLogin;
  String lastLoginIp;
  String version;
  String site;

  Dashboard({
    this.username,
    this.name,
    this.email,
    this.role,
    this.lastLogin,
    this.lastLoginIp,
    this.version,
    this.site
  });

  factory Dashboard.fromJson(Map<String, dynamic> json) {
    return Dashboard(
        username: json['username'],
        name: json['name'],
        email: json['email'],
        role: json['role'],
        lastLogin: json['lastLogin'],
        lastLoginIp: json['lastLoginIp'],
        version: json['version'],
        site: json['site']
    );
  }
}
