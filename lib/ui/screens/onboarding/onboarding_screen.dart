import 'package:evento/ui/common/colors.dart';
import 'package:evento/ui/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/assets/assets.dart';
import '../../common/widgets.dart';

class OnboardingScreen extends StatefulWidget {
  static const String name = 'onboarding-screen';
  static const String path = '/onboarding-screen';
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController(initialPage: 0);

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
                });
              } else if (value == 1) {
                setState(() {
                  _isLastPage = false;
                });
              } else if (value == 2) {
                setState(() {
                  _isLastPage = true;
                });
              }
            },
            controller: _controller,
            children: const [
              OnboardingWidget(
                svgImage: Assets.onboarding1Image,
                headerText: 'Welcome to Evento',
                bodyText:
                    'Your passport to seamless event experiences. Let\'s embark on a journey of connection, engagement, and unforgettable moments.',
              ),
              OnboardingWidget(
                svgImage: Assets.onboarding2Image,
                headerText: 'Get ready to elevate your events!',
                bodyText:
                    'Your passport to seamless event experiences. Let\'s embark on a journey of connection, engagement, and unforgettable moments.',
              ),
              OnboardingWidget(
                svgImage: Assets.onboarding3Image,
                headerText: 'Expand your reach with Evento!',
                bodyText:
                    'With Evento, we\'re not just an app; we\'re your partner in creating extraordinary experiences. Let\'s dive into a world where your events take center stage',
              ),
            ],
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 270.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SmoothPageIndicator(
                  controller: _controller, // PageController
                  count: 3,
                  onDotClicked: (index) async {
                    await _controller.animateToPage(
                      index,
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 500),
                    );
                  },
                  effect: ExpandingDotsEffect(
                    activeDotColor: AppColor.primaryColor,
                    dotColor: AppColor.primaryColor.withOpacity(.5),
                    dotHeight: 10.h,
                    dotWidth: 10.w,
                  ), // your preferred effect
                ),
              ],
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 40.h,
            child: Column(
              children: [
                ButtonWidget(
                  onPressed: () async {
                    if (!_isLastPage) {
                      await _controller.nextPage(
                        curve: Curves.easeInOut,
                        duration: const Duration(milliseconds: 500),
                      );
                    } else {
                      context.push(LoginScreen.path);
                    }
                  },
                  child: Text('Next',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white)),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextButton(
                  onPressed: () {
                    context.push(LoginScreen.path);
                  },
                  child: Text(
                    'Skip',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: AppColor.primaryColor),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
