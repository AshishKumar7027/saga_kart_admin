import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:saga_kart_admin/order/model/order_status.dart';
import 'package:saga_kart_admin/order/provider/order_provider.dart';
import 'package:saga_kart_admin/order/view/order_detail_screen.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    fetchOrder();
    super.initState();
  }

  Future fetchOrder() async {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    orderProvider.fetchOrder();
  }

  String? selectedStatus = 'pending';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Consumer<OrderProvider>(
            builder: (context, orderProvider, child) {
              if (orderProvider.isLoading) {
                return Center(
                  child: SpinKitHourGlass(
                    color: Colors.blue,
                  ),
                );
              }

              if (orderProvider.error != null) {
                return Center(child: Text(orderProvider.error!));
              }

              if (orderProvider.orderList.isEmpty) {
                return Center(child: Text('No orders found'));
              }

              final bool isWeb = constraints.maxWidth > 800;
              final double cardWidth = isWeb ? 400 : constraints.maxWidth * 0.9;

              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: isWeb ? 40 : 10),
                itemCount: orderProvider.orderList.length,
                itemBuilder: (context, index) {
                  final order = orderProvider.orderList[index];
                  return Center(
                    child: SizedBox(
                      width: cardWidth,
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          title: Text('Order #${order.orderNumber}'),
                          subtitle: DropdownButton(
                            value: selectedStatus,
                            items: orderStatusList.map((item) {
                              return DropdownMenuItem(
                                child: Text(item),
                                value: item,
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              selectedStatus = value;
                              setState(() {});
                              final orderProvider = Provider.of<OrderProvider>(
                                  context,
                                  listen: false);
                            },
                          ),
                          trailing: Text(order.createdAt),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    OrderDetailScreen(order: order),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
