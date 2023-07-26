import 'package:coffee_base_app/constants.dart';
import 'package:flutter/material.dart';

///
/// Input
///

class Input extends StatelessWidget {
  final EdgeInsets margin;
  final EdgeInsets padding;

  final TextEditingController? controller;

  final String? placeholder;

  final String? error;

  final bool disabled;

  final bool obscureText;

  final Function(String?)? onChange;

  const Input({
    super.key,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
    this.disabled = false,
    this.obscureText = false,
    this.controller,
    this.placeholder,
    this.error,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextField(
        onChanged: (value) => onChange?.call(value),
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: const TextStyle(color: AppColors.greyC1),
          contentPadding: padding,
          border: _inputBorder(),
          errorText: error,
        ),
      ),
    );
  }

  _inputBorder() {
    return MaterialStateOutlineInputBorder.resolveWith((states) {
      late final Color outlineColor;
      if (error != null) {
        outlineColor = AppColors.redC2;
      } else if (disabled) {
        outlineColor = AppColors.greyC1;
      } else if (states.contains(MaterialState.focused)) {
        outlineColor = AppColors.orangeDark;
      } else {
        outlineColor = AppColors.blueDark;
      }
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          width: 2,
          color: outlineColor,
        ),
      );
    });
  }
}
