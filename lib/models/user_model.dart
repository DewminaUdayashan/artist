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

  Map<String, dynamic> toJson() {
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

  factory UserModel.fromJson(Map<String, dynamic> map) {
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

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, birthdate: $birthdate, email: $email, mobile: $mobile, bio: $bio, district: $district, joinedDate: $joinedDate, mainPurpose: $mainPurpose, imageUrl: $imageUrl, categoriesId: $categoriesId)';
  }
}
