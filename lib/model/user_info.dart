class UserInfo {
  int id;
  String username;
  String name;
  String email;
  String role;
  String lastLogin;
  String lastLoginIp;
  String version;
  String site;

  UserInfo({
    this.id,
    this.username,
    this.name,
    this.email,
    this.role,
    this.lastLogin,
    this.lastLoginIp,
    this.version,
    this.site
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
        id: json['id'],
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
