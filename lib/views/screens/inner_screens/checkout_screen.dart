import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uber_app/cont/global_varaible.dart';
import 'package:uber_app/views/screens/main_Screen.dart';
import 'package:uuid/uuid.dart';

import '../../../provider/cart_provider.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  Map<String, dynamic>? paymentIntent = {};

  Future<void> makePayment(
      double productPrice, String email, String name) async {
    try {
      String customerId = await createStripeCustomer(email, name);
      paymentIntent = await createPaymentIntent(productPrice, customerId);
      print(paymentIntent);

      var gpay = stripe.PaymentSheetGooglePay(
        merchantCountryCode: "US",
        currencyCode: "US",
        testEnv: true,
      );

      await stripe.Stripe.instance.initPaymentSheet(
        paymentSheetParameters: stripe.SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          style: ThemeMode.dark,
          googlePay: gpay,
          merchantDisplayName: 'Macaualay',
        ),
      );
      displayPaymentSheet();
    } catch (e) {
      print('Error: $e');
    }
  }

  void displayPaymentSheet() {
    try {
      stripe.Stripe.instance.presentPaymentSheet().then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Done')));
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${e.toString()}')));
    }
  }

  Future<String> createStripeCustomer(String email, String name) async {
    try   {
      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/customers'),
        headers: {
          'Authorization':
              'Bearer sk_test_51Nv0TYLcpVDSklU4dydjyJfHJ9KamShhjRJlS3osm696jv1QsHn5HMts03pFxFbwwokNcGRZQRNmFUac1MLeJgnW00Q0oGYb5B',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'email': email,
          'name': name,
        },
      );

      if (response.statusCode == 200) {
        final customerData = json.decode(response.body);
        return customerData['id']; // Return the customer ID
      } else {
        throw Exception('Failed to create customer: ${response.body}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(
    double amount,
    String customerEmail,
  ) async {
    try {
      Map<String, dynamic> body = {
        'amount': (amount * 100).toInt().toString(), // Convert amount to cents
        'currency': "USD", // Use lowercase "usd"
        'customer': customerEmail, // Add customer email
        // Add customer name
      };

      http.Response response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        body: body,
        headers: {
          'Authorization':
              'Bearer sk_test_51Nv0TYLcpVDSklU4dydjyJfHJ9KamShhjRJlS3osm696jv1QsHn5HMts03pFxFbwwokNcGRZQRNmFUac1MLeJgnW00Q0oGYb5B',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      return json.decode(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalAmount = ref.read(cartProvider.notifier).calculateTotalAmount();

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final _cartProvider = ref.read(cartProvider.notifier);
    CollectionReference users = FirebaseFirestore.instance.collection('buyers');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.pink,
              title: Text(
                'Checkout',
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: ListView.builder(
              shrinkWrap: true,
              itemCount: _cartProvider.getCartItems.length,
              itemBuilder: (context, index) {
                final cartData =
                    _cartProvider.getCartItems.values.toList()[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    child: SizedBox(
                      height: 170,
                      child: Row(children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.network(cartData.imageUrl[0]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartData.productName,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 5,
                                ),
                              ),
                              Text(
                                '\$' + " " + cartData.price.toStringAsFixed(2),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 5,
                                  color: Colors.pink,
                                ),
                              ),
                              OutlinedButton(
                                onPressed: null,
                                child: Text(
                                  cartData.productSize,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                );
              },
            ),
            bottomSheet: TextButton(
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: InkWell(
                  onTap: () async {
                    await makePayment(
                      totalAmount,
                      data['email'],
                      data['firstName'],
                    ).whenComplete(() {
                      _cartProvider.getCartItems.forEach((key, item) async {
                        final orderId = Uuid().v4();
                        await _firestore.collection('orders').doc(orderId).set({
                          'orderId': orderId,
                          'vendorId': item.vendorId,
                          'email': data['email'],
                          'placeName': data['placeName'],
                          'buyerId': data['buyerId'],
                          'fullName': data['firstName'],
                          'lastName': data['lastName'],
                          'buyerPhoto': data['userImage'],
                          'productName': item.productName,
                          'productPrice': item.quantity * item.price,
                          'productId': item.productId,
                          'productImage': item.imageUrl,
                          'quantity': item.quantity,
                          'productSize': item.productSize,
                          'orderDate': DateTime.now(),
                          'accepted': false,
                        }).whenComplete(() async {
                          EasyLoading.dismiss();
                        });
                      });
                    });
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'PLACE ORDER',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 6,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        return Center(
          child: CircularProgressIndicator(
            color: Colors.pink,
          ),
        );
      },
    );
  }
}
