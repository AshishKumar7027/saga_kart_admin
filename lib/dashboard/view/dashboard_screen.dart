import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saga_kart_admin/cart/view/cart_screen.dart';
import 'package:saga_kart_admin/category/view/category_screen.dart';
import 'package:saga_kart_admin/product/view/product_screen.dart';
import 'package:saga_kart_admin/profile/view/profile_screen.dart';

class DashboardScreen extends StatefulWidget {

  const DashboardScreen({super.key,});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Widget> list = [
    const ProductScreen(),
    const CategoryScreen(),
    const CartScreen(),
    const ProfileScreen()
  ];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        onTap: (context){
          index = context;
          setState(() {

          });
        },
        items: [
          const BottomNavigationBarItem(

              icon: Icon(Icons.production_quantity_limits), label: 'Product'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined), label: 'Category'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'My Profile'),
        ],
      ),
          body: list[index],
    ));
  }
}
