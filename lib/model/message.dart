class Message {
  String name;
  String phone;
  String email;
  String address;
  String content;
  int isRead;
  DateTime createdAt;

  Message({
    this.name,
    this.phone,
    this.email,
    this.address,
    this.content,
    this.isRead,
    this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        name: json['name'],
        phone: json['phone'],
        email: json['email'],
        address: json['address'],
        content: json['content'],
        isRead: json['isread'],
        createdAt: DateTime.parse(json['created_at'])
    );
  }
}
