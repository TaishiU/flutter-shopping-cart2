import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping_cart2/Constants/Constants.dart';
import 'package:shopping_cart2/Firebase/Auth.dart';
import 'package:shopping_cart2/Firebase/Firestore.dart';
import 'package:shopping_cart2/Model/FavoriteAndCart.dart';
import 'package:shopping_cart2/Screens/ProductScreen.dart';
import 'package:shopping_cart2/Screens/WelcomeScreen.dart';

class FavoriteScreen extends StatelessWidget {
  final String currentUserId;

  FavoriteScreen({
    Key? key,
    required this.currentUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Favorite',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
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
      body: StreamBuilder(
        stream: favoritesRef
            .doc(currentUserId)
            .collection('favoriteShoes')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<DocumentSnapshot> favoriteShoesList = snapshot.data!.docs;
          return ListView(
            physics: BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            children: favoriteShoesList.map((favoriteShoes) {
              FavoriteAndCart favorite = FavoriteAndCart.fromDoc(favoriteShoes);

              /*シューズの価格をintからStringに置き換え*/
              final formatter = NumberFormat("#,###");
              var shoesPrice = formatter.format(favorite.price);

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductScreen(
                              currentUserId: currentUserId,
                              shoesId: favorite.shoesId,
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
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: NetworkImage(favorite.image),
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
                                          favorite.name,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Firestore().deleteFromFavorite(
                                            currentUserId: currentUserId,
                                            shoesId: favorite.shoesId,
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
                                    favorite.type,
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
                                        'サイズ  ${favorite.size}',
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
          );
        },
      ),
    );
  }
}
