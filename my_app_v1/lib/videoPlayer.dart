import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class MyVideoPlayer extends StatefulWidget {
  const MyVideoPlayer({Key? key}) : super(key: key);

  @override
  _MyVideoPlayerState createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset('assets/video.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late String password;
    final users = FirebaseAuth.instance.currentUser;
    FirebaseAuth _auth = FirebaseAuth.instance;
    Future<void> changePassword(String newPassword) async {
      await _auth.currentUser!.updatePassword(newPassword);
    }

    return Scaffold(
      backgroundColor: Colors.indigo.shade400,
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade400,
        title: const Text('Uygulama Adı'),
        elevation: 10,
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
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              "Selam ${users!.email!.split("@")[0][0].toUpperCase() + users.email!.split("@")[0].substring(1).toLowerCase()}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Öğrenme Vakti",
              style: TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              width: 360,
              height: 340,
              child: PhysicalModel(
                elevation: 10,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(20),
                color: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Center(
                    child: Chewie(
                      controller: _chewieController,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
