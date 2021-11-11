import 'dart:convert';

class PostModel {
  String? id;
  String? userId;
  String? description;
  List<String>? mediaUrls;
  String? date;
  List<String> votes;

  PostModel({
    this.id,
    this.userId,
    this.description,
    this.mediaUrls,
    this.date,
    this.votes = const <String>[],
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'description': description,
      'media_urls': mediaUrls,
      'created_at': date,
      'votes': votes,
    };
  }

  factory PostModel.fromJson(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'],
      userId: map['user_id'],
      description: map['description'],
      mediaUrls:
          map['mediaUrls'] == null ? null : List<String>.from(map['mediaUrls']),
      date: map['created_at'],
      votes: map['votes'] == null ? [] : List<String>.from(map['votes']),
    );
  }

  @override
  String toString() =>
      'PostModel(userId: $userId, description: $description, mediaUrls: $mediaUrls)';
}
