import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app_v1/newHome.dart';
import 'package:my_app_v1/userMatch.dart';

class BarChartModel {
  String category;
  int point;
  final charts.Color color;

  BarChartModel({
    required this.category,
    required this.point,
    required this.color,
  });
}

class ChartPage extends StatefulWidget {
  ChartPage({Key? key}) : super(key: key);

  get user1 => [9, 5, 2, 5];
  get user2 => [8, 3, 5, 5];

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  late String password;

  final users = FirebaseAuth.instance.currentUser;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> changePassword(String newPassword) async {
    await _auth.currentUser!.updatePassword(newPassword);
  }

  final List<BarChartModel> data = [
    BarChartModel(
      category: "Analitik",
      point: 9,
      color: charts.ColorUtil.fromDartColor(Colors.blueAccent),
    ),
    BarChartModel(
      category: "Yaratıcı",
      point: 5,
      color: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    BarChartModel(
      category: "Sosyal",
      point: 3,
      color: charts.ColorUtil.fromDartColor(Colors.green[400]!),
    ),
    BarChartModel(
      category: "Liderlik",
      point: 7,
      color: charts.ColorUtil.fromDartColor(Colors.yellow),
    ),
  ];

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
    List<charts.Series<BarChartModel, String>> series = [
      charts.Series(
        id: "point",
        data: data,
        domainFn: (BarChartModel series, _) => series.category,
        measureFn: (BarChartModel series, _) => series.point,
        colorFn: (BarChartModel series, _) => series.color,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(
                width: 200, height: 180, child: Image.asset('assets/logo.png')),
            Text(
              'Sonuçlar',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              color: Colors.grey,
              height: 20,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            Container(
              height: 300,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: charts.BarChart(
                series,
                animate: true,
              ),
            ),
            Text(
              'Eşleşme mevcut:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              '${users!.email?.split("@")[0]} ve Berk eşleşti.',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => NewHomePage()));
                },
                child: Text('Ana Sayfaya Dön'))
          ],
        ),
      ),
    );
  }
}
