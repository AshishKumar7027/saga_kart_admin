import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saga_kart_admin/category/model/category_model.dart';
import 'package:saga_kart_admin/category/provider/category_provider.dart';

class UpdateCategoryScreen extends StatefulWidget {
  const UpdateCategoryScreen({super.key, required this.category});
  final CategoryModel category;
  @override
  State<UpdateCategoryScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateCategoryScreen> {
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller();
  }
  void controller(){
    nameController.text=widget.category.name.toString();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Category',
        ),
      ),
      body: saveData(),
    );
  }

  Widget saveData() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            createTextField(nameController, 'Enter Category '),

            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: updateProductButton,

                child: const Text(
                  'Update Category',
                  style: TextStyle(fontSize: 16, ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateProductButton() async {
    CategoryModel categoryModel = CategoryModel(
        name: nameController.text,
        sId: widget.category.sId,

    );
    CategoryProvider provider =
    Provider.of<CategoryProvider>(context, listen: false);
    await provider.updateCategory(widget.category.sId!,categoryModel);
    if (mounted) {
      if (provider.success){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Category updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
        await provider.fetchCategory();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Category update koni hov k kra '),
            backgroundColor: Colors.green,
          ),
        );
      }
      nameController.clear();

    }
  }

  Widget createTextField(TextEditingController controller, String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}