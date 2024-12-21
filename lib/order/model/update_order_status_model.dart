class UpdateOrderStatusModel{
String orderId;
String orderStatus;
UpdateOrderStatusModel(
    this.orderId,
    this.orderStatus,

    );
Map<String,dynamic> toJson(){
  return {
    'status':orderStatus,
  };
}
}