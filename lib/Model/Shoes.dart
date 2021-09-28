import 'package:cloud_firestore/cloud_firestore.dart';

class Shoes {
  String id;
  String name;
  String description;
  String price;
  Map<String, String> images;
  Map<String, String> size;

  Shoes({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.images,
    required this.size,
  });

  factory Shoes.fromDoc(DocumentSnapshot doc) {
    return Shoes(
      id: doc['id'],
      name: doc['name'],
      description: doc['description'],
      price: doc['price'],
      images: Map<String, String>.from(doc['images']),
      size: Map<String, String>.from(doc['size']),
    );
  }
}
