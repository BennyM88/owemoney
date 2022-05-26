// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class UserStats extends StatefulWidget {
  const UserStats({Key? key}) : super(key: key);

  @override
  State<UserStats> createState() => _UserStatsState();
}

class _UserStatsState extends State<UserStats> {
  var _total = '';
  double _percent = 0.0;

  Future sumTotal() async {
    num sum = 0.0;
    await FirebaseFirestore.instance
        .collection('user-list')
        .get()
        .then((snapshot) => snapshot.docs.forEach((element) {
              num amount = element.data()['amount'];
              sum += amount;
            }));
    setState(() {
      if (sum < 999.9) {
        _total = '$sum';
        _percent = sum / 1000;
      } else {
        _total = '+999.9';
        _percent = 1.0;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    sumTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 40),
            // Title
            Text(
              'Total',
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontSize: 28,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Progress
            CircularPercentIndicator(
              animation: true,
              radius: 160,
              lineWidth: 35,
              percent: _percent,
              circularStrokeCap: CircularStrokeCap.round,
              center: Text(
                _total + ' \$',
                style: GoogleFonts.lato(
                  textStyle:
                      TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
              ),
              linearGradient: LinearGradient(
                  colors: [Colors.cyan.shade200, Colors.tealAccent]),
              backgroundColor: Colors.grey.shade300,
            ),
          ],
        ),
      ),
    );
  }
}
