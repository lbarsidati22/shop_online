class UserDataModel {
  String id;
  String email;
  String userName;
  String createdAt;
  UserDataModel({
    required this.id,
    required this.email,
    required this.userName,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'username': userName});
    result.addAll({'email': email});
    result.addAll({'createdAt': createdAt});

    return result;
  }

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      userName: map['userName'] ?? '',
      createdAt: map['createdAt'] ?? '',
    );
  }

  // String toJson() => json.encode(toMap());

  // factory UserDataModel.fromJson(String source) => UserDataModel.fromMap(json.decode(source));
}
