import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:saga_kart_admin/cart/model/cart_item.dart';
import 'package:saga_kart_admin/cart/model/cart_model.dart';
import 'package:saga_kart_admin/cart/provider/cart_provider.dart';
import 'package:saga_kart_admin/order/model/order_product_item_model.dart';
import 'package:saga_kart_admin/order/model/order_request_model.dart';
import 'package:saga_kart_admin/order/provider/order_provider.dart';
import 'package:saga_kart_admin/product/model/product_model.dart';
import 'package:saga_kart_admin/profile/model/shipping_address_model.dart';
import 'package:saga_kart_admin/profile/view/add_shipping_address_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    fetchCartItems();
    super.initState();
  }

  Future fetchCartItems() async {
    final provider = Provider.of<CartProvider>(context, listen: false);
    provider.fetchCartItems();
  }

  void showDeleteDialog(BuildContext context, CartItem cartItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Confirm Deletion',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to delete this product: ${cartItem.product?.name ?? ''}?',
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                final cartProvider =
                    Provider.of<CartProvider>(context, listen: false);
                cartProvider.deleteCartItem(cartItem.product?.id ?? '');
                Navigator.of(context).pop();
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: const Text(
            'Cart Screen',
          ),
          actions: [
            IconButton(
                onPressed: () {
                  fetchCartItems();
                },
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.black,
                ))
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            bool isWeb = constraints.maxWidth > 800;
            return Column(
              children: [
                Consumer<CartProvider>(
                  builder: (context, provider, child) {
                    return provider.isLoading
                        ? const Expanded(
                            child: Center(
                              child: SpinKitHourGlass(
                                color: Colors.blue,
                              ),
                            ),
                          )
                        : Expanded(
                            child: GridView.builder(
                              padding: const EdgeInsets.all(16.0),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: isWeb ? 3 : 1,
                                childAspectRatio: isWeb ? 3 / 1.5 : 3 / 1,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                              itemCount:
                                  provider.cartResponse?.items?.length ?? 0,
                              itemBuilder: (context, index) {
                                CartItem cartItem =
                                    provider.cartResponse!.items![index];

                                return GestureDetector(
                                  onLongPress: () {
                                    showDeleteDialog(context, cartItem);
                                  },
                                  child: Card(
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cartItem.product?.name ?? '',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: isWeb ? 18 : 16,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Price: Rs.${cartItem.product?.price ?? '0'}',
                                                style: const TextStyle(
                                                  color: Colors.green,
                                                ),
                                              ),
                                              Text(
                                                'Qty: ${cartItem.quantity ?? '0'}',
                                                style: const TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    shape:
                                                        const CircleBorder()),
                                                onPressed: () {
                                                  int quty =
                                                      cartItem.quantity ?? 0;
                                                  if (quty > 0) {
                                                    quty--;
                                                    cartItem.quantity = quty;

                                                    provider.updateCartQuantity(
                                                      CartModel(
                                                        productId: cartItem
                                                                .product?.id ??
                                                            '',
                                                        quantity: quty,
                                                      ),
                                                    );
                                                  }
                                                },
                                                child: Icon(
                                                  Icons.remove,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              Text(cartItem.quantity
                                                      ?.toString() ??
                                                  '0'),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    shape:
                                                        const CircleBorder()),
                                                onPressed: () {
                                                  int quty =
                                                      cartItem.quantity ?? 0;
                                                  quty++;
                                                  cartItem.quantity = quty;

                                                  provider.updateCartQuantity(
                                                    CartModel(
                                                      productId: cartItem
                                                              .product?.id ??
                                                          '',
                                                      quantity: quty,
                                                    ),
                                                  );
                                                },
                                                child: const Icon(
                                                  Icons.add,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                  },
                ),
                InkWell(
                  onTap: () async {
                    ShippingAddress? shippingAddress = await Navigator.push(
                        context, MaterialPageRoute(builder: (context) {
                      return const AddShippingAddressScreen();
                    }));
                    placeOrder(shippingAddress, context);
                  },
                  child: Container(
                    height: 70,
                    width: isWeb ? 250 : 200,
                    decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Text(
                        'Save Address & Order',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        ),
      ),
    );
  }

  void placeOrder(ShippingAddress? shippingAddress, BuildContext context) {
    if (shippingAddress != null) {
      final orderProvider = Provider.of<OrderProvider>(context, listen: false);
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      List<CartItem> cartItems = cartProvider.cartResponse?.items ?? [];
      List<OrderProductItem> orderProductItemList = [];
      for (int a = 0; a < cartItems.length; a++) {
        CartItem cartItem = cartItems[a];
        Product? product = cartItem.product;
        if (product != null) {
          OrderProductItem orderProductItem = OrderProductItem(
              product: product.id!,
              discountAmount: product.discountAmount ?? 0,
              quantity: cartItem.quantity ?? 0,
              price: product.price,
              name: product.name,
              totalPrice: cartProvider.cartResponse?.subtotal ?? 0);
          orderProductItemList.add(orderProductItem);
        }
      }
      OrderRequestModel orderRequestModel = OrderRequestModel(
          items: orderProductItemList, shippingAddress: shippingAddress);
      orderProvider.orderPlace(orderRequestModel);
      if (orderProvider.error == null) {
        cartProvider.clearCart();
      }
    }
  }
}
