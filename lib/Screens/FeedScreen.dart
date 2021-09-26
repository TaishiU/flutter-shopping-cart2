import 'package:flutter/material.dart';
import 'package:shopping_cart2/Firebase/Auth.dart';
import 'package:shopping_cart2/Screens/WelcomeScreen.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Text('FeedScreen'),
            SizedBox(height: 100),
            ElevatedButton(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                onPrimary: Colors.white,
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
      ),
    );
  }
}
