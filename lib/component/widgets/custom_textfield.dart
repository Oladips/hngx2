// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hng_stage_2/component/theme/color.dart';
import 'package:hng_stage_2/utils/extension.dart';

import 'custom_text.dart';

@immutable
class CustomTextField extends StatefulWidget {
  final bool? inputlabelPresent;
  final String? labelText;
  final String? hintText;
  final bool? filled;
  final TextEditingController? controller;
  final FocusNode? focus;
  final String? Function(String?)? validator;
  bool? obscureText;
  final bool? suffix;
  final int? maxLines;
  final Widget? suffixIcon;
  final String? errorText;
  final Function(String)? onChanged;
  Function(bool)? external;

  CustomTextField({
    super.key,
    this.inputlabelPresent,
    this.labelText,
    this.hintText,
    this.filled,
    this.validator,
    this.controller,
    this.focus,
    this.obscureText,
    this.suffix,
    this.errorText,
    this.onChanged,
    this.external,
    this.suffixIcon,
    this.maxLines,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.inputlabelPresent == true) ...[
          Column(
            children: [
              CustomText(
                data: widget.labelText!,
                style: context.body1.copyWith(
                  color: AppColor.textLightModeFF2E,
                  fontSize: 13,
                ),
              ),
              8.heightSizing,
            ],
          ),
        ],
        Container(
          padding: widget.focus!.hasFocus
              ? const EdgeInsets.all(2.5)
              : widget.errorText != null
                  ? const EdgeInsets.all(2.5)
                  : const EdgeInsets.all(0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: widget.errorText != null ? AppColor.errorColor.withOpacity(.1) : AppColor.textFieldBorder,
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: widget.focus,
            onChanged: widget.onChanged,
            cursorColor: Colors.black,
            style: context.body1.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 14,
            ),
            obscureText: widget.obscureText ?? false,
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            validator: widget.validator,
            obscuringCharacter: "*",
            maxLines: widget.maxLines ?? 1,
            decoration: InputDecoration(
              filled: widget.filled,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(14),
              hintText: widget.hintText,
              errorMaxLines: 1,
              hintStyle: context.body1.copyWith(
                color: AppColor.hintTextHeader2E,
              ),
              errorStyle: const TextStyle(
                color: Colors.transparent,
                fontSize: 0,
              ),
              suffixIcon: widget.suffixIcon ??
                  Builder(
                    builder: (_) {
                      if (!widget.focus!.hasFocus && widget.suffix == false || widget.suffix == null) {
                        return const SizedBox.shrink();
                      }
                      if (widget.suffix == true) {
                        if (widget.obscureText != true) {
                          return InkWell(
                            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                            onTap: () async {
                              widget.obscureText = !widget.obscureText!;
                              await (widget.external ?? () {})(widget.obscureText);
                              setState(() {});
                            },
                            child: const Icon(
                              Icons.visibility_outlined,
                              color: AppColor.textLightModeFF2E,
                            ),
                          );
                        } else {
                          return Builder(builder: (context) {
                            return InkWell(
                              overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                              onTap: () async {
                                widget.obscureText = !widget.obscureText!;
                                await (widget.external ?? () {})(widget.obscureText);
                                setState(() {});
                              },
                              child: const Icon(
                                Icons.visibility_off_outlined,
                                color: AppColor.textLightModeFF2E,
                              ),
                            );
                          });
                        }
                      }
                      return const SizedBox.shrink();
                    },
                  ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: widget.errorText != null
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColor.errorColor,
                        width: 1.8,
                      ),
                    )
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColor.textLightModeFF2E,
                        width: 1.8,
                      ),
                    ),
            ),
          ),
        ),
        8.heightSizing,
        Builder(
          builder: (_) {
            if (widget.errorText == null) {
              return const SizedBox.shrink();
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline_outlined,
                  color: AppColor.errorColor,
                  size: 16,
                ),
                4.widthSizing,
                CustomText(
                  data: widget.errorText!,
                  style: context.body1.copyWith(
                    color: AppColor.errorColor,
                    fontSize: 13,
                  ),
                )
              ],
            );
          },
        ),
      ],
    );
  }
}
