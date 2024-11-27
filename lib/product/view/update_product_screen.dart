import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
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

  @override
  void initState() {
    super.initState();
    nameController.text = widget.product.name ?? 'no name';
    descriptionController.text = widget.product.description ?? 'no description';
    priceController.text = widget.product.price?.toString() ?? 'no price';
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
        child: Column(
          children: [
            nameTextFeild(),
            const SizedBox(height: 16),
            descTextFeild(),
            const SizedBox(height: 16),
            priceTextFeild(),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
              onPressed: () async {
                final updatedProduct = Product(
                  sId: widget.product.sId,
                  name: nameController.text,
                  description: descriptionController.text,
                  price: int.tryParse(priceController.text),
                );
                final provider =
                    Provider.of<ProductProvider>(context, listen: false);
                await provider.updateProduct(
                    widget.product.sId!, updatedProduct);
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
    );
  }

  TextField priceTextFeild() {
    return TextField(
      controller: priceController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: 'Enter Price'),
    );
  }

  TextField descTextFeild() {
    return TextField(
      controller: descriptionController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: 'Enter Description'),
    );
  }

  TextField nameTextFeild() {
    return TextField(
      controller: nameController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: 'Enter Product Name'),
    );
  }
}
