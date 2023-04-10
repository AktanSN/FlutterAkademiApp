import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserMatch extends StatefulWidget {
  const UserMatch({Key? key}) : super(key: key);

  get user1 => [9, 5, 2, 5];
  get user2 => [8, 3, 5, 5];

  @override
  _UserMatchState createState() => _UserMatchState();
}

class _UserMatchState extends State<UserMatch> {
  final users = FirebaseAuth.instance.currentUser;

  FirebaseAuth _auth = FirebaseAuth.instance;
  int eslesenKategori = 0;

  bool get isAGreaterThanTwo =>
      eslesenKategori >
      2; // Define a getter for checking if a is greater than two

  void _comparison() {
    for (var i = 0; i < 4; i++) {
      int sonuc = widget.user1[i] - widget.user2[i];
      if (-2 <= sonuc && sonuc <= 2) {
        setState(() {
          eslesenKategori++;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _comparison(); // Call the _comparison() method here
  }

  @override
  Widget build(BuildContext context) {
    if (isAGreaterThanTwo == true) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("(match)"),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Eşleşme mevcut:',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 16),
              Text(
                '${users!.email?.split("@")[0]} ve Berk eleşti.',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text("(match)"),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Eşleşme bulunamadı.',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
      );
    }
  }
}
