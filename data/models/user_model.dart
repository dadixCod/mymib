// ignore_for_file: public_member_api_docs, sort_constructors_first


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

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, displayName: $displayName, type: $type)';
  }

 

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'displayName': displayName,
      'type': type,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map,String id) {
    return UserModel(
      id: id,
      email: map['email'] ,
      displayName: map['userName'] ,
      type: map['type'] ,
    );
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.email == email &&
      other.displayName == displayName &&
      other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      email.hashCode ^
      displayName.hashCode ^
      type.hashCode;
  }
}
