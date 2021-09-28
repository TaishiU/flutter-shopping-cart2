import 'package:flutter/material.dart';
import 'package:shopping_cart2/Model/Shoes.dart';

class ProductScreen extends StatefulWidget {
  final Shoes shoes;
  ProductScreen({
    Key? key,
    required this.shoes,
  }) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.yellow,
                image: DecorationImage(
                  image: NetworkImage("${widget.shoes.images['0']!}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Text(
                widget.shoes.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
