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
            .then((value) => print('User Added ${value.id}'))
            .catchError((err) => print(err));
      } else {
        appController.currentUser = snapshot.docs.first.data() as UserModel;
        print('User Exist');
        print(snapshot.docs.first.data());
      }
    });
  }
}
