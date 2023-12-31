import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_app/models/vendorModels.dart';

class VendorStoreController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<Vendor> categories = <Vendor>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchVendorStores();
  }

  void _fetchVendorStores() {
    _firestore.collection('vendors').snapshots().listen((querySnapshot) {
      categories.assignAll(
        querySnapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Vendor(
            VendorName: data['bussinessName'],
            VendorImage: data['storeImage'],
          );
        }).toList(),
      );
    });
  }
}
