import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_color.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double? height;
  final double? width;
  final VoidCallback? onTap;
  final Color? fillColor;
  final bool isActive;
  final bool isLoading;
  final bool disableShadow;
  final BoxBorder? border;
  final TextStyle? textStyle;
  const CustomButton(
      {super.key,
      required this.title,
      this.width,
      this.isActive = true,
      this.isLoading = false,
      this.disableShadow = false,
      this.height,
      this.border,
      this.textStyle,
      this.onTap,
      this.fillColor});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CupertinoActivityIndicator(
              color: AppColor.mainColor,
            ),
          )
        : InkWell(
            onTap: onTap?.call,
            child: Container(
              height: height ?? 0.06.sh,
              width: width ?? MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: fillColor ?? Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                  border: border),
              child: Center(
                child: Text(
                  title,
                  style: textStyle,
                ),
              ),
            ),
          );
  }
}
