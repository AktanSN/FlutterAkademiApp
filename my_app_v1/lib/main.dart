import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_app_v1/HomePage.dart';
import 'package:my_app_v1/LoginPage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return LoginPage();
          }
        },
      ),
      /*Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Login Page'),
          ),
        ),
        body: TypeFormWidget(),
      ), */
    );
  }
}

class SurveyWidget extends StatelessWidget {
  const SurveyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          '1. Soru: ',
          style: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        RadioListTile(
          title: Text('Evet'),
          value: 'Evet',
          groupValue: null,
          onChanged: null,
        ),
        RadioListTile(
          title: Text('Hayır'),
          value: 'Hayır',
          groupValue: null,
          onChanged: null,
        ),
        SizedBox(height: 20),
        Text(
          '2. Soru: ',
          style: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        RadioListTile(
          title: Text('Evet'),
          value: 'Evet',
          groupValue: null,
          onChanged: null,
        ),
        RadioListTile(
          title: Text('Hayır'),
          value: 'Hayır',
          groupValue: null,
          onChanged: null,
        ),
        SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Gönder'),
          ),
        ),
      ],
    );
  }
}
