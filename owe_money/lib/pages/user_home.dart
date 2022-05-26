// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:owe_money/data/get_user_amount.dart';
import 'package:owe_money/data/get_user_details.dart';

import 'user_add.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  List<String> docIDs = [];

  Future getID() async {
    await FirebaseFirestore.instance
        .collection('user-list')
        .orderBy('amount', descending: true)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              docIDs.add(document.reference.id);
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          SizedBox(height: 40),
          // Add button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const UserAdd()));
              },
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.cyan.shade200, Colors.tealAccent]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: Text(
                  'ADD',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )),
              ),
            ),
          ),
          SizedBox(height: 20),
          // User list
          Expanded(
              child: FutureBuilder(
            future: getID(),
            builder: (context, snapshot) {
              return ListView.builder(
                  itemCount: docIDs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Dismissible(
                          key: Key(index.toString()),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (direction) {
                            FirebaseFirestore.instance
                                .collection('user-list')
                                .doc(docIDs[index])
                                .delete();
                          },
                          background: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(25)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                  Text('Move to trash',
                                      style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            child: ListTile(
                              trailing: IconButton(
                                icon: Icon(Icons.add),
                                color: Colors.cyan.shade200,
                                iconSize: 36,
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('user-list')
                                      .doc(docIDs[index])
                                      .update(
                                          {'amount': FieldValue.increment(1)});
                                },
                              ),
                              title: GetUserAmount(docID: docIDs[index]),
                              subtitle: GetUserDetails(docID: docIDs[index]),
                              leading: IconButton(
                                icon: Icon(Icons.remove),
                                color: Colors.tealAccent,
                                iconSize: 36,
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('user-list')
                                      .doc(docIDs[index])
                                      .update(
                                          {'amount': FieldValue.increment(-1)});
                                },
                              ),
                            ),
                          )),
                    );
                  });
            },
          )),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
