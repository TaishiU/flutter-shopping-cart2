import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart2/Firebase/Auth.dart';
import 'package:shopping_cart2/Firebase/Firestore.dart';
import 'package:shopping_cart2/Model/FavoriteAndCart.dart';
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
  // int tax = 0;
  // int subTotalPrice = 0; /* Pay用 */
  // int totalPrice = 0; /* Pay用 */
  // late String subTotalResult; /* 表示用 */
  // late String totalResult; /* 表示用 */
  //
  // calculatePrice({shoesPrice}) {
  //   subTotalPrice -= shoesPrice as int;
  //   if (subTotalPrice < 15000) {
  //     /*小計が15,000円未満であれば配送手数料550円がかかる*/
  //     tax = 550;
  //     totalPrice = subTotalPrice + tax;
  //   } else {
  //     /*小計が15,000円以上であれば配送手数料は無料*/
  //     tax = 0;
  //     totalPrice = subTotalPrice + tax;
  //   }
  //   final formatter = NumberFormat('#,###');
  //   subTotalResult = formatter.format(subTotalPrice);
  //   totalResult = formatter.format(totalPrice);
  // }

  Future<QuerySnapshot<Map<String, dynamic>>>? cartShoesList;

  @override
  void initState() {
    super.initState();
    cartShoesList = Firestore().getFromCart(
      currentUserId: widget.currentUserId,
    );
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
      body: FutureBuilder(
        future: cartShoesList,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.docs.length == 0) {
            return Center(
              child: Text(
                'カートにアイテムがありません...',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            );
          }
          List<DocumentSnapshot> cartListSnap = snapshot.data!.docs;
          return ListView(
            physics: BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            children: cartListSnap.map((cartSnap) {
              FavoriteAndCart cart = FavoriteAndCart.fromDoc(cartSnap);
              print('cart: $cart');
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  children: [
                    // Container(
                    //   height: 90,
                    //   color: Colors.yellow,
                    //   child: Center(
                    //       // child: Text(
                    //       //   '1 商品  |  ¥$subTotalPrice',
                    //       //   style: TextStyle(
                    //       //     fontSize: 15,
                    //       //     fontWeight: FontWeight.bold,
                    //       //   ),
                    //       // ),
                    //       ),
                    // ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => ProductScreen(
                        //       currentUserId: widget.currentUserId,
                        //       shoesId: cart.shoesId,
                        //       shoesPrice: shoesPrice,
                        //     ),
                        //   ),
                        // );
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: NetworkImage(cart.image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Text(
                                          cart.name,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Firestore().deleteFromCart(
                                            currentUserId: widget.currentUserId,
                                            shoesId: cart.shoesId,
                                          );
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
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'サイズ  ${cart.size}',
                                        style: TextStyle(
                                            //color: Colors.grey,
                                            ),
                                      ),
                                      // Text(
                                      //   '¥$shoesPrice',
                                      //   style: TextStyle(
                                      //     fontSize: 15,
                                      //     fontWeight: FontWeight.bold,
                                      //   ),
                                      // ),
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
          );
        },
      ),
      // body: StreamBuilder(
      //   stream: cartRef
      //       .doc(widget.currentUserId)
      //       .collection('cartShoes')
      //       .orderBy('timestamp', descending: true)
      //       .snapshots(),
      //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //     if (!snapshot.hasData) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     List<DocumentSnapshot> favoriteShoesList = snapshot.data!.docs;
      //     for (var shoes in favoriteShoesList) {
      //       subTotalPrice += shoes['price'] as int;
      //       if (subTotalPrice < 15000) {
      //         /*小計が15,000円未満であれば配送手数料550円がかかる*/
      //         tax = 550;
      //         totalPrice = subTotalPrice + tax;
      //       } else {
      //         /*小計が15,000円以上であれば配送手数料円がかかる*/
      //         tax = 0;
      //         totalPrice = subTotalPrice + tax;
      //       }
      //     }
      //     return ListView(
      //       physics: BouncingScrollPhysics(
      //         parent: AlwaysScrollableScrollPhysics(),
      //       ),
      //       children: favoriteShoesList.map((favoriteShoes) {
      //         FavoriteAndCart cart = FavoriteAndCart.fromDoc(favoriteShoes);
      //
      //         /*シューズの価格をintからStringに置き換え*/
      //         final formatter = NumberFormat("#,###");
      //         var shoesPrice = formatter.format(cart.price);
      //
      //         return Padding(
      //           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      //           child: Column(
      //             children: [
      //               Container(
      //                 height: 90,
      //                 color: Colors.yellow,
      //                 child: Center(
      //                   child: Text(
      //                     '1 商品  |  ¥$subTotalPrice',
      //                     style: TextStyle(
      //                       fontSize: 15,
      //                       fontWeight: FontWeight.bold,
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //               GestureDetector(
      //                 onTap: () {
      //                   Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                       builder: (context) => ProductScreen(
      //                         currentUserId: widget.currentUserId,
      //                         shoesId: cart.shoesId,
      //                         shoesPrice: shoesPrice,
      //                       ),
      //                     ),
      //                   );
      //                 },
      //                 child: Container(
      //                   color: Colors.transparent,
      //                   child: Row(
      //                     children: [
      //                       Container(
      //                         height: 100,
      //                         width: 100,
      //                         decoration: BoxDecoration(
      //                           borderRadius: BorderRadius.circular(20),
      //                           image: DecorationImage(
      //                             image: NetworkImage(cart.image),
      //                             fit: BoxFit.cover,
      //                           ),
      //                         ),
      //                       ),
      //                       SizedBox(width: 10),
      //                       Expanded(
      //                         child: Column(
      //                           crossAxisAlignment: CrossAxisAlignment.start,
      //                           children: [
      //                             Row(
      //                               mainAxisAlignment:
      //                                   MainAxisAlignment.spaceBetween,
      //                               children: [
      //                                 Container(
      //                                   width:
      //                                       MediaQuery.of(context).size.width *
      //                                           0.5,
      //                                   child: Text(
      //                                     cart.name,
      //                                     style: TextStyle(
      //                                       fontSize: 15,
      //                                       fontWeight: FontWeight.bold,
      //                                     ),
      //                                   ),
      //                                 ),
      //                                 GestureDetector(
      //                                   onTap: () {
      //                                     Firestore().deleteFromCart(
      //                                       currentUserId: widget.currentUserId,
      //                                       shoesId: cart.shoesId,
      //                                     );
      //                                   },
      //                                   child: Icon(
      //                                     Icons.clear,
      //                                     color: Colors.grey,
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                             Text(
      //                               cart.type,
      //                               style: TextStyle(
      //                                 color: Colors.grey,
      //                               ),
      //                             ),
      //                             SizedBox(height: 10),
      //                             Row(
      //                               mainAxisAlignment:
      //                                   MainAxisAlignment.spaceBetween,
      //                               children: [
      //                                 Text(
      //                                   'サイズ  ${cart.size}',
      //                                   style: TextStyle(
      //                                       //color: Colors.grey,
      //                                       ),
      //                                 ),
      //                                 Text(
      //                                   '¥$shoesPrice',
      //                                   style: TextStyle(
      //                                     fontSize: 15,
      //                                     fontWeight: FontWeight.bold,
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                           ],
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         );
      //       }).toList(),
      //     );
      //   },
      // ),
    );
  }
}
