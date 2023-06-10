import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/inner_screens/product_details.dart';
import 'package:grocery_app/models/viewed_model.dart';
import 'package:grocery_app/providers/viewed_prod_provider.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:provider/provider.dart';
import '../../consts/firebase_consts.dart';
import '../../providers/cart_provider.dart';
import '../../providers/products_provider.dart';
import '../../services/utils.dart';
import '../../widgets/text_widget.dart';

class ViewedRecentlyWidget extends StatefulWidget {
  const ViewedRecentlyWidget({Key? key}) : super(key: key);

  @override
  _ViewedRecentlyWidgetState createState() => _ViewedRecentlyWidgetState();
}

class _ViewedRecentlyWidgetState extends State<ViewedRecentlyWidget> {
  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final productsProvider = Provider.of<ProductsProvider>(context);
    final viewedProductModel = Provider.of<ViewedProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final getCurentProduct =
        productsProvider.findProductById(viewedProductModel.productId);
    double usedPrice = getCurentProduct.isOnSale
        ? getCurentProduct.salePrice
        : getCurentProduct.price;
    bool? _isInCart =
        cartProvider.getCartItems.containsKey(getCurentProduct.id);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          // GlobalMethods.navigateTo(
          //     ctx: context, routeName: ProductDetails.routeName);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FancyShimmerImage(
              imageUrl: getCurentProduct.imageUrl,
              height: size.width * 0.27,
              width: size.width * 0.25,
              boxFit: BoxFit.fill,
              errorWidget: Image.asset(
                // 'assets/images/sales/peach.jpg',
                getCurentProduct.imageUrl,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              children: [
                TextWidget(
                  text: getCurentProduct.title,
                  // 'Title',
                  color: color,
                  textSize: 24,
                  isTitle: true,
                ),
                const SizedBox(
                  height: 12,
                ),
                TextWidget(
                  text: '\$${usedPrice.toStringAsFixed(2)}',
                  color: color,
                  textSize: 20,
                  isTitle: false,
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Material(
                borderRadius: BorderRadius.circular(12),
                color: Colors.green,
                child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: _isInCart
                        ? null
                        : () async {
                            final User? user = authInstance.currentUser;
                            if (user == null) {
                              GlobalMethods.errorDialog(
                                  subtitle:
                                      'User was not logged in, please log in.',
                                  context: context);
                              return;
                            }
                            await GlobalMethods.addToCart(
                                productId: getCurentProduct.id,
                                quantity: 1,
                                context: context);
                            await cartProvider.fetchCart();
                            // cartProvider.addProductToCart(
                            //   productId: getCurentProduct.id,
                            //   quantity: 1,
                            // );
                          },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        _isInCart ? Icons.check : IconlyBold.plus,
                        color: Colors.white,
                        size: 20,
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
