import 'package:flutter/material.dart';

class ResponsiveSize {
  final MediaQueryData mediaQueryData;

  const ResponsiveSize({required this.mediaQueryData});

  static ResponsiveSize of(BuildContext context) =>
      ResponsiveSize(mediaQueryData: MediaQuery.of(context));

  double scaleSize(double size) {
    double longestSide = mediaQueryData.size.longestSide;

    const tabletL = 1300;
    const tabletM = 1000;
    const phoneL = 900;
    const phoneM = 700;

    if (longestSide >= tabletL) {
      return size * 1.4;
    } else if (longestSide >= tabletM) {
      return size * 1.2;
    } else if (longestSide >= phoneL) {
      return size * 1;
    } else if (longestSide >= phoneM) {
      return size * .8;
    } else {
      // small phone
      return size * .65;
    }
  }

  double get height => mediaQueryData.size.height;
  double get width => mediaQueryData.size.width;

  bool isTablet() {
    final longestSide = mediaQueryData.size.longestSide;
    return longestSide > 1000;
  }

  bool isMini() {
    final longestSide = mediaQueryData.size.longestSide;
    return longestSide < 700;
  }
}
