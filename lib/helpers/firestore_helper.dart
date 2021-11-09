import 'package:artist/models/post_model.dart';
import 'package:artist/models/user_model.dart';
import 'package:artist/shared/instances.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class FirestoreHelper {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final CollectionReference users = FirebaseFirestore.instance
      .collection('users')
      .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson());
  static final CollectionReference posts = FirebaseFirestore.instance
      .collection('posts')
      .withConverter<PostModel>(
          fromFirestore: (snapshot, _) => PostModel.fromJson(snapshot.data()!),
          toFirestore: (post, _) => post.toJson());

  static Future<void> addPost() async {
    appController.currentPost.userId = appController.currentUser.value.id;
    appController.currentPost.date = DateTime.now().toString();
    await posts.add(appController.currentPost);
    appController.files.clear();
    appController.currentPost = PostModel();
  }

  static void registerUser(UserModel user) {
    users.where('email', isEqualTo: user.email).get().then((snapshot) {
      if (snapshot.docs.isEmpty) {
        users
            .add(user)
            .then((value) => appController.currentUser.value.id = value.id)
            .catchError((err) => print(err));
      } else {
        appController.currentUser.value =
            snapshot.docs.first.data() as UserModel;
        appController.currentUser.value.id = snapshot.docs.first.id;
        print('User Exist');
        print(appController.currentUser.toString());
      }
    });
  }

  static Future<void> updatedUser(UserModel user) {
    return users
        // existing document in 'users' collection: "ABC123"
        .doc(appController.currentUser.value.id)
        .set(
          user,
          SetOptions(merge: true),
        )
        .then(
            (value) => print("'full_name' & 'age' merged with existing data!"))
        .catchError((error) => print("Failed to merge data: $error"));
  }

  static Future<void> updatedUserImageUrl(String url) {
    return users
        // existing document in 'users' collection: "ABC123"
        .doc(appController.currentUser.value.id)
        .update({
          'imageUrl': url,
        })
        .then((value) => print("url updated ========================= $url"))
        .catchError((error) => print("Failed to merge data: $error"));
  }

  static Future<QuerySnapshot<Object?>> getAllUsers() async {
    return users.orderBy('joinedDate').get();
  }

  static Stream<QuerySnapshot<Object?>> getUserPosts(
    int limit, {
    QueryDocumentSnapshot? startAfter,
  }) {
    Query query = posts.orderBy('date', descending: true).limit(limit);
    if (startAfter != null) {
      return query.startAfterDocument(startAfter).snapshots();
    } else {
      return query.snapshots();
    }
  }

  static Future<void> voteToPost(String postId, List<String> votes) async {
    posts.doc(postId).update({'votes': votes});
  }

  static Future<void> unvoteToPost(String postId, List<String> votes) async {
    posts.doc(postId).update({'votes': votes});
  }
}
