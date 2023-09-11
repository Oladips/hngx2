import 'package:flutter/material.dart';

@immutable
class HngTextTheme extends ThemeExtension<HngTextTheme> {
  final TextStyle? headline1;
  final TextStyle? headline2;
  final TextStyle? headline3;
  final TextStyle? body1;
  final TextStyle? body2;
  final TextStyle? button;

  const HngTextTheme({
    this.headline1,
    this.headline2,
    this.headline3,
    this.body1,
    this.body2,
    this.button,
  });

  const HngTextTheme.fallback()
      : this(
          headline1: const TextStyle(
            fontFamily: "Euclid",
            fontWeight: FontWeight.w500,
            height: 1.43,
            letterSpacing: 0,
          ),
          headline2: const TextStyle(
            fontFamily: "Euclid",
            fontWeight: FontWeight.w600,
            height: 1.43,
            letterSpacing: 0,
          ),
          headline3: const TextStyle(
            fontFamily: "Euclid",
            fontWeight: FontWeight.w700,
            height: 1.43,
            letterSpacing: 0,
          ),
          body1: const TextStyle(
            fontFamily: "Euclid",
            fontWeight: FontWeight.w400,
            height: 1.43,
            letterSpacing: 0,
          ),
          body2: const TextStyle(
            fontFamily: "Euclid",
            fontWeight: FontWeight.w300,
            height: 1.43,
            letterSpacing: 0,
          ),
          button: const TextStyle(
            fontFamily: "Euclid",
            height: 1.43,
            fontWeight: FontWeight.w700,
            letterSpacing: 0,
          ),
        );

  @override
  HngTextTheme copyWith({
    TextStyle? headline1,
    TextStyle? headline2,
    TextStyle? headline3,
    TextStyle? body1,
    TextStyle? body2,
    TextStyle? button,
  }) {
    return HngTextTheme(
      headline1: headline1 ?? this.headline1,
      headline2: headline2 ?? this.headline2,
      headline3: headline3 ?? this.headline3,
      body1: body1 ?? this.body1,
      body2: body2 ?? this.body2,
      button: button ?? this.button,
    );
  }

  @override
  ThemeExtension<HngTextTheme> lerp(covariant ThemeExtension<HngTextTheme>? other, double t) {
    if (other is! HngTextTheme) return this;

    return HngTextTheme(
      headline1: TextStyle.lerp(headline1, other.headline1, t),
      headline2: TextStyle.lerp(headline2, other.headline2, t),
      headline3: TextStyle.lerp(headline3, other.headline3, t),
      body1: TextStyle.lerp(body1, other.body1, t),
      body2: TextStyle.lerp(body2, other.body2, t),
      button: TextStyle.lerp(button, other.button, t),
    );
  }
}
