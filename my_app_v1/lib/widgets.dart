import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app_v1/styles.dart';

class ChatWidgets {
  static Widget card({title, time, subtitle, onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Card(
        elevation: 0,
        child: ListTile(
          onTap: onTap,
          contentPadding: const EdgeInsets.all(5),
          leading: const Padding(
            padding: EdgeInsets.all(0.0),
            child: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  size: 30,
                  color: Colors.white,
                )),
          ),
          subtitle: subtitle != null ? Text(subtitle) : null,
          trailing: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(time),
          ),
        ),
      ),
    );
  }

  static int getRandomNumber() {
    var random = Random();
    var randomNumber = random.nextInt(7 - 1 + 1) + 1;
    return randomNumber;
  }

  static Widget circleProfile({onTap, name, number}) {
    if (number < 7) {
      number = number + 1;
    } else {
      number = Random().nextInt(7 - 1 + 1) + 1;
    }
    String num = number.toString();
    print(num);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Stack(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/avatar_${num}.jpg'),
                    radius: 28,
                    backgroundColor: Colors.grey,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              width: 50,
              child: Center(
                child: Text(
                  name,
                  style:
                      TextStyle(height: 1.5, fontSize: 10, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static drawer(context) {
    return Drawer(
      backgroundColor: Colors.indigo.shade400,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20),
          child: Theme(
            data: ThemeData.dark(),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('assets/avatar_1.jpg'),
                ),
                const SizedBox(height: 10),
                const Divider(
                  color: Colors.white,
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profil'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Çıkış Yap'),
                  onTap: () async => await FirebaseAuth.instance.signOut(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  static searchBar(
    bool open,
  ) {}

  static searchField({Function(String)? onChange}) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: TextField(
        onChanged: onChange,
        decoration: Styles.searchTextFieldStyle(),
      ),
      decoration: Styles.messageFieldCardStyle(),
    );
  }
}
