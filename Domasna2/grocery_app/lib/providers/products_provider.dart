import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/products_model.dart';

class ProductsProvider with ChangeNotifier {
  static List<ProductModel> _productsList = [];
  List<ProductModel> get getProducts {
    return _productsList;
  }

  List<ProductModel> get getOnSaleProducts {
    return _productsList.where((element) => element.isOnSale).toList();
  }

  Future<void> fetchProducts() async {
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot productSnapshot) {
      _productsList = [];
      productSnapshot.docs.forEach((element) {
        _productsList.insert(
            0,
            ProductModel(
                id: element.get('id'),
                title: element.get('title'),
                imageUrl: element.get('imageUrl'),
                productCategoryName: element.get('productCategoryName'),
                price: double.parse(element.get('price')),
                salePrice: element.get('salePrice'),
                isOnSale: element.get('isOnSale'),
                isPiece: element.get('isPiece')));
      });
    });
    notifyListeners();
  }

  ProductModel findProductById(String productId) {
    return _productsList.firstWhere((element) => element.id == productId);
  }

  List<ProductModel> findByCategory(String categoryName) {
    List<ProductModel> _categoryList = _productsList
        .where((element) => element.productCategoryName
            .toLowerCase()
            .contains(categoryName.toLowerCase()))
        .toList();
    return _categoryList;
  }

  List<ProductModel> searchQuery(String searchText) {
    List<ProductModel> _searchList = _productsList
        .where((element) =>
            element.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    return _searchList;
  }

  // static final List<ProductModel> _productsList = [
  //   ProductModel(
  //     id: '1',
  //     title: 'Banana',
  //     imageUrl:
  //         'assets/images/sales/pngtree-banana-fruit-fresh-nutrition-png-image_3356835.png',
  //     productCategoryName: 'Fruits',
  //     price: 0.99,
  //     salePrice: 0.35,
  //     isOnSale: true,
  //     isPiece: true,
  //   ),
  //   ProductModel(
  //     id: '2',
  //     title: 'Banana',
  //     imageUrl:
  //         'assets/images/sales/pngtree-banana-fruit-fresh-nutrition-png-image_3356835.png',
  //     productCategoryName: 'Fruits',
  //     price: 0.99,
  //     salePrice: 0.35,
  //     isOnSale: true,
  //     isPiece: true,
  //   ),
  //   ProductModel(
  //     id: '3',
  //     title: 'Banana',
  //     imageUrl:
  //         'assets/images/sales/pngtree-banana-fruit-fresh-nutrition-png-image_3356835.png',
  //     productCategoryName: 'Fruits',
  //     price: 0.99,
  //     salePrice: 0.35,
  //     isOnSale: true,
  //     isPiece: true,
  //   ),
  //   ProductModel(
  //     id: '4',
  //     title: 'Banana',
  //     imageUrl:
  //         'assets/images/sales/pngtree-banana-fruit-fresh-nutrition-png-image_3356835.png',
  //     productCategoryName: 'Fruits',
  //     price: 0.99,
  //     salePrice: 0.35,
  //     isOnSale: true,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: '5',
  //     title: 'Banana',
  //     imageUrl:
  //         'assets/images/sales/pngtree-banana-fruit-fresh-nutrition-png-image_3356835.png',
  //     productCategoryName: 'Fruits',
  //     price: 0.99,
  //     salePrice: 0.35,
  //     isOnSale: true,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: '6',
  //     title: 'Banana',
  //     imageUrl:
  //         'assets/images/sales/pngtree-banana-fruit-fresh-nutrition-png-image_3356835.png',
  //     productCategoryName: 'Fruits',
  //     price: 0.99,
  //     salePrice: 0.35,
  //     isOnSale: false,
  //     isPiece: true,
  //   ),
  //   ProductModel(
  //     id: '7',
  //     title: 'Banana',
  //     imageUrl:
  //         'assets/images/sales/pngtree-banana-fruit-fresh-nutrition-png-image_3356835.png',
  //     productCategoryName: 'Fruits',
  //     price: 0.99,
  //     salePrice: 0.35,
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: '8',
  //     title: 'Banana',
  //     imageUrl:
  //         'assets/images/sales/pngtree-banana-fruit-fresh-nutrition-png-image_3356835.png',
  //     productCategoryName: 'Fruits',
  //     price: 0.99,
  //     salePrice: 0.35,
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: '9',
  //     title: 'Banana',
  //     imageUrl:
  //         'assets/images/sales/pngtree-banana-fruit-fresh-nutrition-png-image_3356835.png',
  //     productCategoryName: 'Fruits',
  //     price: 0.99,
  //     salePrice: 0.35,
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: '10',
  //     title: 'Banana',
  //     imageUrl:
  //         'assets/images/sales/pngtree-banana-fruit-fresh-nutrition-png-image_3356835.png',
  //     productCategoryName: 'Fruits',
  //     price: 0.99,
  //     salePrice: 0.35,
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: '11',
  //     title: 'Banana',
  //     imageUrl:
  //         'assets/images/sales/pngtree-banana-fruit-fresh-nutrition-png-image_3356835.png',
  //     productCategoryName: 'Fruits',
  //     price: 0.99,
  //     salePrice: 0.35,
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: '12',
  //     title: 'Banana',
  //     imageUrl:
  //         'assets/images/sales/pngtree-banana-fruit-fresh-nutrition-png-image_3356835.png',
  //     productCategoryName: 'Fruits',
  //     price: 0.99,
  //     salePrice: 0.35,
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: '13',
  //     title: 'Apricot',
  //     imageUrl: 'assets/images/sales/peach.jpg',
  //     productCategoryName: 'Fruits',
  //     price: 0.99,
  //     salePrice: 0.35,
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: '14',
  //     title: 'Apricot',
  //     imageUrl: 'assets/images/sales/peach.jpg',
  //     productCategoryName: 'Fruits',
  //     price: 0.99,
  //     salePrice: 0.35,
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: '15',
  //     title: 'Apricot',
  //     imageUrl: 'assets/images/sales/peach.jpg',
  //     productCategoryName: 'Fruits',
  //     price: 0.99,
  //     salePrice: 0.35,
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: '16',
  //     title: 'Apricot',
  //     imageUrl: 'assets/images/sales/peach.jpg',
  //     productCategoryName: 'Fruits',
  //     price: 0.99,
  //     salePrice: 0.35,
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: '17',
  //     title: 'Apricot',
  //     imageUrl: 'assets/images/sales/peach.jpg',
  //     productCategoryName: 'Fruits',
  //     price: 0.99,
  //     salePrice: 0.35,
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: '18',
  //     title: 'Apricot',
  //     imageUrl: 'assets/images/sales/peach.jpg',
  //     productCategoryName: 'Fruits',
  //     price: 0.99,
  //     salePrice: 0.35,
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: '19',
  //     title: 'Apricot',
  //     imageUrl: 'assets/images/sales/peach.jpg',
  //     productCategoryName: 'Fruits',
  //     price: 0.99,
  //     salePrice: 0.35,
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: '20',
  //     title: 'Apricot',
  //     imageUrl: 'assets/images/sales/peach.jpg',
  //     productCategoryName: 'Fruits',
  //     price: 0.99,
  //     salePrice: 0.35,
  //     isOnSale: true,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: '21',
  //     title: 'Apricot',
  //     imageUrl: 'assets/images/sales/peach.jpg',
  //     productCategoryName: 'Fruits',
  //     price: 0.99,
  //     salePrice: 0.35,
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: '22',
  //     title: 'Apricot',
  //     imageUrl: 'assets/images/sales/peach.jpg',
  //     productCategoryName: 'Fruits',
  //     price: 0.99,
  //     salePrice: 0.35,
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: '23',
  //     title: 'Apricot',
  //     imageUrl: 'assets/images/sales/peach.jpg',
  //     productCategoryName: 'Fruits',
  //     price: 0.99,
  //     salePrice: 0.35,
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: '24',
  //     title: 'Apricot',
  //     imageUrl: 'assets/images/sales/peach.jpg',
  //     productCategoryName: 'Fruits',
  //     price: 0.99,
  //     salePrice: 0.35,
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: '25',
  //     title: 'Apricot',
  //     imageUrl: 'assets/images/sales/peach.jpg',
  //     productCategoryName: 'Fruits',
  //     price: 0.99,
  //     salePrice: 0.35,
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: '26',
  //     title: 'Apricot',
  //     imageUrl: 'assets/images/sales/peach.jpg',
  //     productCategoryName: 'Fruits',
  //     price: 0.99,
  //     salePrice: 0.35,
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: '27',
  //     title: 'Apricot',
  //     imageUrl: 'assets/images/sales/peach.jpg',
  //     productCategoryName: 'Fruits',
  //     price: 0.99,
  //     salePrice: 0.35,
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: '28',
  //     title: 'Apricot',
  //     imageUrl: 'assets/images/sales/peach.jpg',
  //     productCategoryName: 'Fruits',
  //     price: 0.99,
  //     salePrice: 0.35,
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  // ];
}
