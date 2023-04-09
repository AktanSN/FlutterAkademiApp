import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app_v1/newHome.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

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
        backgroundColor: Colors.indigo.shade400,
        title: const Text('Uygulama Adı'),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Şifre Değiştir"),
                    content: TextField(
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          changePassword(password);

                          Fluttertoast.showToast(
                            msg: "Şifreniz Değiştirildi !",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.indigo.shade400,
                            textColor: Colors.white,
                            fontSize: 20.0,
                          );
                          Navigator.pop(context);
                        },
                        child: Text("Değiştir"),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.lock),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Çıkış Yap"),
                    content: Text("Çıkış yapmak istediğinize emin misiniz?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Hayır"),
                      ),
                      TextButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();

                          Fluttertoast.showToast(
                            msg: "Çıkış başarılı !",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.indigo.shade400,
                            textColor: Colors.white,
                            fontSize: 20.0,
                          );

                          Navigator.pop(context);
                        },
                        child: Text("Evet"),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              color: Colors.indigo.shade400,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 18.0, horizontal: 20),
                  child: Theme(
                    data: ThemeData.dark(),
                    child: Column(
                      children: [
                        Text(
                          "Profil Sayfası",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        const CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage('assets/avatar_1.jpg'),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${users!.email?.split("@")[0]}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
