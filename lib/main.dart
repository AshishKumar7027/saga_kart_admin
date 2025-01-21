import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saga_kart_admin/authentication/provider/auth_provider.dart';
import 'package:saga_kart_admin/authentication/provider/splash_provider.dart';
import 'package:saga_kart_admin/authentication/service/auth_service.dart';
import 'package:saga_kart_admin/authentication/view/splash_screen.dart';
import 'package:saga_kart_admin/cart/provider/cart_provider.dart';
import 'package:saga_kart_admin/cart/service/cart_service.dart';
import 'package:saga_kart_admin/category/provider/category_provider.dart';
import 'package:saga_kart_admin/category/service/category_service.dart';
import 'package:saga_kart_admin/dashboard/view/dashboard_screen.dart';
import 'package:saga_kart_admin/order/provider/order_provider.dart';
import 'package:saga_kart_admin/order/service/order_service.dart';
import 'package:saga_kart_admin/product/provider/product_provider.dart';
import 'package:saga_kart_admin/product/service/product_service.dart';
import 'package:saga_kart_admin/product/view/product_screen.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return AuthProvider(AuthService());
        }),
        ChangeNotifierProvider(create: (context) {
          return ProductProvider(ProductService());
        }),
        ChangeNotifierProvider(create: (context) {
          return CategoryProvider(CategoryService());
        }),
        ChangeNotifierProvider(create: (context) {
          return SplashProvider();
        }),
        ChangeNotifierProvider(create: (context) {
          return CartProvider(CartService());
        }),
        ChangeNotifierProvider(create: (context) {
          return OrderProvider(OrderService());
        }),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
