import 'package:flutter/material.dart';
import 'package:hng_stage_2/component/widgets/custom_text.dart';
import 'package:hng_stage_2/utils/extension.dart';

class EmptyPage extends StatelessWidget {
  final String message;
  const EmptyPage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.hourglass_empty_rounded,
          size: 100,
        ),
        24.heightSizing,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomText(
            data: message,
            textAlign: TextAlign.center,
            style: context.headline1.copyWith(
              fontSize: 16,
            ),
          ),
        )
      ],
    );
  }
}
