import 'package:flutter/foundation.dart';
import 'package:saga_kart_admin/category/model/category_model.dart';
import 'package:saga_kart_admin/category/service/category_service.dart';
import 'package:saga_kart_admin/core/app_util.dart';

class CategoryProvider extends ChangeNotifier {
  CategoryProvider(this.categoryService);
  List<CategoryModel> categoryList = [];
  CategoryService categoryService;
  String? errorMessage;
   bool success=false;

  bool  isLoading =false;

  Future fetchCategory() async {
    try {
      categoryList = await categoryService.fetchCategory();
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future addCategory(CategoryModel category) async {
    try {
      bool success = await categoryService.addCategory(category);
      if (success) {
        notifyListeners();
        AppUtil.showToast('Category Added Successfully');
      }
    } catch (e) {
      notifyListeners();
      AppUtil.showToast(e.toString());
    }
  }

  Future deleteCategory(String id) async {
    try {
      errorMessage = null;
      bool isSuccess = await categoryService.deleteCategory(id);
      if (isSuccess) {
        AppUtil.showToast('Category deleted successfully');
      }
    } catch (e) {
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> updateCategory(String id, CategoryModel updateCategory) async {
    try {
       success = await categoryService.updateCategory(id, updateCategory);
      if (success) {
        await fetchCategory();
        AppUtil.showToast('Category updated successfully');
      }
    } catch (e) {
      AppUtil.showToast(e.toString());
    }
    notifyListeners();
  }
}
