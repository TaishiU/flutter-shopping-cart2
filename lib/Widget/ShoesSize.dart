import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart2/Model/Shoes.dart';

class ShoesSize extends StatefulWidget {
  final Shoes shoes;
  ShoesSize({Key? key, required this.shoes}) : super(key: key);

  @override
  _ShoesSizeState createState() => _ShoesSizeState();
}

class _ShoesSizeState extends State<ShoesSize> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          for (var i = 0; i < widget.shoes.size.length; i++)
            GestureDetector(
              onTap: () {
                setState(() {
                  _selected = i;
                });
              },
              child: Padding(
                padding: EdgeInsets.only(top: 10, right: 10),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: _selected == i ? Colors.black : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      widget.shoes.size['$i']!,
                      style: TextStyle(
                        color: _selected == i ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
