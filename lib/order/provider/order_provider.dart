import 'package:flutter/cupertino.dart';
import 'package:saga_kart_admin/core/app_util.dart';
import 'package:saga_kart_admin/order/model/order_request_model.dart';
import 'package:saga_kart_admin/order/service/order_service.dart';

class OrderProvider extends ChangeNotifier {
  OrderService orderService;

  OrderProvider(this.orderService);

  bool isLoading = false;
  String? error;

  Future orderPlace(OrderRequestModel orderRequestModel) async {
    try {
      error = null;
      isLoading = true;
      notifyListeners();
      bool isSuccess = await orderService.orderPlace(orderRequestModel);
      if (isSuccess) {
        AppUtil.showToast('Order placed successfully');
      }
    } catch (e) {
      isLoading = false;
      error = e.toString();
    }
    notifyListeners();
  }
}
