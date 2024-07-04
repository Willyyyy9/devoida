import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/font_manager.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:devoida/app/resources/style_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppMultiLineTextFormField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final Function(String)? onSubmited;
  final String? Function(String?)? validator;
  final double? height;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final double fontSize;
  final void Function()? onSuffixPressed;

  const AppMultiLineTextFormField(
      {super.key,
      required this.hint,
      required this.controller,
      this.validator,
      this.onSubmited,
      this.suffixIcon,
      this.prefixIcon,
      this.fontSize = FontSize.s12,
      this.inputFormatters,
      this.obscureText = false,
      this.onSuffixPressed,
      this.height});
  @override
  State<AppMultiLineTextFormField> createState() =>
      _AppMultiLineTextFormFieldState();
}

class _AppMultiLineTextFormFieldState extends State<AppMultiLineTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 250,
      // height: widget.height ?? 50,

      decoration: BoxDecoration(
        color: ColorManager.transparent,
      ),

      child: TextFormField(
        keyboardType: TextInputType.multiline,
        controller: widget.controller,
        onFieldSubmitted: widget.onSubmited,
        minLines: 5,
        maxLines: null,
        validator: widget.validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.pleaseEnterValue + widget.hint;
              } else {
                return null;
              }
            },
        inputFormatters: widget.inputFormatters,
        obscureText: widget.obscureText,
        textCapitalization: TextCapitalization.sentences,
        // expands: true,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: AppPadding.p16),
            prefixIconColor: WidgetStateColor.resolveWith((states) =>
                states.contains(WidgetState.focused)
                    ? Colors.blue
                    : Colors.black),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(AppSize.s10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1,
                color: Colors.blue,
              ),
              borderRadius: BorderRadius.circular(AppSize.s10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1,
                color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(AppSize.s10),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1,
                color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(AppSize.s10),
            ),
            semanticCounterText: widget.hint,
            prefixIcon: widget.prefixIcon != null
                ? Align(
                    alignment: Alignment.topLeft,
                    widthFactor: 1.0,
                    heightFactor: 5.5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: AppPadding.p16),
                      child: Icon(
                        widget.prefixIcon,
                        size: AppSize.s16,
                        // color: ColorManager.primary,
                      ),
                    ),
                  )
                : null,
            labelText: widget.hint,
            hintStyle: getRegularStyle(
              color: ColorManager.darkPrimary,
              fontSize: widget.fontSize,
            ),
            alignLabelWithHint: true,
            labelStyle: getRegularStyle(
                color: ColorManager.black, fontSize: widget.fontSize),
            suffixIconConstraints: const BoxConstraints(maxHeight: AppSize.s16),
            suffixIcon: widget.suffixIcon != null
                ? IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: widget.onSuffixPressed ?? () {},
                    icon: Icon(
                      widget.suffixIcon,
                      size: AppSize.s16,
                      color: ColorManager.grey,
                    ),
                  )
                : null),
      ),
    );
  }
}
