import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteAndCart {
  String currentUserId;
  String shoesId;
  String name;
  String price;
  String type;
  String image;
  String size;

  FavoriteAndCart({
    required this.currentUserId,
    required this.shoesId,
    required this.name,
    required this.price,
    required this.type,
    required this.image,
    required this.size,
  });

  factory FavoriteAndCart.fromDoc(DocumentSnapshot doc) {
    return FavoriteAndCart(
      currentUserId: doc['currentUserId'],
      shoesId: doc['shoesId'],
      name: doc['name'],
      price: doc['price'],
      type: doc['type'],
      image: doc['image'],
      size: doc['size'],
    );
  }
}
