import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery/core/animations/animations.dart';
import 'package:food_delivery/core/utils/size_config.dart';
import 'package:food_delivery/core/widgets/app_bar/custom_app_bar.dart';
import 'package:food_delivery/screens/home_screen/widgets/clipped_container.dart';
import 'package:food_delivery/screens/vendor_screen/widgets/product_item_card.dart';
import 'package:food_delivery/screens/vendor_screen/widgets/vendor_info_card.dart';

import '../../core/animations/fade_animation.dart';
import '../../core/animations/slide_animation.dart';
import '../../core/utils/navigation.dart';
import '../../core/utils/ui_helper.dart';
import '../../data.dart';
import '../home_screen/widgets/vendor_card.dart';
import '../product_screen/product_screen.dart';

class VendorScreen extends StatefulWidget {
  const VendorScreen({Key? key}) : super(key: key);

  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  late double _height;

  final _duration = const Duration(milliseconds: 750);
  final _psudoDuration = const Duration(milliseconds: 150);

  _navigate() async {
    await _animatedContainerFromBottomToTop();

    await Navigation.push(
      context,
      customPageTransition: PageTransition(
        child: ProductScreen(),
        type: PageTransitionType.fadeIn,
      ),
    );
    await _animatedContainerFromTopToBottom();
  }

  _navigateBack() async {
    await _animatedContainerFromBottomToTop();

    Navigation.pop(context);
  }

  _animatedContainerFromBottomToTop() async {
    _height = MediaQuery.of(context).padding.top + rh(50);
    setState(() {});

    await Future.delayed(_duration);
  }

  _animatedContainerFromTopToBottom() async {
    await Future.delayed(_psudoDuration);

    _height = MediaQuery.of(context).size.height;
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _height = 0;
    setState(() {});

    _animatedContainerFromTopToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AnimatedContainer(
        height: _height,
        duration: _duration,
        padding: EdgeInsets.only(bottom: rh(20)),
        curve: Curves.fastOutSlowIn,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: rh(380),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      height: rf(330),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          "assets/images/temp_vendor_bg.png",
                          width: 100 * SizeConfig.heightMultiplier,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      child: CustomAppBar(
                        onBackTap: _navigateBack,
                      ),
                    ),
                    const Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: ClippedContainer(
                        color: Colors.white,
                        child: VendorInfoCard(
                          title: "New York Donut",
                          rating: 4.2,
                          sideImagePath: "assets/images/temp_vendor_logo.png",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: rh(space5x)),
              FadeAnimation(
                intervalStart: 0.4,
                duration: const Duration(milliseconds:1250),
                child: SlideAnimation(
                  begin: const Offset(0, 100),
                  intervalStart: 0.4,
                  duration: const Duration(milliseconds:1250),
                  child: ListView.separated(
                    itemCount: productList.length,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        height: rh(space4x),
                        endIndent: rw(20),
                        indent: rw(20),
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: _navigate,
                        child: ProductItem(
                          imagePath: productList[index]["imagePath"],
                          title: productList[index]["title"],
                          detail: productList[index]["detail"],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
