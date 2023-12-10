import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/assets/assets.dart';
import '../../common/widgets.dart';
import '../../theme/theme.dart';

class OnboardingScreen extends StatefulWidget {
  static const String name = 'onboarding-screen';
  static const String path = '/onboarding-screen';
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController(initialPage: 0);
  double _progress = 1 / 3;
  bool _isLastPage = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          PageView(
            onPageChanged: (value) {
              if (value == 0) {
                setState(() {
                  _isLastPage = false;
                  _progress = 1 / 3;
                });
              } else if (value == 1) {
                setState(() {
                  _isLastPage = false;
                  _progress = 2 / 3;
                });
              } else if (value == 2) {
                setState(() {
                  _isLastPage = true;
                  _progress = 3 / 3;
                });
              }
            },
            controller: _controller,
            children: [
              OnboardingWidget(
                svgImage: Assets.onboarding1Image,
                headerText: 'Welcome to Farm Alert',
                bodyText:
                    'Keep track of your livestock with ease. Farm Alert allows you to maintain a comprehensive inventory of your animals',
              ),
              OnboardingWidget(
                svgImage: Assets.onboarding2Image,
                headerText: 'Seamless Sales Management',
                bodyText:
                    'Take control of your animal sales process. With Farm Alert, you can effortlessly list animals for sale, track transactions, and manage sales history.',
              ),
              OnboardingWidget(
                svgImage: Assets.onboarding3Image,
                headerText: 'Monitoring, Anytime, Anywhere',
                bodyText:
                    'Stay connected to your farm 24/7. Farm Alert provides real-time monitoring of both your animals and farm conditions',
              ),
            ],
          ),
          Positioned(
            right: 20.w,
            top: 70.h,
            child: AnimatedOpacity(
              opacity: _isLastPage ? 0 : 1,
              duration: const Duration(milliseconds: 400),
              child: InkWell(
                onTap: () {
                  _controller.animateToPage(
                    2,
                    curve: Curves.easeInOut,
                    duration: const Duration(milliseconds: 500),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      'Skip',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    SvgPicture.asset(Assets.arrowRightIcon)
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 50.h,
            child: InkWell(
              onTap: () async {
                await _controller.nextPage(
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 500),
                );
              },
              child: Column(
                children: [
                  Row(
                    children: [
                      SmoothPageIndicator(
                        controller: _controller, // PageController
                        count: 3,
                        effect: ExpandingDotsEffect(
                          activeDotColor: Colors.white,
                          dotHeight: 10.h,
                          dotWidth: 10.w,
                        ), // your preferred effect
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 1.w,
                        ),
                      ),
                      Stack(
                        alignment: const Alignment(0, 0),
                        children: [
                          SizedBox(
                            height: 60.h,
                            width: 60.w,
                            child: CircularProgressIndicator.adaptive(
                              value: _progress,
                              backgroundColor: Colors.white,
                              strokeWidth: 1.w,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (_controller.page != 2) {
                                _controller.animateToPage(
                                  _controller.page == 0 ? 1 : 2,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              } else {}
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 40.w,
                              height: 40.h,
                              decoration: const ShapeDecoration(
                                color: Colors.white,
                                shape: OvalBorder(),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x1E2F2B43),
                                    blurRadius: 14,
                                    offset: Offset(0, 3),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14.sp,
                                weight: 1.w,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  ButtonWidget(
                    onPressed: () {},
                    child: Text('Get Started',
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'or',
                    style: GoogleFonts.poppins(
                      color: LightTheme.primaryColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  ButtonWidget(
                    onPressed: () {},
                    child: Text(
                      'Continue as An Agent',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
