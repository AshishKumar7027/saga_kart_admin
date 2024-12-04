import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saga_kart_admin/product/model/product_model.dart';
import 'package:saga_kart_admin/product/provider/product_provider.dart';

class UpdateProductScreen extends StatefulWidget {
  final Product product;

  const UpdateProductScreen({super.key, required this.product});

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final categoryIdController = TextEditingController();
  final imageController = TextEditingController();
  final discountAmountController = TextEditingController();
  final stockController = TextEditingController();
  // final createdController = TextEditingController();
  // final modifiedController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.product.name ?? 'no name';
    descriptionController.text = widget.product.description ?? 'no description';
    priceController.text = widget.product.price.toString() ?? 'no price';
     categoryIdController.text = widget.product.categoryId.toString();
    imageController.text = widget.product.image.toString();
    discountAmountController.text = widget.product.discountAmount.toString();
    stockController.text = widget.product.stock.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Latest Update Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildTextField(
                  nameController, 'Product name', TextInputType.text),
              Sizedbox(20),
              buildTextField(categoryIdController, 'Enter Name', TextInputType.text),
              Sizedbox(20),
              buildTextField(descriptionController, 'Enter Description',
                  TextInputType.text),
              Sizedbox(20),
              buildTextField(
                  priceController, 'Enter Price', TextInputType.number),
              Sizedbox(20),
              buildTextField(discountAmountController, 'Enter Discount',
                  TextInputType.number),
              Sizedbox(20),
              buildTextField(
                  imageController, 'Enter Image Url', TextInputType.text),
              Sizedbox(20),
              buildTextField(
                  stockController, 'Enter Stock', TextInputType.number),
              Sizedbox(20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                onPressed: () async {
                  final updatedProduct = Product(
                    categoryId: categoryIdController.text,
                    name: nameController.text,
                    description: descriptionController.text,
                    price: double.parse(priceController.text),
                    discountAmount: double.parse(discountAmountController.text),
                    stock: int.parse(stockController.text),
                    image: imageController.text,
                  );
                  final provider =
                      Provider.of<ProductProvider>(context, listen: false);
                  await provider.updateProduct(
                      widget.product.id??'0', updatedProduct);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Product updated successfully'),
                        backgroundColor: Colors.blue,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'Update Product',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox Sizedbox(double height) => SizedBox(height: height);

  TextField buildTextField(controller, String text, TextInputType inputType) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: text),
    );
  }
}
