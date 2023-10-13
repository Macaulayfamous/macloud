import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uber_app/provider/favourite_provider.dart';
import 'package:uber_app/views/screens/productDetail/product_detail_screen.dart';

class ProductDetailModel extends ConsumerStatefulWidget {
  const ProductDetailModel({
    Key? key,
    required this.prouctData,
    required this.fem,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object?> prouctData;
  final double fem;

  @override
  _ProductDetailModelState createState() => _ProductDetailModelState();
}

class _ProductDetailModelState extends ConsumerState<ProductDetailModel> {
  @override
  Widget build(BuildContext context) {
     final _wishProvider = ref.read(favouriteProvider.notifier);
    final wishItems = ref.watch(favouriteProvider);

    return GestureDetector(
      onTap: () {
        Get.to(ProductDetailScreen(productData: widget.prouctData),);
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 72 * widget.fem,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffdddddd)),
                color: Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0f000000),
                    offset: Offset(0 * widget.fem, 4 * widget.fem),
                    blurRadius: 6 * widget.fem,
                  ),
                ],
                borderRadius: BorderRadius.circular(
                  8.0,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 48 * widget.fem,
                      height: 50 * widget.fem,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          8.0,
                        ),
                        child: Image.network(
                          widget.prouctData['imageUrl'][0],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.prouctData['productName'],
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.525 * widget.fem,
                            color: Color(0xff000000),
                          ),
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5),
                        Text(
                          '\$${widget.prouctData['productPrice'].toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.pink,
                            letterSpacing: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 15,
            top: 8,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    _wishProvider.addProductToWish(
                      widget.prouctData['productName'],
                      widget.prouctData['productId'],
                      widget.prouctData['imageUrl'],
                      1,
                      widget.prouctData['quantity'],
                      widget.prouctData['productPrice'],
                      widget.prouctData['vendorId'],
                      '',
                      widget.prouctData['scheduleDate'],
                    );
                  },
                  icon: _wishProvider.getwishItem
                          .containsKey(widget.prouctData['productId'])
                      ? Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                        ),
                )),
          )
        ],
      ),
    );
  }
}
