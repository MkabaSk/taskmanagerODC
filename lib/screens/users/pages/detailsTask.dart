import 'package:flutter/material.dart';


class DetailsTask extends StatefulWidget {
  const DetailsTask({super.key});

  @override
  State<DetailsTask> createState() => _DetailsTaskState();
}

class _DetailsTaskState extends State<DetailsTask> {
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

          ),
        ),
      ),
    );
  }
}
