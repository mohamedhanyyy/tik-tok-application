import 'package:flutter/material.dart';
import 'package:tik_tok/view/home_screen.dart';
import 'package:tik_tok/view/messages.dart';
import 'package:tik_tok/view/profile.dart';
import 'package:tik_tok/view/search_screen.dart';
import 'package:tik_tok/view/upload_video.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _pages = [
    HomeScreen(),
    SearchScreen(),
    UploadVideo(),
    MessagesScreen(),
    ProfileScreen(),
  ];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[index],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Add Video'),
          BottomNavigationBarItem(icon: Icon(Icons.message_sharp), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (int x) {
          setState(() {
            index = x;
          });
        },
        currentIndex: index,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
