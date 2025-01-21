import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:saga_kart_admin/core/app_util.dart';
import 'package:saga_kart_admin/product/model/product_model.dart';
import 'package:saga_kart_admin/product/service/product_service.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> productList = [];
  ProductService productService;
  String? error;
  bool isLoading = false;
  bool authenticated = false;

  ProductProvider(this.productService);

  Future fetchProducts() async {
    try {
      error = null;
      isLoading = true;
      notifyListeners();
      productList = await productService.fetchProducts();
      notifyListeners();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }

  }

  Future addProduct(Product product) async {
    try {
      error = null;

      bool success = await productService.addProduct(product);
      if (success) {
        notifyListeners();
      }
    } catch (e) {
      error = e.toString();

      AppUtil.showToast(e.toString());
    }
    notifyListeners();
  }

  Future deleteProduct(String id) async {
    try {
      error = null;
      isLoading = true;
      notifyListeners();
      bool isSuccess = await productService.deleteProduct(id);
      isLoading = false;
      if (isSuccess) {}
    } catch (e) {
      error = e.toString();
    }
    notifyListeners();
  }

  Future<void> updateProduct(String id, Product updateProduct) async {
    try {
      bool success = await productService.updateProduct(id, updateProduct);
      if (success) {
        await fetchProducts();
      }
    } catch (e) {
      AppUtil.showToast(e.toString());
    }
  }
}
