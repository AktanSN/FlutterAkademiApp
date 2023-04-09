import 'package:cloud_firestore/cloud_firestore.dart';

import 'Users.dart';

Future<List<Users>> getUsers() async {
  final users = await FirebaseFirestore.instance.collection('users').get();

  return users.docs.map((e) => Users(username: e['username'])).toList();
}
