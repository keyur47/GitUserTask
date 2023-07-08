import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task/utils/app_colors.dart';
import 'package:task/utils/app_colors.dart';
import 'package:task/utils/size_utils.dart';

class CustomTextField extends StatelessWidget {
  final bool readOnly;
  final bool? showCursor;
  final FontWeight? fontWeight;
  final TextEditingController? controller;
  final int maxLine;
  final Function(String)? onChanged;
  final TextInputType keyboardType;
  final Color? textColor;
  final double? fontSize;
  final int? maxLength;
  final double? radius;
  final bool enabled;
  final bool isPassword;
  final FocusNode? focusNode;
  final String? hintText;
  final String? labelText;
  final Color? hintTextColor;
  final Color? labelTextColor;
  final double? hintFontSize;
  final double? labelFontSize;
  final FontWeight? hintTextWeight;
  final FontWeight? labelTextWeight;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final VoidCallback? onTap;
  final Color? enableColor;
  final Color? disabledColor;
  final Color? focusedColor;
  final Color? cursorColor;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixWidget;
  final TextCapitalization? textCapitalization;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? textInputFormatter;
  final TextInputAction? textInputAction;
  final bool? copy;
  final double? textFieldHeight;
  final List<BoxShadow>? boxShadow;
  final ScrollController? scrollController;
  final BorderSide? borderSide;

  CustomTextField({
    Key? key,
    this.textInputFormatter,
    this.boxShadow,
    this.borderSide,
    this.onFieldSubmitted,
    this.fontWeight,
    this.showCursor,
    this.onChanged,
    this.maxLine = 1,
    this.maxLength,
    this.radius,
    this.fontSize,
    this.fillColor,
    this.textColor,
    this.disabledColor,
    this.onSubmitted,
    this.isPassword = false,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.hintText,
    this.hintTextColor,
    this.hintFontSize,
    this.hintTextWeight,
    this.textAlign,
    this.textAlignVertical,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.enableColor,
    this.focusedColor,
    this.cursorColor,
    this.controller,
    this.contentPadding,
    this.prefixWidget,
    this.copy = false,
    this.readOnly = false,
    this.textCapitalization,
    this.textInputAction,
    this.validator,
    this.textFieldHeight,
    this.scrollController,
    this.labelText,
    this.labelFontSize,
    this.labelTextColor,
    this.labelTextWeight,
  }) : super(key: key);

  final ValueNotifier<bool> _isObscure = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _isObscure,
      builder: (context, bool isObscure, _) {
        if (!isPassword) {
          isObscure = false;
        }
        return Stack(
          children: [
            TextField(
              scrollController: scrollController,
              showCursor: showCursor ?? true,
              textCapitalization: textCapitalization ?? TextCapitalization.none,
              readOnly: readOnly,
              style: TextStyle(
                color: textColor ?? AppColors.blackColor,
                fontSize: fontSize ?? SizeUtils.fSize_16(),
                fontWeight: fontWeight ?? FontWeight.w400,
              ),
              onTap: onTap,
              obscureText: isObscure,
              inputFormatters: textInputFormatter,
              textInputAction: textInputAction,
              obscuringCharacter: '*',
              onChanged: onChanged,
              controller: controller,
              maxLines: maxLine,
              maxLength: maxLength,
              keyboardType: keyboardType,
              focusNode: focusNode,
              textAlignVertical: textAlignVertical,
              cursorColor: cursorColor ?? AppColors.blackColor,
              textAlign: textAlign ?? TextAlign.start,
              enabled: enabled,
              onSubmitted: onSubmitted,
              decoration: InputDecoration(
                contentPadding: contentPadding ?? const EdgeInsets.symmetric(vertical: 21.0, horizontal: 25),
                errorMaxLines: 1,
                prefix: prefixWidget,
                isDense: true,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon == null && isPassword
                    ? IconButton(
                        icon: Icon(
                          isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          _isObscure.value = !isObscure;
                        },
                      )
                    : suffixIcon,
                counterText: "",
                hintText: hintText,
                labelText: labelText,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelStyle: TextStyle(
                  color: labelTextColor ?? AppColors.blackColor,
                  fontSize: labelFontSize ?? SizeUtils.fSize_16(),
                  fontWeight: labelTextWeight ?? FontWeight.w400,
                ),
                hintStyle: TextStyle(
                  color: hintTextColor ?? AppColors.blackColor.withOpacity(0.5),
                  fontSize: hintFontSize ?? SizeUtils.fSize_16(),
                  fontWeight: hintTextWeight ?? FontWeight.w400,
                ),
                filled: true,
                fillColor: fillColor ?? AppColors.whiteColor,
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(radius ?? 20)),
                  // borderSide: BorderSide.none,
                  borderSide: borderSide ?? BorderSide(color: enableColor ?? Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(radius ?? 20)),
                  // borderSide: BorderSide.none,
                  borderSide: borderSide ??
                      BorderSide(
                        color: enableColor ?? AppColors.blackColor,
                      ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(radius ?? 20)),
                  borderSide: borderSide ??
                      BorderSide(
                        color: enableColor ?? AppColors.blackColor,
                      ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(radius ?? 20)),
                  borderSide: borderSide ??
                      BorderSide(
                        color: enableColor ?? AppColors.blackColor,
                      ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
