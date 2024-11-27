import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saga_kart_admin/category/model/category_model.dart';
import 'package:saga_kart_admin/category/provider/category_provider.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});
  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}
class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Category'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.category),
          )
        ],
      ),
      body: getData(),
    );
  }

  Widget getData() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          mainTextFormField(nameController, 'Enter Category Name'),
          const SizedBox(
            height: 16,
          ),
          Center(
            child: ElevatedButton(
              onPressed: addCategory,
              child: const Text(
                'Add New Category',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addCategory() async {
    String name = nameController.text;
    CategoryProvider provider =
        Provider.of<CategoryProvider>(context, listen: false);
    CategoryModel category = CategoryModel(
      name: name,
    );
    await provider.addCategory(category);
    Navigator.pop(context);
  }

  Widget mainTextFormField(controller, hintText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
