import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_cart2/Constants/Constants.dart';
import 'package:shopping_cart2/Model/FavoriteAndCart.dart';

class Firestore {
  /*プロフィール関連*/
  Future<void> registerUser({
    required String userId,
    required String email,
  }) async {
    DocumentReference usersReference = usersRef.doc(userId);
    await usersReference.set({
      'userId': usersReference.id,
      'email': email,
    });
  }

  /*Favoriteに追加*/
  Future<void> addToFavorite({
    required String currentUserId,
    required FavoriteAndCart favorite,
  }) async {
    await favoritesRef
        .doc(currentUserId)
        .collection('favoriteShoes')
        .doc(favorite.shoesId)
        .set({
      'shoesId': favorite.shoesId,
      'name': favorite.name,
      'price': favorite.price,
      'type': favorite.type,
      'image': favorite.image,
      'size': favorite.size,
      'timestamp': favorite.timestamp,
    });
  }

  Future<void> deleteFromFavorite({
    required String currentUserId,
    required String shoesId,
  }) async {
    await favoritesRef
        .doc(currentUserId)
        .collection('favoriteShoes')
        .doc(shoesId)
        .delete();
  }

  Future<bool> isFavorite({
    required String currentUserId,
    required String shoesId,
  }) async {
    DocumentSnapshot isFavoriteSnap = await favoritesRef
        .doc(currentUserId)
        .collection('favoriteShoes')
        .doc(shoesId)
        .get();
    return isFavoriteSnap.exists;
  }

  /*Cartに追加*/
  Future<void> addToCart({
    required String currentUserId,
    required FavoriteAndCart cart,
  }) async {
    await cartRef
        .doc(currentUserId)
        .collection('cartShoes')
        .doc(cart.shoesId)
        .set({
      'shoesId': cart.shoesId,
      'name': cart.name,
      'price': cart.price,
      'type': cart.type,
      'image': cart.image,
      'size': cart.size,
      'timestamp': cart.timestamp,
    });
  }

  Future<void> deleteFromCart({
    required String currentUserId,
    required String shoesId,
  }) async {
    await cartRef
        .doc(currentUserId)
        .collection('cartShoes')
        .doc(shoesId)
        .delete();
  }
}
