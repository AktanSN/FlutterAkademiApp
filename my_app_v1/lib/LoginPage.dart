import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;

  bool isFirebaseInitialized = false;

  Future<void> initialFirebase() async {
    await Firebase.initializeApp();
    setState(() {
      isFirebaseInitialized = true;
    });

    //GoToLoginPage();
  }

  void GoToLoginPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialFirebase();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Login Page'),
        ),
      ),
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          hintText: 'email',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          hintText: 'password',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 40,
                  width: 100,
                  child: PhysicalModel(
                    color: Colors.transparent,
                    elevation: 15,
                    child: ElevatedButton(
                      onPressed: () {
                        FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                      },
                      child: Text('Giriş Yap'),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 40,
                  width: 120,
                  child: PhysicalModel(
                    color: Colors.transparent,
                    elevation: 15,
                    child: ElevatedButton(
                      onPressed: () {
                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Kayıt Ol'),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 40,
                  width: 120,
                  child: PhysicalModel(
                    color: Colors.transparent,
                    elevation: 15,
                    child: ElevatedButton(
                      onPressed: () async {
                        await signInWithGoogle();
                      },
                      child: Text('Google ile giriş yap'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
