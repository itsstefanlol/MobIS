import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/widgets/on_sale_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../models/products_model.dart';
import '../providers/products_provider.dart';
import '../services/utils.dart';
import '../widgets/back_widget.dart';
import '../widgets/empty_products_widget.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeName = "/OnSaleScreen";
  const OnSaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    List<ProductModel> productsOnSale = productsProvider.getOnSaleProducts;
    final Utils utils = Utils(context);
    final Color color = utils.color;
    Size size = utils.getScreenSize;
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: 'Products on sale',
          color: color,
          textSize: 24.0,
          isTitle: true,
        ),
      ),
      body: productsOnSale.isEmpty
          ? const EmptyProdWidget(
              text: 'No products on sale yet!\nStay tuned',
            )
          : GridView.count(
              crossAxisCount: 2,
              //crossAxisSpacing: 10,
              padding: EdgeInsets.zero,
              childAspectRatio: size.width / (size.height * 0.45),
              children: List.generate(productsOnSale.length, (index) {
                return ChangeNotifierProvider.value(
                  value: productsOnSale[index],
                  child: const OnSaleWidget(),
                );
              }),
            ),
    );
  }
}
