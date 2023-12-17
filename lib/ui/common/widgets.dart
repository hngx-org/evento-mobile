import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/assets/assets.dart';

Future<bool?> showEventoConfirmationDialog(
    {required BuildContext context,
    required String content,
    void Function()? onConfirm,
    void Function()? onCancel,
    String positiveText = 'Okay',
    String negativeText = 'Cancel'}) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                content,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 24.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 120.0,
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        context.pop(false);
                        onCancel?.call();
                      },
                      style: Theme.of(context)
                          .elevatedButtonTheme
                          .style
                          ?.copyWith(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xFFF2EBF3))),
                      child: Text(
                        negativeText,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 120.0,
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        context.pop(true);
                        onConfirm?.call();
                      },
                      child: Text(positiveText),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}

class OnboardingWidget extends StatelessWidget {
  final String svgImage;
  final String headerText;
  final String bodyText;

  const OnboardingWidget({
    super.key,
    required this.svgImage,
    required this.headerText,
    required this.bodyText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 70),
      color: Colors.white,
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: MediaQuery.sizeOf(context).height / 4,
            child: SvgPicture.asset(
              svgImage,
            ),
          ),
          SizedBox(
            height: 100.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  headerText,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  bodyText,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ButtonWidget extends StatefulWidget {
  final dynamic Function()? onPressed;
  final Widget child;
  final Color? backgroundColor;
  const ButtonWidget({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
  });

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) => widget.backgroundColor,
        ),
      ),
      child: widget.child,
    );
  }
}

Future<bool?> showEventoErrorDialog(BuildContext context, String content,
    {void Function()? onClick}) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(Assets.errorImage),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                content,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 24.0,
              ),
              ElevatedButton(
                onPressed: () {
                  context.pop();
                  onClick?.call();
                },
                child: const Text('Ok'),
              )
            ],
          ),
        ),
      );
    },
  );
}

Future<bool?> showEventoSuccessDialog(BuildContext context, String content,
    {void Function()? onClick}) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(Assets.successImage),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                content,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 24.0,
              ),
              ElevatedButton(
                onPressed: () {
                  context.pop();
                  onClick?.call();
                },
                child: const Text('Ok'),
              )
            ],
          ),
        ),
      );
    },
  );
}
