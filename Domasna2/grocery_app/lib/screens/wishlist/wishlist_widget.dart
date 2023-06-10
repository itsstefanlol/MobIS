import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/inner_screens/product_details.dart';
import 'package:grocery_app/models/wishlist_model.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/widgets/heart_btn.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../../models/products_model.dart';
import '../../providers/cart_provider.dart';
import '../../providers/products_provider.dart';
import '../../providers/wishlist_provider.dart';
import '../../services/utils.dart';

class WishlistWidget extends StatelessWidget {
  const WishlistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final Color color = utils.color;
    Size size = utils.getScreenSize;
    final productsProvider = Provider.of<ProductsProvider>(context);
    final wishlistModel = Provider.of<WishlistModel>(context);
    final wishlistProvider= Provider.of<WishlistProvider>(context);
    final getCurentProduct =
        productsProvider.findProductById(wishlistModel.productId);
    double usedPrice = getCurentProduct.isOnSale
        ? getCurentProduct.salePrice
        : getCurentProduct.price;
    bool? _isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(getCurentProduct.id);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: wishlistModel .productId);
        },
        child: Container(
          height: size.height * 0.20,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(color: color, width: 1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(children: [
            Flexible(
              flex: 3,
              child: Container(
                margin: EdgeInsets.only(left: 8),
                width: size.width * 0.2,
                height: size.height * 0.25,
                child: FancyShimmerImage(
                  imageUrl: getCurentProduct.imageUrl,
                  height: size.width * 0.22,
                  width: size.width * 0.22,
                  boxFit: BoxFit.fill,
                  errorWidget: Image.asset(
                    // 'assets/images/sales/peach.jpg',
                    getCurentProduct.imageUrl,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            IconlyLight.bag2,
                            color: color,
                          ),
                        ),
                        HeartBTN(
                          productId: getCurentProduct.id,
                          isInWishlist: _isInWishlist,
                        ),
                      ],
                    ),
                  ),
                  TextWidget(
                    text: getCurentProduct.title,
                    color: color,
                    textSize: 20,
                    maxLines: 1,
                    isTitle: true,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextWidget(
                    text: '\$${usedPrice.toStringAsFixed(2)}',
                    color: color,
                    textSize: 18,
                    maxLines: 1,
                    isTitle: true,
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
