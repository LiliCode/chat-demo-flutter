class User {
  int? id;
  String? name;
  String? account;
  String? avatar;

  User({this.id, this.account, this.name, this.avatar});

  User.fromJson(Map<String, dynamic> json) {
    final userId = json['id'];
    if (userId is String) {
      id = int.tryParse(userId) ?? 0;
    } else {
      id = userId;
    }

    name = json['name'];
    account = json['account'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'account': account,
      'avatar': avatar,
    };
  }
}
