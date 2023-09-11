import 'package:flutter/material.dart';
import 'package:hng_stage_2/component/model/education_model.dart';
import 'package:hng_stage_2/component/widgets/custom_text.dart';
import 'package:hng_stage_2/utils/extension.dart';
import 'package:intl/intl.dart';

import '../../../component/core/base_navigator.dart';
import '../../../component/theme/color.dart';
import '../../../component/widgets/custom_textfield.dart';

class AddEducationExperience extends StatefulWidget {
  final EducationModel? education;
  final List<EducationModel>? educationList;

  const AddEducationExperience({
    super.key,
    this.education,
    this.educationList,
  });

  @override
  State<AddEducationExperience> createState() => _AddEducationExperienceState();
}

class _AddEducationExperienceState extends State<AddEducationExperience> {
  EducationModel? education;

  final schoolFocus = FocusNode();
  final qualificationFocus = FocusNode();

  DateTime? startDate;
  DateTime? endDate;

  final schoolController = TextEditingController();
  final qualificationController = TextEditingController();

  String? schoolError;
  String? qualificationError;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    education = widget.education;
    if (education != null) {
      schoolController.text = education!.school ?? "";
      qualificationController.text = education!.qualification ?? "";
      startDate = education!.startTime;
      endDate = education!.endTime;
    }
  }

  @override
  void dispose() {
    schoolFocus.dispose();
    qualificationFocus.dispose();
    schoolController.dispose();
    qualificationController.dispose();
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
                  data: "Add Education",
                  style: context.headline2.copyWith(
                    fontSize: 16,
                  ),
                ),
                InkWell(
                  overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (startDate == null || endDate == null) {
                        BaseNavigator.showSnackBar(
                          context,
                          isFail: true,
                          expanded: true,
                          color: AppColor.errorColor,
                          message: "You need to select a starting date and your current time status.",
                        );
                        return;
                      }

                      BaseNavigator.pop(
                        EducationModel(
                          id: education?.id ?? widget.educationList!.length + 1,
                          startTime: startDate,
                          endTime: endDate,
                          school: schoolController.text,
                          qualification: qualificationController.text,
                        ),
                      );
                      // }
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
              focus: schoolFocus,
              labelText: "School",
              hintText: "",
              filled: true,
              suffix: false,
              obscureText: false,
              errorText: schoolError,
              controller: schoolController,
              validator: (p0) {
                if (p0 == null || p0.trim().isEmpty) {
                  schoolError = "Please enter your school";
                  setState(() {});
                  return schoolError;
                }

                schoolError = null;
                setState(() {});
                return schoolError;
              },
            ),
            10.heightSizing,
            CustomTextField(
              inputlabelPresent: true,
              focus: qualificationFocus,
              labelText: "Qualification",
              hintText: "",
              filled: true,
              suffix: false,
              obscureText: false,
              errorText: qualificationError,
              controller: qualificationController,
              validator: (p0) {
                if (p0 == null || p0.trim().isEmpty) {
                  qualificationError = "Please enter your education qualification";
                  setState(() {});
                  return qualificationError;
                }

                qualificationError = null;
                setState(() {});
                return qualificationError;
              },
            ),
            10.heightSizing,
            Row(
              children: [
                InkWell(
                  overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                  onTap: () async {
                    final s = await showDatePicker(
                      context: context,
                      initialDate: startDate ?? DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );

                    if (!mounted) return;
                    if (s != null) {
                      startDate = s;
                      setState(() {});
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        data: "From",
                        style: context.body1.copyWith(
                          color: AppColor.textLightModeFF2E,
                          fontSize: 13,
                        ),
                      ),
                      8.heightSizing,
                      Container(
                        width: (context.width - 56) / 2,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: CustomText(
                          data: startDate != null ? DateFormat.yMMM().format(startDate!) : "Select Date",
                          style: context.body1.copyWith(
                            color: AppColor.textLightModeFF2E,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                24.widthSizing,
                InkWell(
                  onTap: () async {
                    final s = await showDatePicker(
                      context: context,
                      initialDate: endDate ?? DateTime.now(),
                      firstDate: startDate ?? DateTime(1900),
                      lastDate: DateTime(2100),
                    );

                    if (!mounted) return;
                    if (s != null) {
                      endDate = s;
                      setState(() {});
                    }
                  },
                  overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        data: "To",
                        style: context.body1.copyWith(
                          color: AppColor.textLightModeFF2E,
                          fontSize: 13,
                        ),
                      ),
                      8.heightSizing,
                      Container(
                        width: (context.width - 56) / 2,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: CustomText(
                          data: endDate != null ? DateFormat.yMMM().format(endDate!) : "Select Date",
                          style: context.body1.copyWith(
                            color: AppColor.textLightModeFF2E,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            24.heightSizing,
          ],
        ),
      ),
    );
  }
}
