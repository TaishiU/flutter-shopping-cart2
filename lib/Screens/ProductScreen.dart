import 'package:flutter/material.dart';
import 'package:shopping_cart2/Model/Shoes.dart';
import 'package:shopping_cart2/Widget/ShoesImageContainer.dart';
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Container(
          child: Column(
            children: [
              ShoesImageContainer(shoes: widget.shoes),
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
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Icon(
                              Icons.bookmark_border,
                              size: 30,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Container(
                              height: 65,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Center(
                                child: Text(
                                  'カートに追加',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
