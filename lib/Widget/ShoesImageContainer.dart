import 'package:flutter/material.dart';
import 'package:shopping_cart2/Model/Shoes.dart';

class ShoesImageContainer extends StatefulWidget {
  final Shoes shoes;
  ShoesImageContainer({
    Key? key,
    required this.shoes,
  }) : super(key: key);

  @override
  _ShoesImageContainerState createState() => _ShoesImageContainerState();
}

class _ShoesImageContainerState extends State<ShoesImageContainer> {
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.0,
      child: Stack(
        children: [
          PageView(
            onPageChanged: (index) {
              setState(() {
                _selectedPage = index;
              });
            },
            children: [
              for (var i = 0; i < widget.shoes.images.length; i++)
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.shoes.images['$i']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            ],
          ),
          Positioned(
            bottom: 20.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < widget.shoes.images.length; i++)
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                    margin: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    width: _selectedPage == i ? 35.0 : 10.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
