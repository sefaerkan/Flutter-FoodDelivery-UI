import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery/core/animations/animations.dart';
import 'package:food_delivery/core/widgets/app_bar/custom_app_bar.dart';
import 'package:food_delivery/data.dart';
import 'package:food_delivery/screens/home_screen/widgets/category_list_view.dart';
import 'package:food_delivery/screens/home_screen/widgets/clipped_container.dart';
import 'package:food_delivery/screens/home_screen/widgets/vendor_card.dart';

import '../../core/animations/slide_animation.dart';
import '../../core/utils/navigation.dart';
import '../../core/utils/ui_helper.dart';
import '../vendor_screen/vendor_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

   late double _height;

   final _duration = const Duration(milliseconds: 750);
   final _psudoDuration = const Duration(milliseconds: 150);

   _navigate() async {
    await _animatedContainerFromBottomToTop();

     await Navigation.push(
        context,
        customPageTransition: PageTransition(
          child: const VendorScreen(),
          type: PageTransitionType.fadeIn,
        ),
     );
     await _animatedContainerFromTopToBottom();
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

    Timer(const Duration(milliseconds: 50), () {
      _animatedContainerFromTopToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SlideAnimation(
        begin: const Offset(0, 400),
        duration: _duration,
        child: AnimatedContainer(
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
                const CustomAppBar(
                  hasBackButton: false,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: space2x),
                  child: RichText(
                    text: TextSpan(
                      text: "Hi, ",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: rf(24),
                        fontWeight: FontWeight.normal,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: "Jack",
                          style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: rf(24),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: space2x),
                  child: Text(
                    "DELIVER TO 779 CASSIE",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: rf(12),
                      height: 1.5,
                    ),
                  ),
                ),
                SizedBox(height: rh(space4x)),
                ClippedContainer(
                  color: Theme.of(context).colorScheme.secondary,
                  child: const CategoryListView(),
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
                      itemCount: vendorList.length,
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
                          child: VendorCard(
                            imagePath: vendorList[index]["imagePath"],
                            name: vendorList[index]["name"],
                            rating: vendorList[index]["rating"].toString(),
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
      ),
    );
  }
}
