import 'package:evento/core/assets/assets.dart';
import 'package:evento/core/utils/functions.dart';
import 'package:evento/ui/common/colors.dart';
import 'package:evento/ui/common/text_fields.dart';
import 'package:evento/ui/common/widgets.dart';
import 'package:evento/ui/screens/auth/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../blocs/auth_bloc/auth_bloc.dart';

class SignUpScreen extends StatefulWidget {
  static const String name = 'sign-up-screen';
  static const String path = '/sign-up-screen';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isObscuredPassword = true;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final authBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocListener<AuthBloc, AuthState>(
          bloc: authBloc,
          listener: (context, state) async {
            if (state is RegisterFailed) {
              showEventoErrorDialog(context, state.error);
            } else if (state is RegisterSuccess) {
              await showEventoSuccessDialog(context, state.message);
              if (context.mounted) {
                context.pushReplacement(LoginScreen.path);
              }
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
              bloc: authBloc,
              builder: (context, state) {
                return SizedBox(
                  height: mediaQuery.height + 50,
                  width: mediaQuery.width,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          width: mediaQuery.width,
                          height: mediaQuery.height / 3.5,
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
                                style: textTheme.displayLarge
                                    ?.copyWith(color: Colors.white),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(
                                'Sign up to continue using Evento',
                                style: textTheme.bodyLarge
                                    ?.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: mediaQuery.height / 4.3,
                        child: SizedBox(
                          width: mediaQuery.width,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          Assets.googleIcon,
                                          height: 32.h,
                                          width: 32.w,
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          'Sign up with Google',
                                          style: textTheme.bodyLarge,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                                            ?.copyWith(
                                                color: Colors.grey.shade600),
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
                                    height: 15.h,
                                  ),
                                  Text(
                                    'First name',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  EventoTextField(
                                    hint: 'Enter first name',
                                    textEditingController: _firstNameController,
                                    enabled: state is! RegisterLoading,
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Required field';
                                      }
                                      return null;
                                    },
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Text(
                                    'Last name',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  EventoTextField(
                                    hint: 'Enter your surnname',
                                    keyboardType: TextInputType.name,
                                    enabled: state is! RegisterLoading,
                                    textEditingController: _lastNameController,
                                    textInputAction: TextInputAction.next,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Required field';
                                      }
                                      return null;
                                    },
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
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
                                    enabled: state is! RegisterLoading,
                                    textEditingController: _emailController,
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
                                    height: 15.h,
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
                                    enabled: state is! RegisterLoading,
                                    textEditingController: _passwordController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Required field';
                                      } else if (value.length < 6) {
                                        return 'Password must be longer than 6 characters';
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
                                    height: 35.h,
                                  ),
                                  ButtonWidget(
                                    onPressed: state is RegisterLoading
                                        ? null
                                        : _register,
                                    child: state is RegisterLoading
                                        ? SizedBox(
                                            height: 24.h,
                                            width: 24.w,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2.w,
                                            ),
                                          )
                                        : Text(
                                            'Continue',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(color: Colors.white),
                                          ),
                                  ),
                                  SizedBox(
                                    height: 25.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          text: 'Already have an account? ',
                                          style: textTheme.bodyLarge,
                                          children: [
                                            TextSpan(
                                                text: 'Login',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                        color: AppColor
                                                            .primaryColor),
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () => context
                                                          .pushReplacement(
                                                              LoginScreen
                                                                  .path)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      authBloc.add(RegisterUserEvent(
          _emailController.text,
          _passwordController.text,
          _firstNameController.text,
          _lastNameController.text));
    }
  }
}
