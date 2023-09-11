import 'package:flutter/material.dart';
import 'package:hng_stage_2/utils/extension.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String buttonText;
  final Color? buttonTextColor;
  final Color? backgroundColor;

  const CustomButton({
    super.key,
    this.onPressed,
    required this.buttonText,
    this.buttonTextColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(backgroundColor),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.all(12),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      child: CustomText(
        data: buttonText,
        style: context.headline2.copyWith(
          color: buttonTextColor ?? const Color(0xFF01002E),
        ),
      ),
    );
  }
}
