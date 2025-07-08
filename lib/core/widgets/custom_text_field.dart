import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/vars.dart';

import '../app_color.dart';

class CustomTextFieldWidget extends StatelessWidget {
  const CustomTextFieldWidget(
      {super.key,
      this.width = 0.9,
      this.label,
      this.hint,
      this.number,
      this.maxLines,
      this.description = false,
      this.obscureText = false,
      this.requiredField = false,
      this.dropDown = false,
      this.enabled = true,
      this.disabledColor,
      this.controller,
      this.validator,
      this.fillColor,
      this.hintStyle,
      this.onChanged,
      this.borderColor,
      this.prefixIconConstraints,
      this.onFieldSubmitted,
      this.onTap,
      this.height,
      this.boldLabel = false,
      this.email = false,
      this.readOnly = false,
      this.suffixIcon,
      this.perfixIcon});
  final BoxConstraints? prefixIconConstraints;
  final String? label;
  final String? hint;
  final double width;
  final Color? borderColor;
  final Color? fillColor;
  final bool? number;
  final bool readOnly;
  final void Function()? onTap;
  final TextStyle? hintStyle;
  final bool obscureText;
  final bool? email;
  final bool? description;
  final bool enabled;
  final Color? disabledColor;
  final bool dropDown;
  final bool requiredField;
  final bool boldLabel;
  final int? maxLines;
  final Widget? suffixIcon;
  final Widget? perfixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final double? height;
  final void Function(String)? onFieldSubmitted;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Text(label ?? '',
                  style: Theme.of(context).textTheme.headlineLarge),
            ),
          8.ph,
          Center(
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              controller: controller,
              enabled: enabled,
              readOnly: readOnly,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.black),
              onTap: onTap,
              keyboardType: number != null
                  ? TextInputType.number
                  : email == true
                      ? TextInputType.emailAddress
                      : TextInputType.text,
              maxLines: description == true ? 6 : 1,
              onChanged: onChanged,
              onFieldSubmitted: onFieldSubmitted,
              decoration: InputDecoration(
                  //    contentPadding: EdgeInsets.zero,
                  //contentPadding: EdgeInsets.only(bottom: widget.height??0.075.sh / 3, left: 4.w,right: 4.w),
                  hintText: hint,
                  hintStyle: hintStyle ?? Theme.of(context).textTheme.bodyLarge,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                  fillColor: fillColor ?? AppColor.mainColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    borderSide:
                        BorderSide(color: borderColor ?? AppColor.boarderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    borderSide:
                        BorderSide(color: borderColor ?? AppColor.boarderColor),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    borderSide:
                        BorderSide(color: borderColor ?? AppColor.boarderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    borderSide:
                        BorderSide(color: borderColor ?? AppColor.boarderColor),
                  ),
                  // prefixIcon: widget.suffixIcon,
                  suffixIcon: dropDown
                      ? Icon(
                          Icons.keyboard_arrow_down,
                          color: Theme.of(context).primaryColorLight,
                        )
                      : suffixIcon,
                  prefixIconConstraints: prefixIconConstraints,
                  prefixIcon: perfixIcon),
              obscureText: obscureText,
              validator: validator,
            ),
          ),
        ],
      ),
    );
  }
}
