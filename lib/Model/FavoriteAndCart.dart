import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteAndCart {
  String shoesId;
  String name;
  int price;
  String type;
  String image;
  String size;
  Timestamp timestamp;

  FavoriteAndCart({
    required this.shoesId,
    required this.name,
    required this.price,
    required this.type,
    required this.image,
    required this.size,
    required this.timestamp,
  });

  factory FavoriteAndCart.fromDoc(DocumentSnapshot doc) {
    return FavoriteAndCart(
      shoesId: doc['shoesId'],
      name: doc['name'],
      price: doc['price'],
      type: doc['type'],
      image: doc['image'],
      size: doc['size'],
      timestamp: doc['timestamp'],
    );
  }
}
