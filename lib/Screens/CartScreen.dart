import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping_cart2/Constants/Constants.dart';
import 'package:shopping_cart2/Firebase/Auth.dart';
import 'package:shopping_cart2/Firebase/Firestore.dart';
import 'package:shopping_cart2/Model/FavoriteAndCart.dart';
import 'package:shopping_cart2/Screens/ProductScreen.dart';
import 'package:shopping_cart2/Screens/WelcomeScreen.dart';

class CartScreen extends StatefulWidget {
  final String currentUserId;
  CartScreen({
    Key? key,
    required this.currentUserId,
  }) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int tax = 0;
  int subTotalPrice = 0; /* Pay用 */
  int totalPrice = 0; /* Pay用 */
  late String subTotalResult; /* 表示用 */
  late String totalResult; /* 表示用 */

  calculatePrice({required int shoesPrice}) {
    subTotalPrice -= shoesPrice;
    setState(() {
      subTotalPrice = subTotalPrice;
    });
    // if (subTotalPrice < 15000) {
    //   /*小計が15,000円未満であれば配送手数料550円がかかる*/
    //   tax = 550;
    //   totalPrice = subTotalPrice + tax;
    // } else {
    //   /*小計が15,000円以上であれば配送手数料は無料*/
    //   tax = 0;
    //   totalPrice = subTotalPrice + tax;
    // }
    // final formatter = NumberFormat('#,###');
    // subTotalResult = formatter.format(subTotalPrice);
    // totalResult = formatter.format(totalPrice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Cart',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.black,
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: StreamBuilder(
              stream: cartRef
                  .doc(widget.currentUserId)
                  .collection('cartShoes')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<DocumentSnapshot> favoriteShoesList = snapshot.data!.docs;
                for (var shoes in favoriteShoesList) {
                  subTotalPrice += shoes['price'] as int;
                  final formatter = NumberFormat('#,###');
                  subTotalResult = formatter.format(subTotalPrice);
                  // if (subTotalPrice < 15000) {
                  //   /*小計が15,000円未満であれば配送手数料550円がかかる*/
                  //   tax = 550;
                  //   totalPrice = subTotalPrice + tax;
                  // } else {
                  //   /*小計が15,000円以上であれば配送手数料円がかかる*/
                  //   tax = 0;
                  //   totalPrice = subTotalPrice + tax;
                  // }
                }
                return Column(
                  children: [
                    Container(
                      height: 90,
                      color: Colors.white,
                      child: Center(
                        child: Text(
                          '${favoriteShoesList.length.toString()} 商品  |  ¥$subTotalResult',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: favoriteShoesList.map((favoriteShoes) {
                        FavoriteAndCart cart =
                            FavoriteAndCart.fromDoc(favoriteShoes);

                        /*シューズの価格をintからStringに置き換え*/
                        final formatter = NumberFormat("#,###");
                        var shoesPrice = formatter.format(cart.price);

                        return Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductScreen(
                                        currentUserId: widget.currentUserId,
                                        shoesId: cart.shoesId,
                                        shoesPrice: shoesPrice,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                            image: NetworkImage(cart.image),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                                  child: Text(
                                                    cart.name,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Firestore().deleteFromCart(
                                                      currentUserId:
                                                          widget.currentUserId,
                                                      shoesId: cart.shoesId,
                                                    );
                                                    calculatePrice(
                                                        shoesPrice: cart.price);
                                                  },
                                                  child: Icon(
                                                    Icons.clear,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              cart.type,
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'サイズ  ${cart.size}',
                                                  style: TextStyle(
                                                      //color: Colors.grey,
                                                      ),
                                                ),
                                                Text(
                                                  '¥$shoesPrice',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
              height: 70,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                child: Text(
                  'ご購入の手続きに進む',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
