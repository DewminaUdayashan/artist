import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  String? id;
  String? name;
  String? birthdate;
  String? email;
  String? mobile;
  String? bio;
  String? district;
  String? joinedDate;
  String? mainPurpose;
  String? imageUrl;
  List<String>? categoriesId;

  UserModel({
    this.id,
    this.name,
    this.birthdate,
    this.email,
    this.mobile,
    this.bio,
    this.district,
    this.joinedDate,
    this.mainPurpose,
    this.categoriesId,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'birthdate': birthdate,
      'email': email,
      'mobile': mobile,
      'bio': bio,
      'district': district,
      'joinedDate': joinedDate,
      'mainPurpose': mainPurpose,
      'imageUrl': imageUrl,
      'categoriesId': categoriesId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] : null,
      name: map['name'] != null ? map['name'] : null,
      birthdate: map['birthdate'] != null ? map['birthdate'] : null,
      email: map['email'] != null ? map['email'] : null,
      mobile: map['mobile'] != null ? map['mobile'] : null,
      bio: map['bio'] != null ? map['bio'] : null,
      district: map['district'] != null ? map['district'] : null,
      joinedDate: map['joinedDate'] != null ? map['joinedDate'] : null,
      mainPurpose: map['mainPurpose'] != null ? map['mainPurpose'] : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] : null,
      categoriesId: map['categoriesId'] != null
          ? List<String>.from(map['categoriesId'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, birthdate: $birthdate, email: $email, mobile: $mobile, bio: $bio, district: $district, joinedDate: $joinedDate, mainPurpose: $mainPurpose, imageUrl: $imageUrl, categoriesId: $categoriesId)';
  }
}
