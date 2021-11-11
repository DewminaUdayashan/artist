import 'dart:convert';

class UserModel {
  String? id;
  String? name;
  String? birthdate;
  String? email;
  String? mobile;
  String? bio;
  String? district;
  int? mainPurpose;
  String? imageUrl;
  String? password;
  List<String>? categorieIds;
  bool? isVerified;
  bool? status;
  String? createdAt;
  bool? isOnline;

  UserModel({
    this.id,
    this.name,
    this.birthdate,
    this.email,
    this.mobile,
    this.bio,
    this.district,
    this.mainPurpose,
    this.categorieIds,
    this.imageUrl,
    this.password,
    this.createdAt,
    this.status,
    this.isVerified,
    this.isOnline,
  });

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'birthdate': birthdate,
  //     'email': email,
  //     'mobile': mobile,
  //     'bio': bio,
  //     'district': district,
  //     'joinedDate': joinedDate,
  //     'main_purpose': mainPurpose,
  //     'image_url': imageUrl,
  //     'categorie_ids': categorieIds,
  //     'password': password,
  //   };
  // }

  // factory UserModel.fromJson(Map<String, dynamic> map) {
  //   return UserModel(
  //     id: map['id'],
  //     name: map['name'],
  //     birthdate: map['birthdate'],
  //     email: map['email'],
  //     mobile: map['mobile'],
  //     bio: map['bio'],
  //     district: map['district'],
  //     joinedDate: map['joined_date'],
  //     mainPurpose: map['main_purpose'],
  //     imageUrl: map['image_url'],
  //     categorieIds: map['categorie_ids'],
  //     password: map['password'],
  //   );
  // }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'birthdate': birthdate,
      'email': email,
      'mobile': mobile,
      'bio': bio,
      'district': district,
      'main_purpose': mainPurpose,
      'image_url': imageUrl,
      'password': password,
      'category_ids': categorieIds,
      'createdAt': createdAt,
      'status': status,
      'isVerified': isVerified,
      'isOnline': isOnline,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'].toString(),
      name: map['name'],
      birthdate: map['birthdate'],
      email: map['email'],
      mobile: map['mobile'],
      bio: map['bio'],
      district: map['district'],
      mainPurpose: map['main_purpose'],
      imageUrl: map['image_url'],
      password: map['password'],
      categorieIds: map['category_ids'] != null
          ? List<String>.from(map['category_ids'])
          : null,
      createdAt: map['createdAt'],
      isVerified: map['isVerified'],
      isOnline: map['isOnline'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
