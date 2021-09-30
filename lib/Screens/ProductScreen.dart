import 'package:flutter/material.dart';
import 'package:shopping_cart2/Firebase/Firestore.dart';
import 'package:shopping_cart2/Model/FavoriteAndCart.dart';
import 'package:shopping_cart2/Model/Shoes.dart';
import 'package:shopping_cart2/Widget/ShoesImageContainer.dart';

class ProductScreen extends StatefulWidget {
  final String currentUserId;
  final Shoes shoes;
  ProductScreen({
    Key? key,
    required this.currentUserId,
    required this.shoes,
  }) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int _selectedIndexOfSize = 0;

  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    setupIsFavorite(
      currentUserId: widget.currentUserId,
      shoesId: widget.shoes.shoesId,
    );
  }

  /*shoesをfavoriteしているか判断するメソッド*/
  setupIsFavorite({
    required String currentUserId,
    required String shoesId,
  }) async {
    bool _isFavoriteShoes = await Firestore().isFavorite(
      currentUserId: currentUserId,
      shoesId: shoesId,
    );
    if (mounted) {
      if (_isFavoriteShoes == true) {
        setState(() {
          _isFavorite = true;
        });
      } else {
        setState(() {
          _isFavorite = false;
        });
      }
    }
  }

  favoriteShoes({
    required String currentUserId,
    required String shoesId,
    required String name,
    required String price,
    required String type,
    required String image,
    required String size,
  }) async {
    if (_isFavorite == true) {
      setState(() {
        _isFavorite = false;
      });
      Firestore().deleteFromFavorite(
        currentUserId: widget.currentUserId,
        shoesId: widget.shoes.shoesId,
      );
    } else {
      setState(() {
        _isFavorite = true;
      });
      FavoriteAndCart favoriteAndCart = FavoriteAndCart(
        currentUserId: currentUserId,
        shoesId: shoesId,
        name: name,
        price: price,
        type: type,
        image: image,
        size: size,
      );
      Firestore().addToFavorite(favorite: favoriteAndCart);
    }
  }

  @override
  Widget build(BuildContext context) {
    /*初期時のサイズはsizeの先頭の値とする*/
    String _selectedSize = widget.shoes.size['0']!;

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
                      Text(
                        widget.shoes.type,
                        style: TextStyle(
                          color: Colors.grey.shade600,
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
                      Container(
                        child: Row(
                          children: [
                            for (var i = 0; i < widget.shoes.size.length; i++)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedIndexOfSize = i;
                                    _selectedSize = widget.shoes.size['$i']!;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(top: 10, right: 10),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: _selectedIndexOfSize == i
                                          ? Colors.black
                                          : Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        widget.shoes.size['$i']!,
                                        style: TextStyle(
                                          color: _selectedIndexOfSize == i
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                favoriteShoes(
                                  currentUserId: widget.currentUserId,
                                  shoesId: widget.shoes.shoesId,
                                  name: widget.shoes.name,
                                  type: widget.shoes.type,
                                  price: widget.shoes.price,
                                  size: _selectedSize,
                                  image: widget.shoes.images['0']!,
                                );
                              },
                              child: Icon(
                                _isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 30,
                                color: _isFavorite ? Colors.red : Colors.black,
                              ),
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
