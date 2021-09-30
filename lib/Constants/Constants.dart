import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
final usersRef = _firestore.collection('users');
final productsRef = _firestore.collection('products');
final favoritesRef = _firestore.collection('favorites');
