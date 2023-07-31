import 'package:coffee_base_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

///
/// Separator
///

class Separator extends StatelessWidget {
  const Separator({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: SvgPicture.asset(
            "assets/images/ic_cloud.svg",
            width: 32,
            height: 32,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Expanded(
                child: Divider(
                  thickness: 1,
                  color: AppColors.greyC1,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text("ou"),
              ),
              Expanded(
                child: Divider(
                  thickness: 1,
                  color: AppColors.greyC1,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
