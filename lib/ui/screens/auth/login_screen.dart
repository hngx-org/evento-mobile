import 'package:evento/core/assets/assets.dart';
import 'package:evento/core/utils/functions.dart';
import 'package:evento/ui/common/colors.dart';
import 'package:evento/ui/common/text_fields.dart';
import 'package:evento/ui/common/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  static const String name = 'login-screen';
  static const String path = '/login-screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscuredPassword = true;
  bool _isRemeberMeChecked = false;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height / 3.5,
                decoration: ShapeDecoration(
                  color: AppColor.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32.r),
                      bottomRight: Radius.circular(32.r),
                    ),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Welcome to Evento',
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge
                          ?.copyWith(color: Colors.white),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      'Sign in to continue using Evento',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.sizeOf(context).height / 4.3,
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 50.h,
                          width: double.infinity,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFFEFEFE),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Color(0xFFC0C0C0)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                Assets.googleIcon,
                                height: 32.h,
                                width: 32.w,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Sign in with Google',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Container(
                                height: 1.h,
                                color: Colors.grey.shade300,
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              'OR',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: Colors.grey.shade600),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Expanded(
                              child: Container(
                                height: 1.h,
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              EventoTextField(
                                hint: 'Enter email',
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Required field';
                                  } else if (!isEmailValid(value)) {
                                    return 'Incorrect Email Address';
                                  }
                                  return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                'Password',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              EventoTextField(
                                hint: 'Password',
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Required field';
                                  }
                                  return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _isObscuredPassword =
                                          !_isObscuredPassword;
                                    });
                                  },
                                  child: Icon(_isObscuredPassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined),
                                ),
                                obscureText: _isObscuredPassword,
                                maxLines: 1,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: _isRemeberMeChecked,
                                        onChanged: (value) {
                                          setState(() {
                                            _isRemeberMeChecked =
                                                !_isRemeberMeChecked;
                                          });
                                        },
                                      ),
                                      Text('Remember me',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge),
                                    ],
                                  ),
                                  Text(
                                    'Forgot password?',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                            color: AppColor.primaryColor),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 50.h,
                              ),
                              ButtonWidget(
                                onPressed: () {},
                                child: Text(
                                  'Continue',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: 'Don\'t have an account? ',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                      children: [
                                        TextSpan(
                                            text: 'Sign up',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    color:
                                                        AppColor.primaryColor),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {}),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
