import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

///
/// CloudBanner
///

class CloudBanner extends StatelessWidget {
  final String title;
  final String subtitle;

  const CloudBanner({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Center(child: SvgPicture.asset("assets/images/ic_cloud.svg")),
          Positioned.fill(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(title, textAlign: TextAlign.center, style: _titleStyle()),
                  Text(subtitle, textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _titleStyle() {
    return const TextStyle(fontSize: 28, fontWeight: FontWeight.bold);
  }
}
