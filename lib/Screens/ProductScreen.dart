import 'package:flutter/material.dart';
import 'package:shopping_cart2/Model/Shoes.dart';
import 'package:shopping_cart2/Widget/ShoesSize.dart';

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
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.shoes.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '¥${widget.shoes.price}',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.shoes.description,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'サイズを選択',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    ShoesSize(shoes: widget.shoes),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
