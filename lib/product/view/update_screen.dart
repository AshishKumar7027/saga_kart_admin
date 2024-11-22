import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saga_kart_admin/core/app_util.dart';
import 'package:saga_kart_admin/product/model/product_model.dart';
import 'package:saga_kart_admin/product/provider/product_provider.dart';
import 'package:saga_kart_admin/product/view/product_screen.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final categoryController = TextEditingController();
  final idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Update Products'),
        actions: [
          IconButton(
            onPressed: updateButton,
            icon: Icon(
              Icons.update,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: getBody(),
    );
  }

  void updateButton() {}

  Widget getBody() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          createTextField(nameController, 'Enter Product Name'),
          createTextField(descriptionController, 'Enter Description'),
          createTextField(priceController, 'Enter Price'),
          createTextField(categoryController, 'Enter Category'),
          createTextField(idController, 'Enter id'),
          SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
              ),
              onPressed: updateProductButton,
              child: Text(
                'Update Product',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future updateProductButton() async {
    String name = nameController.text;
    String des = descriptionController.text;
    int price = int.parse(priceController.text);
    String category = categoryController.text;
    String id = idController.text;
    ProductProvider provider =
        Provider.of<ProductProvider>(context, listen: false);
    Product product = Product(
      name: name,
      description: des,
      price: price,
      category: category,
      sId: id,
    );
    await provider.updateProduct(product);
    provider.authenticated
        ? AppUtil.showTost('Update Product Successfully')
        : AppUtil.showTost('Update Unsuccessfully');
  }

  Widget createTextField(controller, hintText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
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
