import 'package:artist/models/user_model.dart';
import 'package:artist/shared/instances.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final CollectionReference users = FirebaseFirestore.instance
      .collection('users')
      .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson());

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
}
