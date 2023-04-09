import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_app_v1/HomePage.dart';
import 'package:my_app_v1/LoginPage.dart';
import 'package:my_app_v1/NotePage.dart';
import 'package:my_app_v1/styles.dart';
import 'package:my_app_v1/videoPlayer.dart';
import 'package:my_app_v1/view/screens/splash_screen.dart';
import 'package:my_app_v1/widgets.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controller/index_controller.dart';
import 'newHome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool open = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Socialpath",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: NewHomePage(),
            );
          } else {
            return Scaffold(
              body: LoginPage(),
            );
          }
        },
      ),

      /* StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: NewHomePage(),
            );
          } else {
            return Scaffold(
              body: LoginPage(),
            );
          }
        },
      ), */
    );
    //NewHomePage(context);
  }

  ChangeNotifierProvider<IndexController> ChangeNotifier() {
    return ChangeNotifierProvider<IndexController>(
      create: (context) => IndexController(),
      child: const MaterialApp(
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
  /*
  MaterialApp NewHomePage(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Colors.indigo.shade400,
        appBar: AppBar(
          backgroundColor: Colors.indigo.shade400,
          title: const Text('Uygulama Adı'),
          elevation: 0,
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      open == true ? open = false : open = true;
                    });
                  },
                  icon: Icon(
                    open == true ? Icons.close_rounded : Icons.search_rounded,
                    size: 30,
                  )),
            )
          ],
        ),
        drawer: ChatWidgets.drawer(context),
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
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, i) {
                          return ChatWidgets.circleProfile(
                            onTap: () {},
                            name: 'Kullanıcı',
                            number: i,
                          );
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Text(
                        'Ekip',
                        style: Styles.h1().copyWith(color: Colors.indigo),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, i) {
                            return Card(
                              elevation: 8,
                              color: Colors.white,
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.indigo.shade400,
                                  child: Text('A'),
                                ),
                                title: Text('Kullanıcı'),
                                subtitle: Text('Çevrimiçi'),
                                trailing: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.message),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ), /**/
    );
  }
  */
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
