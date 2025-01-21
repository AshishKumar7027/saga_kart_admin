import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:saga_kart_admin/category/model/category_model.dart';
import 'package:saga_kart_admin/category/provider/category_provider.dart';
import 'package:saga_kart_admin/category/view/add_category_screen.dart';
import 'package:saga_kart_admin/category/view/category_detail_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<CategoryProvider>(context, listen: false)
          .fetchCategory();
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddCategoryScreen()),
          );
          setState(() {
            isLoading = true;
          });
          await Provider.of<CategoryProvider>(context, listen: false)
              .fetchCategory();
          setState(() {
            isLoading = false;
          });
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Category Screen'),
      ),
      body: isLoading
          ? const Center(
              child: SpinKitHourGlass(
                color: Colors.blue,
              ),
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                return Consumer<CategoryProvider>(
                  builder: (context, provider, child) {
                    if (provider.categoryList.isEmpty) {
                      return const Center(
                        child: Text('No categories found.'),
                      );
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.all(16.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: constraints.maxWidth > 800 ? 3 : 1,
                        childAspectRatio: 3 / 1,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: provider.categoryList.length,
                      itemBuilder: (context, index) {
                        final category = provider.categoryList[index];
                        final bool isWeb = constraints.maxWidth > 800;

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryDetailScreen(
                                    categoryModel: category),
                              ),
                            );
                          },
                          child: SizedBox(
                            width: isWeb ? 400 : constraints.maxWidth * 0.8,
                            height: isWeb ? 340 : 120,
                            child: Card(
                              elevation: 4,
                              child: ListTile(
                                title: Text(
                                  category.name ?? 'No name',
                                  style: TextStyle(
                                    fontSize: isWeb ? 18 : 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  category.sId ?? 'No ID',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
    );
  }
}
