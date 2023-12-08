import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
