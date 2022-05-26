// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Text(
          'Made by BennyM8',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
