class UserModel {
  final String? id;
  final String? email;
  final String? displayName;
  final String? type;
  UserModel({
    this.id,
    this.email,
    this.displayName,
    this.type,
  });

  UserModel copyWith(
    String? email,
    String? displayName,
    String? type,
  ) {
    return UserModel(
      id: id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      type: type ?? this.type,
    );
  }
}
