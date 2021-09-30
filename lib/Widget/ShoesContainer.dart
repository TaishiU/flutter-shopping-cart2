import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart2/Model/Shoes.dart';
import 'package:shopping_cart2/Screens/ProductScreen.dart';

class ShoesContainer extends StatelessWidget {
  final String currentUserId;
  final Shoes shoes;
  ShoesContainer({
    Key? key,
    required this.currentUserId,
    required this.shoes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(
              currentUserId: currentUserId,
              shoes: shoes,
            ),
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
          Text(
            shoes.type,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 5),
          Text(
            '¥${shoes.price}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '(税込)',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
