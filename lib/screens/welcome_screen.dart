import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ihe_mgbako_inverter/style/app_colors.dart';
import 'package:ihe_mgbako_inverter/widgets/big_text_widget.dart';
import 'package:ihe_mgbako_inverter/widgets/button_widget.dart';
import 'package:ihe_mgbako_inverter/widgets/small_text_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../consts/global_consts.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String modeRoute = '/modes';
  final PageController pageController = PageController(initialPage: 0);

  var currentPageValue = 0.0;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currentPageValue = pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 80.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: PageView.builder(
                  //onPageChanged: (value) {},
                  controller: pageController,
                  itemCount: imageList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BigText(text: titleList[index]),
                        SizedBox(height: 20.h),
                        Image.asset('assets/images/${imageList[index]}'),
                        SizedBox(height: 30.h),
                        SmallText(
                            overflow: TextOverflow.visible,
                            text: titleTextList[index]),
                      ],
                    );
                  }),
            ),
            SmoothPageIndicator(
                controller: pageController, // PageController
                count: imageList.length,
                effect: const WormEffect(
                  activeDotColor: mainTextColor,
                ), // your preferred effect
                onDotClicked: (index) {
                  pageController.jumpToPage(index);
                }),
            //SizedBox(height: 80.h),
            SizedBox(height: 50.h),
            currentPageValue == 2
                ? ButtonWidget(
                    onTap: () {
                      Navigator.pushNamed(context, modeRoute);
                    },
                    text: 'Get Started',
                    isResponsive: true,
                    width: 220.w,
                    height: 50.h,
                    borderRadius: 50.r,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          pageController.animateToPage(
                            currentPageValue.toInt(),
                            curve: Curves.easeIn,
                            duration: const Duration(milliseconds: 100),
                          );
                          pageController
                              .jumpToPage(currentPageValue.toInt() + 2);
                        },
                        child: const SmallText(
                          text: 'Skip',
                          textColor: mainTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      ButtonWidget(
                        text: 'Next>>',
                        onTap: () {
                          pageController.animateToPage(
                            currentPageValue.toInt(),
                            curve: Curves.easeIn,
                            duration: const Duration(milliseconds: 100),
                          );
                          pageController
                              .jumpToPage(currentPageValue.toInt() + 1);
                        },
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
