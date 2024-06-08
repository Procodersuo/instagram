import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instagram/Home.dart';
class splashscreen extends StatefulWidget {
  const splashscreen({Key? key}) : super(key: key);

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>homescreen()));
    });
  }
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Container(
            height: 100,
              width: 100,
              child: const Image(image: AssetImage('assests/Instagram_logo.png'))),
          const SizedBox(
            height: 80,
          ),
          Align(alignment: Alignment.bottomCenter,
              child: Container(child: const Text("Developed By\nTalha ", textAlign:TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 15,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),))),
        ],
      )
    );
  }
}
