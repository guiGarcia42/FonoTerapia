import 'package:flutter/material.dart';

class ResponsiveSize {
  final Size mediaQueryData;

  const ResponsiveSize({required this.mediaQueryData});

  static ResponsiveSize of(BuildContext context) =>
      ResponsiveSize(mediaQueryData: MediaQuery.sizeOf(context));

  double scaleSize(double size) {
    double shortestSide = mediaQueryData.shortestSide;

    const tabletXl = 1000;
    const tabletLg = 800;
    const tabletSm = 600;
    const phoneLg = 400;

    if (shortestSide >= tabletXl) {
      return size * 1.25;
    } else if (shortestSide >= tabletLg) {
      return size * 1.15;
    } else if (shortestSide >= tabletSm) {
      return size * 1;
    } else if (shortestSide >= phoneLg) {
      return size * .8;
    } else {
      return size * .7; // small phone
    }
  }

  double get height => mediaQueryData.height;
  double get width => mediaQueryData.width;

  bool isTablet() {
    final shortestSide = mediaQueryData.shortestSide;
    return shortestSide >= 600;
  }
}
