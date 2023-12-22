import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventoTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String? hint;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? prefixText;
  final bool? readOnly;
  final Widget? suffixIcon;
  final Widget? suffix;
  final Widget? prefixIcon;
  final void Function()? onTap;
  final int? maxLines;
  final AutovalidateMode? autovalidateMode;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
  final String? helperText;
  final Color? color;
  final void Function()? onClickSuffixIcon;
  final bool obscureText;

  const EventoTextField({
    this.textEditingController,
    this.hint,
    this.onChanged,
    this.validator,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.prefixText,
    this.readOnly,
    this.suffixIcon,
    this.suffix,
    this.prefixIcon,
    this.onTap,
    this.maxLines,
    this.autovalidateMode,
    this.enabled,
    this.inputFormatters,
    this.errorText,
    this.helperText,
    this.onClickSuffixIcon,
    this.color,
    super.key,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) =>
          SystemChannels.textInput.invokeMethod('TextInput.hide'),
      controller: textEditingController,
      onChanged: onChanged,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction ?? TextInputAction.next,
      autovalidateMode: autovalidateMode,
      enabled: enabled,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: color ?? Colors.white,
        prefixText: prefixText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 1.w),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
            borderSide: BorderSide(
              width: 1.w,
              color: const Color(0xFFB1B1B1),
            )),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
            borderSide: BorderSide(width: 1.w)),
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 46.0),
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Colors.grey),
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: suffixIcon!,
                onPressed: onClickSuffixIcon,
              )
            : null,
        suffix: suffix,
        // prefixIcon: prefixIcon,
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: const EdgeInsets.fromLTRB(
                    8, 0, 8, 0), // Adjust the left padding
                child: prefixIcon,
              )
            : null,
        prefixIconConstraints: BoxConstraints(
          minWidth: 24.w,
          minHeight: 24.h,
        ),
        errorText: errorText,
        helperText: helperText,
      ),
      obscureText: obscureText,
      inputFormatters: inputFormatters == null
          ? [LengthLimitingTextInputFormatter(maxLength)]
          : [LengthLimitingTextInputFormatter(maxLength), ...inputFormatters!],
      style: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(color: const Color(0xFF002F49)),
      readOnly: readOnly ?? false,
      onTap: onTap,
      maxLines: maxLines,
    );
  }
}
