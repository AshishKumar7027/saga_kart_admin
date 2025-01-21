import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:saga_kart_admin/order/view/order_screen.dart';
import 'package:saga_kart_admin/product/model/product_model.dart';
import 'package:saga_kart_admin/product/provider/product_provider.dart';
import 'package:saga_kart_admin/product/view/add_product_screen.dart';
import 'product_detail_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    Future.microtask(() {
      fetchProvider();
    });
    super.initState();
  }

  void fetchProvider() async {
    await Provider.of<ProductProvider>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddProductScreen();
          }));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return  OrderScreen();
              }));
            },
            child: const Text(
              'My Orders',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.blue,
        title: const Text('Product Screen'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Consumer<ProductProvider>(
            builder: (context, provider, child) {
              return provider.isLoading
                  ? const Center(
                child: SpinKitHourGlass(color: Colors.blue),
              )
                  : GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: constraints.maxWidth > 800 ? 3 : 1,
                    childAspectRatio: 3 / 1,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: provider.productList.length,
                  itemBuilder: (context, index) {
                    Product product = provider.productList[index];
                    bool isWeb = constraints.maxWidth > 800;

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(product),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: isWeb ? 400 : constraints.maxWidth * 0.8,
                        height: isWeb ? 340 : 120,
                        child: Card(
                          elevation: 4,
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: isWeb ? 32 : 24,
                              backgroundImage: NetworkImage(product.image.toString()),
                            ),
                            title: Text(
                              product.name ?? 'No product name',
                              style: TextStyle(
                                fontSize: isWeb ? 18 : 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "Rs.${product.discountAmount.toString()}",
                              style: const TextStyle(color: Colors.green, fontSize: 14),
                            ),
                            trailing: Text(
                              product.price.toString(),
                              style: TextStyle(fontSize: isWeb ? 14 : 12),
                            ),
                          ),
                        ),
                      ),
                    );
                  }


              );
            },
          );
        },
      ),
    );
  }
}
