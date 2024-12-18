import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

final class ResponsiveSvg extends StatelessWidget {
  final String assetName;

  const ResponsiveSvg({super.key, required this.assetName});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double imageWidth = screenWidth * 0.8;
    final double imageHeight = screenHeight * 0.35;

    return Center(
      child: SvgPicture.asset(
        assetName,
        width: imageWidth,
        height: imageHeight,
      ),
    );
  }
}
