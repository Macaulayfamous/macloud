import 'package:cloud_firestore/cloud_firestore.dart';

class WishListModels {
  final String productName;
  final String productId;
  final List imageUrl;
  final int quantity;
  final int productQuantity;
  final double price;
  final String vendorId;
  final String productSize;
  final Timestamp scheduleDate;

  WishListModels({
    required this.productName,
    required this.productId,
    required this.imageUrl,
    required this.quantity,
    required this.productQuantity,
    required this.price,
    required this.vendorId,
    required this.productSize,
    required this.scheduleDate,
  });
}
