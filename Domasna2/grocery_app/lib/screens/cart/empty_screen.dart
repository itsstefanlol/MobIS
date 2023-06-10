import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/inner_screens/feed_screen.dart';
import 'package:grocery_app/screens/btm_bar.dart';
import 'package:grocery_app/screens/home_screen.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/widgets/text_widget.dart';

import '../../services/utils.dart';
import '../../widgets/back_widget.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen(
      {super.key,
      required this.imagePath,
      required this.text,
      required this.title,
      required this.subtitle,
      required this.buttonText});

  final String imagePath, text, title, subtitle, buttonText;

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
    final themeState = Utils(context).getTheme;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            if (text.contains('Cart')) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BottomBarScreen()),
              );
            } else {
              Navigator.canPop(context) ? Navigator.pop(context) : null;
            }
          },
          child: Icon(
            IconlyLight.arrowLeft2,
            color: color,
            size: 24,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: TextWidget(
          text: text,
          color: color,
          textSize: 20.0,
          isTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                // 'assets/images/cart.png',
                imagePath,
                width: double.infinity,
                height: size.height * 0.4,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Whoops!',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                  fontSize: 40,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextWidget(
                // text: 'There are no items in your cart yet',
                text: title,
                color: Colors.cyan,
                textSize: 20,
              ),
              TextWidget(
                // text: 'There are no items in your cart yet',
                text: subtitle,
                color: Colors.cyan,
                textSize: 16,
                maxLines: 2,
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(
                      color: color,
                    ),
                  ),
                  primary: Theme.of(context).colorScheme.secondary,
                  // onPrimary: color,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 20,
                  ),
                ),
                onPressed: () {
                  GlobalMethods.navigateTo(
                      ctx: context, routeName: FeedScreen.routeName);
                },
                child: TextWidget(
                  // text: 'Shop now',
                  text: buttonText,
                  color:
                      themeState ? Colors.grey.shade300 : Colors.grey.shade600,
                  textSize: 20,
                  isTitle: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
