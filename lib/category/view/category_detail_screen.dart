import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saga_kart_admin/category/model/category_model.dart';
import 'package:saga_kart_admin/category/provider/category_provider.dart';
import 'package:saga_kart_admin/category/view/update_category_screen.dart';

class CategoryDetailScreen extends StatelessWidget {
  CategoryModel categoryModel;

  CategoryDetailScreen({super.key, required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: () async {
              final provider =
                  Provider.of<CategoryProvider>(context, listen: false);
              if (categoryModel.sId != null) {
                await provider.deleteCategory(categoryModel.sId!);
                await provider.fetchCategory();
                Navigator.pop(context);
              }
            },
            icon: const Icon(
              Icons.delete,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return UpdateCategoryScreen(category: categoryModel);
              }));
            },
            icon: Icon(
              Icons.edit,
            ),
          )
        ],
        title: const Text('Category Details Screen'),
      ),
      body: Row(

        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text('Name : ${categoryModel.name.toString()}'),
              Text('Category SLD : ${categoryModel.sId.toString()}'),
              Text('Category IV : ${categoryModel.iV.toString()}'),
            ],
          ),

        ],

      ),
    );
  }
}
// Text('Category SLD : ${categoryModel.sId.toString()}'),
// Text('Category IV : ${categoryModel.iV.toString()}'),

