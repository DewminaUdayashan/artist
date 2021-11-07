import 'package:artist/helpers/firestore_helper.dart';
import 'package:artist/models/user_model.dart';
import 'package:artist/screens/home_page/widgets/search_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<QuerySnapshot<Object?>>(
        future: FirestoreHelper.getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => SearchItem(
                user: snapshot.data!.docs[index].data() as UserModel,
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
