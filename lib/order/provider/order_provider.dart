import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saga_kart_admin/core/app_util.dart';
import 'package:saga_kart_admin/order/model/order_model.dart';
import 'package:saga_kart_admin/order/model/order_request_model.dart';
import 'package:saga_kart_admin/order/model/order_response_model.dart';
import 'package:saga_kart_admin/order/model/update_order_status_model.dart';
import 'package:saga_kart_admin/order/service/order_service.dart';

class OrderProvider extends ChangeNotifier {
  OrderService orderService;

  OrderProvider(this.orderService);

  bool isLoading = false;
  String? error;
  List<OrderModel> orderList = [];

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

  Future fetchOrder() async {
    try {
      error = null;
      isLoading = true;

      notifyListeners();

      OrderResponseModel orderResponseModel = await orderService.fetchOrder();
      orderList = orderResponseModel.orders ?? [];
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future updateOrderStatus(UpdateOrderStatusModel updateRequest) async {
    try {
      error = null;
      isLoading = true;
      notifyListeners();
      bool isSuccess = await orderService.updateOrderStatus(updateRequest);
      if (isSuccess) {
        AppUtil.showToast('Order updated successfully');
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
