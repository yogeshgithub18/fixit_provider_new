import 'package:fixit/common/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool? obscureText;
  final String hintText;
  final Color? fillColor;
  final Color? txtColor;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? textInputFormatter;
  final TextInputType? textInputType;
  final String? errorText;
  final int? maxLine;
  final bool? underLine;
  final int? maxLength;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? suffixIcon;
  final double? borderRadius;
  final Color? borderColor;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Widget? prefixIcon;
  final bool? readOnly;
  final double? hintTxtSize;
  final String? Function(String?)? validator;
  final Color? hintTextColor;

  CustomTextField({Key? key, required this.controller, this.obscureText, required this.hintText, this.textInputAction, this.textInputType, this.textInputFormatter, this.suffixIcon, this.prefixIcon, this.errorText, this.borderRadius, this.fillColor, this.txtColor, this.borderColor, this.maxLine, this.contentPadding, this.hintTxtSize, this.onTap, this.readOnly, this.hintTextColor, this.validator, this.maxLength, this.underLine = false, this.onChanged, required String hintText2}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText ?? false,
      obscuringCharacter: "*",
      maxLines: maxLine,
      onTap: onTap,
      readOnly: readOnly ?? false,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      inputFormatters: textInputFormatter,
      validator: validator,
      onChanged: onChanged,
      maxLength: maxLength??200,
      style: TextStyle(color: txtColor ?? Colors.black,fontSize: 16),
      decoration: InputDecoration(
        contentPadding: contentPadding ?? EdgeInsets.only(top: 16.sp, bottom: 16.sp, left: 10.0, right: 10.0),
        isDense: true,
        hintMaxLines: 2,
        hintText: hintText,
        errorText: errorText,
        counter: SizedBox.shrink(),
        counterStyle: TextStyle(fontSize: 0,color: Colors.transparent),
        counterText: "",
        semanticCounterText: "",
        suffixIconConstraints: const BoxConstraints(maxHeight: 45),
        prefixIconConstraints: const BoxConstraints(maxHeight: 45),
        hintStyle: TextStyle(color: hintTextColor ?? Colors.black,fontSize: hintTxtSize ?? 16),
        filled: true,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        fillColor: fillColor ?? Colors.transparent,
        border: const OutlineInputBorder(borderSide: BorderSide(color: ColorConstants.primaryColor)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor ??  ColorConstants.primaryColor, width: 1.0),
          borderRadius: BorderRadius.circular(borderRadius??8.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor ??  ColorConstants.primaryColor, width: 1.0),
          borderRadius: BorderRadius.circular(borderRadius??8.0),
        ),
        enabledBorder: OutlineInputBorder(
          // borderSide: BorderSide.none,
          borderSide: BorderSide(color: borderColor ??   ColorConstants.primaryColor, width: 1.0),
          borderRadius: BorderRadius.circular(borderRadius??8.0),
        ),
        errorBorder: OutlineInputBorder(
          // borderSide: BorderSide.none,
          borderSide: BorderSide(color: Colors.red, width: 1.0),
          borderRadius: BorderRadius.circular(borderRadius??8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor ??  ColorConstants.primaryColor, width: 1.0),
          // borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(borderRadius??8.0),
        ),
      ),
    );
  }
}
