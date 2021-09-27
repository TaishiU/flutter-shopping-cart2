import 'package:flutter/material.dart';
import 'package:shopping_cart2/Firebase/Auth.dart';
import 'package:shopping_cart2/Screens/WelcomeScreen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('SearchScreen'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              Auth().logout();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomeScreen(),
                  ),
                  (_) => false);
            },
          ),
        ],
      ),
    );
  }
}
