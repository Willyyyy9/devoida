import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      required this.title,
      required this.onTap,
      this.height,
      this.color,
      this.borderRadius,
      this.fontSize,
      this.suffixIcon,
      this.suffixIconColor,
      this.buttonTextStyle});
  final String title;
  final Function onTap;
  final double? height;
  final Color? color;
  final double? borderRadius;
  final double? fontSize;
  final IconData? suffixIcon;
  final Color? suffixIconColor;
  final TextStyle? buttonTextStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: () {
          onTap();
        },
        style: ButtonStyle(
            elevation: WidgetStateProperty.all(0),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 16))),
            backgroundColor:
                WidgetStateProperty.all(color ?? ColorManager.lightPrimary)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                semanticsLabel: title,
                maxLines: 1,
                style: buttonTextStyle ??
                    TextStyle(
                        height: 1.2,
                        fontSize: fontSize ?? 20,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.white),
              ),
              if (suffixIcon != null)
                const SizedBox(
                  width: AppSize.s10,
                ),
              if (suffixIcon != null)
                Icon(
                  suffixIcon,
                  color: suffixIconColor ?? ColorManager.white,
                  size: AppSize.s18,
                )
            ],
          ),
        ),
      ),
    );
  }
}
