import 'package:flutter/material.dart';
import 'package:saga_kart_admin/order/model/order_model.dart';

class OrderDetailScreen extends StatelessWidget {
  final OrderModel order;

  OrderDetailScreen({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order Number: ${order.orderNumber}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('User: ${order.user}'),
            SizedBox(height: 10),
            Text('Status: ${order.orderStatus}'),
            SizedBox(height: 10),
            Text(
                'Shipping Address: ${order.shippingAddress.addressLine1}, ${order.shippingAddress.city}'),
            SizedBox(height: 20),
            Text('Items:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: order.items.length,
                itemBuilder: (context, index) {
                  final item = order.items[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text(
                        'Quantity: ${item.quantity}\nPrice: ₹${item.totalPrice}'),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}