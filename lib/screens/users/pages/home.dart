import 'dart:ffi';

import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}




class _MyHomePageState extends State<MyHomePage> {

  final databaseReference = FirebaseDatabase.instance.reference();

@override
  void initState() {
    // TODO: implement initState
  print("mon ${databaseReference.child('users')}");
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1f1f1f),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12),
          margin:  EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.yellow,
              )
          ),
          child: Column(
            children: [
             Expanded(
               child:  FirebaseAnimatedList(
                 query: databaseReference.child('users'),
                 itemBuilder: (BuildContext context, DataSnapshot snapshot,
                     Animation<double> animation, int index) {
                   return ListTile(
                     title: Text(
                         snapshot.child("firstName").value.toString(),
                       style: TextStyle(
                         color: Colors.yellow
                       ),
                     ),
                     subtitle: Text(
                         snapshot.child("lastName").value.toString()
                     ),
                   );
                 },
               )
             )
            ],
          ),
        ),
      ),
    );
  }
}
