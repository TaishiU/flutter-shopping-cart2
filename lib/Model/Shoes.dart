import 'package:cloud_firestore/cloud_firestore.dart';

class Shoes {
  String description;
  Map<String, String> images;
  String name;
  String price;
  String shoesId;
  Map<String, String> size;
  String type;

  Shoes({
    required this.description,
    required this.images,
    required this.name,
    required this.price,
    required this.shoesId,
    required this.size,
    required this.type,
  });

  factory Shoes.fromDoc(DocumentSnapshot doc) {
    return Shoes(
      description: doc['description'],
      images: Map<String, String>.from(doc['images']),
      name: doc['name'],
      price: doc['price'],
      shoesId: doc['shoesId'],
      size: Map<String, String>.from(doc['size']),
      type: doc['type'],
    );
  }
}
