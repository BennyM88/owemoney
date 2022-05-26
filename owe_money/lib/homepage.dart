// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/user_home.dart';
import 'pages/user_info.dart';
import 'pages/user_stats.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPage = 0;

  final Shader _linearGradient = LinearGradient(
    colors: <Color>[Colors.cyan.shade200, Colors.tealAccent],
  ).createShader(
    Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
  );

  void navigate(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  final List<Widget> pages = [
    UserStats(),
    UserHome(),
    UserInfo(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'OweMoney',
          style: GoogleFonts.lato(
              textStyle: TextStyle(
            foreground: Paint()..shader = _linearGradient,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          )),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.share,
                color: Colors.grey.shade600,
              )),
        ],
      ),
      body: pages[_selectedPage],
      bottomNavigationBar: CurvedNavigationBar(
          color: Colors.white,
          backgroundColor: Colors.grey.shade100,
          animationDuration: Duration(milliseconds: 450),
          onTap: navigate,
          items: [
            Icon(Icons.bar_chart),
            Icon(Icons.home),
            Icon(Icons.info),
          ]),
    );
  }
}
