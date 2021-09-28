import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart2/Model/Shoes.dart';
import 'package:shopping_cart2/Screens/ProductScreen.dart';

class ShoesContainer extends StatelessWidget {
  final Shoes shoes;
  ShoesContainer({
    Key? key,
    required this.shoes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductScreen(shoes: shoes),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(shoes.images['0']!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              shoes.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text('¥ ${shoes.price}'),
          ],
        ),
      ),
    );
  }
}
