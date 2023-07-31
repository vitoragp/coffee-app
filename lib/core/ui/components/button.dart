import 'package:coffee_base_app/constants.dart';
import 'package:flutter/material.dart';

///
/// Button
///

class Button extends StatelessWidget {
  final void Function()? onPressed;
  final EdgeInsets margin;
  final String label;
  final bool disabled;

  const Button({
    super.key,
    this.onPressed,
    this.margin = const EdgeInsets.all(8),
    this.label = "",
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: ElevatedButton(
        onPressed: () {
          if (!disabled) {
            onPressed?.call();
          }
        },
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          backgroundColor: MaterialStateColor.resolveWith((states) => _resolveMaterialColor(context, states)),
          overlayColor: MaterialStateColor.resolveWith((states) => _resolveMaterialColor(context, states)),
          elevation: MaterialStateProperty.resolveWith((states) => _resolveMaterialElevation(context, states)),
          padding: MaterialStateProperty.resolveWith((states) => const EdgeInsets.symmetric(vertical: 16)),
        ),
        child: Text(label, style: const TextStyle(color: AppColors.black)),
      ),
    );
  }

  Color _resolveMaterialColor(BuildContext context, Set<MaterialState> states) {
    if (disabled) {
      return AppColors.greyC1;
    }
    if (states.contains(MaterialState.pressed)) {
      return AppColors.blueDark;
    }
    return AppColors.blueLight;
  }

  _resolveMaterialElevation(BuildContext context, Set<MaterialState> states) {
    return 8.0;
  }
}
