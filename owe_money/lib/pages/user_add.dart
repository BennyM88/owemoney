// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserAdd extends StatefulWidget {
  const UserAdd({Key? key}) : super(key: key);

  @override
  State<UserAdd> createState() => _UserAddState();
}

class _UserAddState extends State<UserAdd> {
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _personDetails = TextEditingController();
  var snackBar = SnackBar(
      content: Text('Successfully Added'), duration: Duration(seconds: 2));

  @override
  void dispose() {
    _amount.dispose();
    _personDetails.dispose();
    super.dispose();
  }

  Future addToList() async {
    await FirebaseFirestore.instance.collection('user-list').add({
      'amount': double.parse(_amount.text.trim()),
      'name': _personDetails.text.trim(),
    }).then((value) => ScaffoldMessenger.of(context).showSnackBar(snackBar));
    FocusManager.instance.primaryFocus?.unfocus();
    _amount.clear();
    _personDetails.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient:
            LinearGradient(colors: [Colors.cyan.shade200, Colors.tealAccent]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 20),
          // Amount title
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Amount',
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          // Amount textfield
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextField(
                  controller: _amount,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Amount',
                      suffixIcon: IconButton(
                        onPressed: () {
                          _amount.clear();
                        },
                        icon: const Icon(Icons.clear),
                      )),
                ),
              ),
            ),
          ),
          SizedBox(height: 40),
          // Person Details title
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Person Details',
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          // Person Details textfield
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextField(
                  controller: _personDetails,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Person Details',
                      suffixIcon: IconButton(
                        onPressed: () {
                          _personDetails.clear();
                        },
                        icon: const Icon(Icons.clear),
                      )),
                ),
              ),
            ),
          ),
          SizedBox(height: 40),
          // Add button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: addToList,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: Text(
                  'ADD TO LIST',
                  style: TextStyle(
                      color: Colors.cyan.shade200,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
