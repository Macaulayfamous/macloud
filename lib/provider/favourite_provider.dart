import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uber_app/models/favorite_models.dart';

final favouriteProvider = StateNotifierProvider<FavouriteNotifier, Map<String, WishListModels>>(
  (ref) => FavouriteNotifier(),
);


class FavouriteNotifier extends StateNotifier<Map<String, WishListModels>> {
  FavouriteNotifier() : super({});

  void addProductToWish(
    String productName,
    String productId,
    List imageUrl,
    int quantity,
    int productQuantity,
    double price,
    String vendorId,
    String productSize,
    Timestamp scheduleDate,
  ) {
    state[productId] = WishListModels(
      productName: productName,
      productId: productId,
      imageUrl: imageUrl,
      quantity: quantity,
      productQuantity: productQuantity,
      price: price,
      vendorId: vendorId,
      productSize: productSize,
      scheduleDate: scheduleDate,
    );

    // Notify listeners that the state has changed
    state = {...state};
  }

  Map<String, WishListModels> get getwishItem => state;

  void removeItem(String productId) {
    state.remove(productId);
    print('Removed product from wishlist: $productId');

    // Notify listeners that the state has changed
    state = {...state};
  }

  void removeAllItems() {
    state.clear();

    // Notify listeners that the state has changed
    state = {...state};
  
  }
}
