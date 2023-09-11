import 'package:flutter/material.dart';
import 'package:hng_stage_2/component/theme/app_theme.dart';

extension Size on Widget {
  sizing(double height, double width) {
    return SizedBox(
      height: height,
      width: width,
      child: this,
    );
  }
}

extension Sizing on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  double get scale => MediaQuery.of(this).textScaleFactor;
}

extension TextTheming on BuildContext {
  TextStyle get body1 => Theme.of(this).extension<HngTextTheme>()!.body1!;
  TextStyle get body2 => Theme.of(this).extension<HngTextTheme>()!.body2!;

  TextStyle get headline1 => Theme.of(this).extension<HngTextTheme>()!.headline1!;
  TextStyle get headline2 => Theme.of(this).extension<HngTextTheme>()!.headline2!;
  TextStyle get headline3 => Theme.of(this).extension<HngTextTheme>()!.headline3!;

  TextStyle get button => Theme.of(this).extension<HngTextTheme>()!.button!;
}

extension Space on num {
  SizedBox get widthSizing => SizedBox(width: toDouble());
  SizedBox get heightSizing => SizedBox(height: toDouble());
}

extension PadSymmetric on Widget {
  padding({required double horizontal, required double vertical}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: vertical,
      ),
      child: this,
    );
  }
}
