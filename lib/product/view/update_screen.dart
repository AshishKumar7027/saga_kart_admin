// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:saga_kart_admin/core/app_util.dart';
// import 'package:saga_kart_admin/product/model/product_model.dart';
// import 'package:saga_kart_admin/product/provider/product_provider.dart';
//
// class UpdateScreen extends StatefulWidget {
//   const UpdateScreen({super.key});
//
//   @override
//   State<UpdateScreen> createState() => _UpdateScreenState();
// }
//
// class _UpdateScreenState extends State<UpdateScreen> {
//   final nameController = TextEditingController();
//   final priceController = TextEditingController();
//   final imageController = TextEditingController();
//   final descriptionController = TextEditingController();
//   final discountAmountController = TextEditingController();
//   final categoryIdController = TextEditingController();
//   final stockController = TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey,
//       appBar: AppBar(
//         backgroundColor: Colors.orange,
//         title: const Text('Update Products'),
//         actions: [
//           IconButton(
//             onPressed: updateButton,
//             icon: const Icon(
//               Icons.update,
//               color: Colors.black,
//             ),
//           )
//         ],
//       ),
//       body: getBody(),
//     );
//   }
//
//   void updateButton() {}
//
//   Widget getBody() {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         children: [
//           createTextField(nameController, 'Enter Product Name'),
//           createTextField(descriptionController, 'Enter Description'),
//           createTextField(priceController, 'Enter Price'),
//           createTextField(categoryIdController, 'Enter Category'),
//           createTextField(discountAmountController, 'Enter Discount'),
//           createTextField(imageController, 'Enter ImageUrl'),
//           createTextField(stockController, 'Enter Stock'),
//           const SizedBox(
//             height: 20,
//           ),
//           Center(
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.pink,
//               ),
//               onPressed: updateProduct,
//               child: const Text(
//                 'Update Product',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future updateProduct() async {
//     String name = nameController.text;
//     String des = descriptionController.text;
//     double price = double.parse(priceController.text);
//     String category = categoryIdController.text;
//     String image = imageController.text;
//     int stock = int.parse(stockController.text);
//     int discount = int.parse(discountAmountController.text);
//     ProductProvider provider =
//         Provider.of<ProductProvider>(context, listen: false);
//     Product product = Product(
//       name: name,
//       description: des,
//       price: price,
//       categoryId: category,
//      image:  imageController.text,
//       discountAmount: double.parse(discountAmountController.text),
//       stock: int.parse(stockController.text)
//     );
//     await provider.updateProduct(id,product);
//     provider.authenticated
//         ? AppUtil.showTost('Update Product Successfully')
//         : AppUtil.showTost('Update Unsuccessfully');
//   }
//
//   Widget createTextField(controller, hintText) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           hintText: hintText,
//         ),
//       ),
//     );
//   }
// }
