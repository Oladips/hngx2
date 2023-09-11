import 'package:flutter/material.dart';
import 'package:hng_stage_2/component/core/base_navigator.dart';
import 'package:hng_stage_2/component/model/language_model.dart';
import 'package:hng_stage_2/component/widgets/custom_text.dart';
import 'package:hng_stage_2/utils/extension.dart';

import '../../../component/widgets/custom_textfield.dart';

class AddLanguage extends StatefulWidget {
  final Language? language;
  final List<Language>? languageList;

  const AddLanguage({
    super.key,
    this.language,
    this.languageList,
  });

  @override
  State<AddLanguage> createState() => _AddLanguageState();
}

class _AddLanguageState extends State<AddLanguage> {
  Language? language;

  final languageFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  String? fluency;

  DateTime? startDate;
  DateTime? endDate;

  final languageController = TextEditingController();

  String? languageError;

  @override
  void initState() {
    super.initState();
    language = widget.language;
    if (language != null) {
      languageController.text = language!.language ?? "";
      fluency = language!.fluency;
    }
  }

  @override
  void dispose() {
    languageFocus.dispose();
    languageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            16.heightSizing,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  data: "Add Language",
                  style: context.headline2.copyWith(
                    fontSize: 16,
                  ),
                ),
                InkWell(
                  overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      BaseNavigator.pop(
                        Language(
                          id: language?.id ?? widget.languageList!.length + 1,
                          language: languageController.text,
                        ),
                      );
                    }
                  },
                  child: CustomText(
                    data: "Save",
                    style: context.headline1.copyWith(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            16.heightSizing,
            CustomTextField(
              inputlabelPresent: true,
              focus: languageFocus,
              labelText: "Language",
              hintText: "",
              filled: true,
              suffix: false,
              obscureText: false,
              errorText: languageError,
              controller: languageController,
              validator: (p0) {
                if (p0 == null || p0.trim().isEmpty) {
                  languageError = "Please enter your spoken language";
                  setState(() {});
                  return languageError;
                }

                languageError = null;
                setState(() {});
                return languageError;
              },
            ),
            24.heightSizing,
          ],
        ),
      ),
    );
  }
}
