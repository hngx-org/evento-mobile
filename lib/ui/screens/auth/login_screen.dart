import 'package:evento/core/assets/assets.dart';
import 'package:evento/core/utils/functions.dart';
import 'package:evento/ui/common/colors.dart';
import 'package:evento/ui/common/text_fields.dart';
import 'package:evento/ui/common/widgets.dart';
import 'package:evento/ui/screens/auth/sign_up_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../blocs/auth_bloc/auth_bloc.dart';

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
  final authBloc = AuthBloc();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SizedBox(
          height: mediaQuery.height,
          width: mediaQuery.width,
          child: BlocListener<AuthBloc, AuthState>(
            bloc: authBloc,
            listener: (context, state) {
              if (state is LoginFailed) {
                showEventoErrorDialog(context, state.error);
              } else if (state is LoginSuccess) {
                showEventoSuccessDialog(context, state.message);
              }
            },
            child: BlocBuilder<AuthBloc, AuthState>(
                bloc: authBloc,
                builder: (context, state) {
                  return Stack(
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
                                'Sign in to continue using Evento',
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
                                          'Sign in with Google',
                                          style: textTheme.bodyLarge,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.h,
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
                                    height: 25.h,
                                  ),
                                  SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Email',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        EventoTextField(
                                          hint: 'Enter email',
                                          textEditingController:
                                              _emailController,
                                          enabled: state is! LoginLoading,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          textInputAction: TextInputAction.next,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Required field';
                                            } else if (!isEmailValid(value)) {
                                              return 'Incorrect Email Address';
                                            }
                                            return null;
                                          },
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Text(
                                          'Password',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        EventoTextField(
                                          hint: 'Password',
                                          textEditingController:
                                              _passwordController,
                                          enabled: state is! LoginLoading,
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          textInputAction: TextInputAction.done,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Required field';
                                            } else if (value.length < 6) {
                                              return 'Password must be longer than 6 characters';
                                            }
                                            return null;
                                          },
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
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
                                                      color: AppColor
                                                          .primaryColor),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 50.h,
                                        ),
                                        ButtonWidget(
                                          onPressed: state is LoginLoading
                                              ? null
                                              : _login,
                                          child: state is LoginLoading
                                              ? SizedBox(
                                                  height: 24.h,
                                                  width: 24.w,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.white,
                                                    strokeWidth: 2.w,
                                                  ),
                                                )
                                              : Text(
                                                  'Continue',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(
                                                          color: Colors.white),
                                                ),
                                        ),
                                        SizedBox(
                                          height: 30.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(
                                                text:
                                                    'Don\'t have an account? ',
                                                style: textTheme.bodyLarge,
                                                children: [
                                                  TextSpan(
                                                      text: 'Sign up',
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
                                                                    SignUpScreen
                                                                        .path)),
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
                  );
                }),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      authBloc
          .add(LoginUserEvent(_emailController.text, _passwordController.text));
    }
  }
}
