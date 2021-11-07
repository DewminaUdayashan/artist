import 'dart:convert';

class PostModel {
  String? id;
  String? description;
  List<String>? mediaUrls;
  bool isCloudStorage;
  String? date;

  PostModel({
    this.id,
    this.description,
    this.mediaUrls,
    this.isCloudStorage = true,
    this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'mediaUrls': mediaUrls,
      'isCloudStorage': isCloudStorage,
      'date': date,
    };
  }

  factory PostModel.fromJson(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] != null ? map['id'] : null,
      description: map['description'] != null ? map['description'] : null,
      mediaUrls: List<String>.from(map['mediaUrls']),
      isCloudStorage: map['isCloudStorage'] ?? null,
      date: map['date'] ?? null,
    );
  }

  @override
  String toString() =>
      'PostModel(id: $id, description: $description, mediaUrls: $mediaUrls)';
}
