import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saga_kart_admin/cart/model/cart_model.dart';
import 'package:saga_kart_admin/cart/model/cart_response.dart';
import 'package:saga_kart_admin/cart/service/cart_service.dart';
import 'package:saga_kart_admin/core/app_util.dart';

class CartProvider extends ChangeNotifier {
  CartProvider(this.cartService);

  final CartService cartService;
  bool isLoading=false;
  String? error;
  CartResponse? cartResponse;

  Future fetchCartItems()async{
    try{
      error = null;
      isLoading = true;
       // notifyListeners();
      cartResponse = await cartService.fetchCartItems();
      isLoading = false;
    }catch(e){
      cartResponse=null;
      isLoading = false;
      error=e.toString();
      AppUtil.showToast(error!);
    }
    notifyListeners();
  }
  Future addToCart(CartModel cartModel) async {
    try {
      error=null;
      isLoading=true;
      notifyListeners();
     final success = await cartService.addToCart(cartModel);
     if(success){
       AppUtil.showToast('Item Added To Cart');
       fetchCartItems();
     }
     isLoading=false;
    } catch (e) {
      isLoading=false;
      error=e.toString();
      AppUtil.showToast(error!);
    }
    notifyListeners();
  }


  Future updateCartQuantity(CartModel cartModel) async {
    try {
      error=null;
      isLoading=true;
      notifyListeners();
      final success = await cartService.updateCartQuantity(cartModel);
      if(success){
        AppUtil.showToast('${cartModel.quantity}  Quantity updated');
      }
      isLoading=false;
    } catch (e) {
      isLoading=false;
      error=e.toString();
      AppUtil.showToast(error!);
    }
    notifyListeners();
  }
  Future deleteCartItem(String id)async{
    try{
      error=null;
      isLoading=true;
      notifyListeners();
      bool isSuccess =await  cartService.deleteCartItem(id);
      isLoading=false;
      if(isSuccess){
        fetchCartItems();
        AppUtil.showToast('Cart item deleted successfully');
      }

    }catch(e){
      error=e.toString();
    }
    notifyListeners();
  }
  Future clearCart()async{
    try{
      error=null;
      isLoading=true;
      notifyListeners();
      await cartService.clearCart();
       fetchCartItems();
    }catch(e){
      error=e.toString();
    }
    notifyListeners();
  }
}
