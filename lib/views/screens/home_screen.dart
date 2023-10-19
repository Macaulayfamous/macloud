import 'package:flutter/material.dart';
import 'package:uber_app/views/screens/widgets/banner_widget.dart';
import 'package:uber_app/views/screens/widgets/beauty_widget.dart';
import 'package:uber_app/views/screens/widgets/category_item.dart';
import 'package:uber_app/views/screens/widgets/category_text.dart';
import 'package:uber_app/views/screens/widgets/customAppBar.dart';
import 'package:uber_app/views/screens/widgets/home_products.dart';
import 'package:uber_app/views/screens/widgets/men_shoes.dart';
import 'package:uber_app/views/screens/widgets/reuseText_widget.dart';
import 'package:uber_app/views/screens/widgets/vendor_stores.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          CustomAppBar(),
          BannerArea(),
          VendorStore(),
          CategoryItem(),
          ResuseTextWidget(
            title: 'All Products',
          ),
          HomeproductWidget(),
          ResuseTextWidget(
            title: "Men's Shoes",
          ),
          MenShoes(),
          ResuseTextWidget(
            title: 'Beauty',
          ),
          BeautyWidget(),
        ],
      ),
    ));
  }
}
