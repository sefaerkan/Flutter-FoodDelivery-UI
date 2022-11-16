import 'package:flutter/material.dart';
import 'package:food_delivery/core/animations/animations.dart';
import 'package:food_delivery/core/utils/size_config.dart';
import 'package:food_delivery/core/widgets/app_bar/custom_app_bar.dart';
import 'package:food_delivery/screens/product_screen/widgets/product_info_text.dart';

import '../../core/utils/navigation.dart';
import '../../core/utils/ui_helper.dart';
import '../../core/widgets/button/buttons.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late double _height;

  final _duration = const Duration(milliseconds: 750);
  final _psudoDuration = const Duration(milliseconds: 150);

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
            children: [
              CustomAppBar(
                onBackTap: _navigateBack,
              ),
              SizedBox(
                height: 50 * SizeConfig.heightMultiplier,
                child: Stack(
                  children: [
                    Positioned.fill(
                      top: 0,
                      bottom: 0,
                      left: -140,
                      child: ScaleAnimation(
                        begin: 0,
                        duration: const Duration(milliseconds: 1000),
                        intervalStart: 0.2,
                        curve: Curves.easeOutBack,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Image.asset(
                            "assets/images/donut/donut_4.png",
                            width: rw(300),
                          ),
                        ),
                      ),
                    ),
                    //Info
                    Positioned.fill(
                      top: rh(40),
                      bottom: 0,
                      right: rw(space4x),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: FadeAnimation(
                          duration: const Duration(milliseconds: 1250),
                          child: ScaleAnimation(
                            intervalStart: 0.4,
                            duration: const Duration(milliseconds: 1250),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ProductInfoText(
                                  text: "Weight",
                                  value: "400",
                                ),
                                ProductInfoText(
                                  text: "Calories",
                                  value: "567 Cal",
                                ),
                                ProductInfoText(
                                  text: "People",
                                  value: "1 Person",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: space2x),
                child: FadeAnimation(
                  intervalStart: 0.4,
                  duration: const Duration(milliseconds: 1300),
                  child: SlideAnimation(
                    intervalStart: 0.4,
                    begin: const Offset(0,80),
                    duration: const Duration(milliseconds: 1300),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Raspberry Donut",
                          style: Theme.of(context).textTheme.headline4!,
                        ),
                        SizedBox(height: rh(space1x)),
                        Text(
                          "\$12.95",
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: rf(18),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height:rh(space2x)),
                        Text(
                          "Donut is a sweet donut that is consumed widely, especially in the USA. The donut, which is very rich in sugar and fat, is high in calories.",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: space2x,
                  vertical: space5x,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Buttons.icon(
                        context: context,
                        icon: Icons.favorite_border,
                        size: 28,
                        iconColor: Theme.of(context).primaryColorDark,
                        top: space2x,
                        bottom: space2x,
                        left: space2x,
                        right: space2x,
                        semanticLabel: "Favorite",
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: rw(space2x)),
                    Expanded(
                      child: Buttons.flexible(
                        vPadding: 20,
                        borderRadius: 20,
                        context: context,
                        text: "Add to Cart",
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
