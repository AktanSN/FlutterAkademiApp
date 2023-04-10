import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app_v1/NotePage.dart';
import 'package:my_app_v1/ProfilePage.dart';
import 'package:my_app_v1/styles.dart';
import 'package:my_app_v1/videoPlayer.dart';
import 'package:my_app_v1/widgets.dart';
import 'package:video_player/video_player.dart';

import 'Users.dart';
import 'data_service.dart';

class NewHomePage extends StatefulWidget {
  NewHomePage({super.key});

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  late String password;

  final users = FirebaseAuth.instance.currentUser;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> changePassword(String newPassword) async {
    await _auth.currentUser!.updatePassword(newPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade400,
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade400,
        title: const Text('socialpath'),
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
      drawer: ChatWidgets.drawer(users!.email?.split("@")[0]),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10),
            margin: EdgeInsets.all(0),
            child: Container(
              color: Colors.indigo.shade400,
              padding: const EdgeInsets.all(8),
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 10),
                    child: Text(
                      'Son Aktif Kullanıcılar',
                      style: Styles.h1(),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: 80,
                    child: FutureBuilder<List<Users>>(
                      future: getUsers(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, i) {
                              return ChatWidgets.circleProfile(
                                name: snapshot.data![i].username,
                                number: i,
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
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: Styles.friendsBox(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Text(
                      'Ekip',
                      style: Styles.h1().copyWith(color: Colors.indigo),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: FutureBuilder<List<Users>>(
                        future: getUsers(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, i) {
                                Widget myWidget = Text("Çevrimiçi");
                                if (snapshot.data![i].username ==
                                    users!.email?.split("@")[0]) {
                                  myWidget = Text("Çevrimiçi");
                                } else {
                                  myWidget = Text("Çevrimdışı");
                                }
                                return Card(
                                  elevation: 15,
                                  color: Colors.white,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.indigo.shade400,
                                      child: Text(snapshot.data![i].username
                                          .substring(0, 1)
                                          .toUpperCase()),
                                    ),
                                    title: Text(snapshot.data![i].username),
                                    subtitle: myWidget,
                                    trailing: IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.message),
                                    ),
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
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 70,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 10,
              backgroundColor: Colors.indigo.shade400,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: "Anasayfa"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Profil"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.note), label: "Notlar"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.video_library), label: "Günlük Widget"),
              ],
              currentIndex: 0,
              selectedItemColor: Colors.white,
              onTap: (index) {
                if (index == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                } else if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                } else if (index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotePage()),
                  );
                } else if (index == 3) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyVideoPlayer()),
                  );
                }
              },
            ),
          ),
        ],
      ),
    ); /**/
  }
}
