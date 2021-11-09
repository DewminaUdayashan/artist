import 'dart:convert';

class PostModel {
  String? id;
  String? userId;
  String? description;
  List<String>? mediaUrls;
  bool isCloudStorage;
  String? date;
  List<String> votes;

  PostModel({
    this.id,
    this.userId,
    this.description,
    this.mediaUrls,
    this.isCloudStorage = true,
    this.date,
    this.votes = const <String>[],
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'description': description,
      'mediaUrls': mediaUrls,
      'isCloudStorage': isCloudStorage,
      'date': date,
      'votes': votes,
    };
  }

  factory PostModel.fromJson(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] != null ? map['id'] : null,
      userId: map['userId'] != null ? map['userId'] : null,
      description: map['description'] != null ? map['description'] : null,
      mediaUrls:
          map['mediaUrls'] == null ? null : List<String>.from(map['mediaUrls']),
      isCloudStorage: map['isCloudStorage'] ?? null,
      date: map['date'] ?? null,
      votes: map['votes'] == null ? [] : List<String>.from(map['votes']),
    );
  }

  @override
  String toString() =>
      'PostModel(userId: $userId, description: $description, mediaUrls: $mediaUrls)';
}
