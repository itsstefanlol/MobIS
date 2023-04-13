import 'package:flutter/cupertino.dart';
import 'package:grocery_app/models/viewed_model.dart';
import 'package:grocery_app/models/wishlist_model.dart';

class ViewedProdProvider with ChangeNotifier {
  Map<String, ViewedProductModel> _viewedProdlistItems = {};

  Map<String, ViewedProductModel> get getViewedProdlistItems {
    return _viewedProdlistItems;
  }

  void addProductToHistory({required String productId}) {
    _viewedProdlistItems.putIfAbsent(
        productId,
        () => ViewedProductModel(
            id: DateTime.now().toString(), productId: productId));

    notifyListeners();
  }

  void clearHistory() {
    _viewedProdlistItems.clear();
    notifyListeners();
  }
}
