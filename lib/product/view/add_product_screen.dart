import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saga_kart_admin/core/app_util.dart';
import 'package:saga_kart_admin/product/model/product_model.dart';
import 'package:saga_kart_admin/product/provider/product_provider.dart';
import 'package:saga_kart_admin/product/view/product_screen.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final categoryIdController = TextEditingController();
  final imageController = TextEditingController();
  final discountAmountController = TextEditingController();
  final stockController = TextEditingController();
  final createdController = TextEditingController();
  final modifiedController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('New Product Add'),
      ),
      body: getBody(),
    );
  }

  void updateButton() {}

  Widget getBody() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            createTextField(
                nameController, 'Enter Product Name', TextInputType.text),
            createTextField(
                descriptionController, 'Enter Description', TextInputType.text),
            createTextField(
                priceController, 'Enter Price', TextInputType.number),
            createTextField(
                categoryIdController, 'Enter Category', TextInputType.text),
            createTextField(imageController, 'Enter Image', TextInputType.text),
            createTextField(discountAmountController, 'Enter Discount',
                TextInputType.number),
            createTextField(
                stockController, 'Enter Stock', TextInputType.number),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                ),
                onPressed: addProductButton,
                child: const Text(
                  'Add New Product',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addProductButton() async {
    String name = nameController.text;
    String des = descriptionController.text;
    int price = int.parse(priceController.text);
    String categoryId = categoryIdController.text;
    int discount = int.parse(discountAmountController.text);
    int stock = int.parse(stockController.text);
    String image = imageController.text;
    ProductProvider provider =
        Provider.of<ProductProvider>(context, listen: false);
    Product product = Product(
        name: name,
        description: des,
        price: price,
        categoryId: categoryId,
        discountAmount: discount,
        stock: stock,
        image: image);
    await provider.addProduct(product);
    if (mounted) {
      provider.fetchProducts();
      Navigator.pop(context);
     AppUtil.showToast('Product Added Successfully');
    }
  }

  Widget createTextField(controller, hintText, TextInputType inputType) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        keyboardType: inputType,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
