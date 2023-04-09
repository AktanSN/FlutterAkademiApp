import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../../../controller/index_controller.dart';
import 'start_screen.dart';

//BU SAYFAYA İSTATİSTİK KISMI EKLENİCEK BU SAYFA GEÇİCİ OLARAK YAPILDI

class ResultPage extends StatelessWidget {
  ResultPage(
      {super.key,
      required this.selected1,
      required this.selected2,
      required this.selected3,
      required this.selected4});

  int selected1 = 0;
  int selected2 = 0;
  int selected3 = 0;
  int selected4 = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              insetPadding: EdgeInsets.zero,
              contentTextStyle: GoogleFonts.mulish(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text('Testten Çık?'),
              content: const Text(
                'Çıkmak istediğinize emin misiniz?',
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => exit(0)));
                  },
                  child: const Text(
                    'Evet',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('Hayır'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },

      //buradan itibaren değişecektir

      child: Consumer<IndexController>(
          builder: (context, getIndexProvider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(),
          body: Center(child: Text('$selected1')),
        );
      }),
    );
  }
}
