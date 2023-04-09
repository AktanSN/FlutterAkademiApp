import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app_v1/data_service.dart';

import 'Users.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key}) {}
  // TODO: implement HomePage

  late String password;
  final users = FirebaseAuth.instance.currentUser;

  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> changePassword(String newPassword) async {
    await _auth.currentUser!.updatePassword(newPassword);
  }

  final isChange = "Passowrd Changed";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Home Page'),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Mevcut Kullanıcılar"),
            Expanded(
              child: FutureBuilder<List<Users>>(
                future: getUsers(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 15,
                          child: ListTile(
                            title: Text(snapshot.data![index].username!),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Center(
                    child: Text('Hoşgeldin ${users!.email?.split("@")[0]}'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    child: Text('Çıkış Yap'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'yeni şifre',
                    ),
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      changePassword(password);
                      Fluttertoast.showToast(
                        msg: "Şifre başarıyla değiştirildi!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.blue,
                        textColor: Colors.white,
                        fontSize: 20.0,
                      );
                      //Navigator.pop(context);
                      //FirebaseAuth.instance.signOut();
                    },
                    child: Text('Şifre Değiştir'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
