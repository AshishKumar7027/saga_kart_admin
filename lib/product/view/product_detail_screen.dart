import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:saga_kart_admin/cart/model/cart_model.dart';
import 'package:saga_kart_admin/cart/provider/cart_provider.dart';
import 'package:saga_kart_admin/cart/view/cart_screen.dart';
import 'package:saga_kart_admin/core/app_util.dart';
import 'package:saga_kart_admin/product/model/product_model.dart';
import 'package:saga_kart_admin/product/provider/product_provider.dart';
import 'package:saga_kart_admin/product/view/update_product_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen(this.product, {super.key});

  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isLoadingCart = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('Product Details'),
          actions: [
            IconButton(
              onPressed: () async {
                showDeleteDialog();
              },
              icon: const Icon(Icons.delete),
            ),
            IconButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return UpdateProductScreen(product: widget.product);
                    },
                  ),
                );
                Navigator.pop(context);
              },
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                buildRow('Name', widget.product.name ?? 'no name'),
                const Divider(),
                buildRow(
                    'Price', widget.product.price.toString() ?? 'no price'),
                const Divider(),
                buildRow('Category Id', widget.product.categoryId),
                const Divider(),
                buildRow('Stocks', widget.product.stock.toString()),
                const Divider(),
                buildRow('Discount', widget.product.discountAmount.toString()),
                const Divider(),
                const Text(
                  'Description :-',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.product.description,
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 50),
                Row(
                  children: [
                    InkWell(
                      onTap: isLoadingCart
                          ? null
                          : () async {
                              setState(() {
                                isLoadingCart = true;
                              });

                              CartProvider cartProvider =
                                  Provider.of<CartProvider>(context,
                                      listen: false);
                              await cartProvider.addToCart(CartModel(
                                productId: widget.product.id.toString(),
                                quantity: 1,
                              ));

                              if (context.mounted) {
                                setState(() {
                                  isLoadingCart = false;
                                });

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const CartScreen()),
                                );
                              }
                            },
                      child: Container(
                        height: 70,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: isLoadingCart
                              ? const SpinKitHourGlass(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Add to cart',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future updateProduct(String id, Product updateProduct) async {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    provider.updateProduct(id, updateProduct);
    provider.fetchProducts();
  }

  Future<void> deleteProduct(BuildContext context) async {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    await provider.deleteProduct(widget.product.id.toString());
    if (provider.error == null) {
      if (context.mounted) {
        provider.fetchProducts();
        Navigator.pop(context);
        Navigator.pop(context);
        AppUtil.showToast('Product Delete Successfully');
      }
    }
  }

  void showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.green,
          icon: Icon(
            Icons.delete,
          ),
          title: const Text('Confirm Deletion'),
          content: const Text(
            'Do You Want To Remove This Item',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await deleteProduct(context);
              },
              child: const Text(
                'Remove',
              ),
            ),
          ],
        );
      },
    );
  }
}

Widget buildRow(String label, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(value, style: const TextStyle(fontSize: 15)),
    ],
  );
}
