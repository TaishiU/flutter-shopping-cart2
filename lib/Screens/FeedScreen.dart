import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart2/Screens/FavoriteScreen.dart';
import 'package:shopping_cart2/Screens/HomeScreen.dart';
import 'package:shopping_cart2/Screens/SearchScreen.dart';

class FeedScreen extends StatefulWidget {
  final String currentUserId;
  const FeedScreen({
    Key? key,
    required this.currentUserId,
  }) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        HomeScreen(currentUserId: widget.currentUserId),
        FavoriteScreen(currentUserId: widget.currentUserId),
        SearchScreen(),
      ].elementAt(_selectedTab),
      bottomNavigationBar: CupertinoTabBar(
        onTap: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        activeColor: Colors.blue,
        currentIndex: _selectedTab,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border)),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
        ],
      ),
    );
  }
}
