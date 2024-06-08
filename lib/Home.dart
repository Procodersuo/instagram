import 'package:flutter/material.dart';
import 'package:instagram/Screens/camera.dart';
import 'package:instagram/Screens/homescreen.dart';

import 'package:instagram/Screens/profile.dart';
import 'package:instagram/Screens/reels.dart';
import 'package:instagram/Screens/searchscreen.dart';
class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  int selecteditem=0;
  final screen=const [Homescreen(),searchscreen(),camera(),reels(),profile()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: screen[selecteditem],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selecteditem,
        type: BottomNavigationBarType.values.first,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        items:  const <BottomNavigationBarItem> [
          BottomNavigationBarItem(icon:   Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon:   Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon:   Icon(Icons.add), label: "More"),
          BottomNavigationBarItem(icon:   Icon(Icons.slow_motion_video_sharp), label: "Reels"),
          BottomNavigationBarItem(icon:   Icon(Icons.person), label: "Profile"),
        ],
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,



        onTap: (index)
        {

          setState(() {
            selecteditem=index;
          });

        },

      ),
    );
  }
}

