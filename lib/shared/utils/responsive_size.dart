import 'package:flutter/material.dart';

class ResponsiveSize {
  final Size mediaQueryData;

  const ResponsiveSize({required this.mediaQueryData});

  static ResponsiveSize of(BuildContext context) =>
      ResponsiveSize(mediaQueryData: MediaQuery.sizeOf(context));

  double scaleSize(double size) {
    double longestSide = mediaQueryData.longestSide;

    const tabletL = 1300;
    const tabletM = 1100;
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

  double get height => mediaQueryData.height;
  double get width => mediaQueryData.width;

  bool isTablet() {
    final longestSide = mediaQueryData.longestSide;
    return longestSide > 1100;
  }

    bool isMini() {
    final longestSide = mediaQueryData.longestSide;
    return longestSide < 700;
  }
}
