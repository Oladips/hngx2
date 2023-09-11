import 'package:flutter/material.dart';
import 'package:hng_stage_2/component/core/base_navigator.dart';
import 'package:hng_stage_2/component/model/work_experience_model.dart';
import 'package:hng_stage_2/component/widgets/custom_text.dart';
import 'package:hng_stage_2/utils/extension.dart';
import 'package:intl/intl.dart';

import '../../../component/theme/color.dart';
import '../../../component/widgets/custom_textfield.dart';

class AddExperience extends StatefulWidget {
  final WorkExperience? work;
  final List<WorkExperience>? workExp;

  const AddExperience({
    super.key,
    this.work,
    this.workExp,
  });

  @override
  State<AddExperience> createState() => _AddExperienceState();
}

class _AddExperienceState extends State<AddExperience> {
  WorkExperience? work;
  final _formKey = GlobalKey<FormState>();

  final jobtitleFocus = FocusNode();
  final companyFocus = FocusNode();
  final countryFocus = FocusNode();
  final descriptionFocus = FocusNode();

  DateTime? startDate;
  DateTime? endDate;

  final jobtitleController = TextEditingController();
  final companyController = TextEditingController();
  final countryController = TextEditingController();
  final descriptionController = TextEditingController();

  String? jobTitleError;
  String? companyError;
  String? countryError;
  String? descriptionError;

  List<String> descriptions = [];
  bool addPressed = false;

  @override
  void initState() {
    super.initState();
    work = widget.work;
    if (work != null) {
      jobtitleController.text = work!.title ?? "";
      companyController.text = work!.workplace ?? "";
      countryController.text = work!.location ?? "";
      startDate = work!.startTime;
      endDate = work!.endTime;
      descriptions = work!.activitiesDone ?? [];
    }
  }

  @override
  void dispose() {
    jobtitleController.dispose();
    companyController.dispose();
    countryController.dispose();

    jobtitleFocus.dispose();
    companyFocus.dispose();
    countryFocus.dispose();
    descriptionFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * .86,
      child: Padding(
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
                    data: "Add Job Experience",
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

                        if (descriptions.isEmpty) {
                          BaseNavigator.showSnackBar(
                            context,
                            isFail: true,
                            expanded: true,
                            color: AppColor.errorColor,
                            message: "You need to add one or more job description(s).",
                          );
                          return;
                        }

                        addPressed = false;
                        setState(() {});
                        BaseNavigator.pop(
                          WorkExperience(
                            id: work?.id ?? widget.workExp!.length + 1,
                            startTime: startDate,
                            endTime: endDate,
                            title: jobtitleController.text,
                            workplace: companyController.text,
                            location: countryController.text,
                            activitiesDone: descriptions,
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      16.heightSizing,
                      CustomTextField(
                        inputlabelPresent: true,
                        focus: jobtitleFocus,
                        labelText: "Job Title",
                        hintText: "",
                        filled: true,
                        suffix: false,
                        obscureText: false,
                        errorText: jobTitleError,
                        controller: jobtitleController,
                        validator: (p0) {
                          if (p0 == null || p0.trim().isEmpty) {
                            jobTitleError = "Please enter your job title";
                            setState(() {});
                            return jobTitleError;
                          }

                          jobTitleError = null;
                          setState(() {});
                          return jobTitleError;
                        },
                      ),
                      10.heightSizing,
                      CustomTextField(
                        inputlabelPresent: true,
                        focus: companyFocus,
                        labelText: "Company",
                        hintText: "",
                        filled: true,
                        suffix: false,
                        obscureText: false,
                        errorText: companyError,
                        controller: companyController,
                        validator: (p0) {
                          if (p0 == null || p0.trim().isEmpty) {
                            companyError = "Please enter your company's name";
                            setState(() {});
                            return companyError;
                          }

                          companyError = null;
                          setState(() {});
                          return companyError;
                        },
                      ),
                      10.heightSizing,
                      CustomTextField(
                        inputlabelPresent: true,
                        focus: countryFocus,
                        labelText: "Country",
                        hintText: "",
                        filled: true,
                        suffix: false,
                        obscureText: false,
                        errorText: countryError,
                        controller: countryController,
                        validator: (p0) {
                          if (p0 == null || p0.trim().isEmpty) {
                            countryError = "Please enter your country";
                            setState(() {});
                            return countryError;
                          }

                          countryError = null;
                          setState(() {});
                          return countryError;
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
                      16.heightSizing,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            data: "Add Job description(s)",
                            style: context.body1.copyWith(
                              color: AppColor.textLightModeFF2E,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              addPressed = true;
                              setState(() {});
                            },
                            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                            child: const Icon(
                              Icons.add,
                            ).sizing(30, 30),
                          )
                        ],
                      ),
                      10.heightSizing,
                      Builder(builder: (context) {
                        if (descriptions.isEmpty) {
                          return const SizedBox.shrink();
                        }

                        return Column(
                          children: descriptions
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.only(bottom: 6),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 5,
                                        width: 5,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black,
                                        ),
                                      ),
                                      12.widthSizing,
                                      Expanded(
                                        child: CustomText(
                                          data: e,
                                          textAlign: TextAlign.start,
                                          style: context.body1.copyWith(
                                            fontSize: 13,
                                            color: AppColor.textLightModeFF2E.withOpacity(.5),
                                          ),
                                        ),
                                      ),
                                      12.widthSizing,
                                      InkWell(
                                        onTap: () async {
                                          descriptions.removeWhere((element) => e.contains(element));
                                          setState(() {});
                                        },
                                        overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                                        child: const Icon(
                                          Icons.delete,
                                          color: AppColor.errorColor,
                                          size: 20,
                                        ).sizing(15, 15),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        );
                      }),
                      10.heightSizing,
                      Builder(builder: (context) {
                        if (!addPressed) {
                          return const SizedBox.shrink();
                        }
                        return CustomTextField(
                          inputlabelPresent: false,
                          focus: descriptionFocus,
                          labelText: "",
                          hintText: "",
                          filled: true,
                          suffix: true,
                          suffixIcon: InkWell(
                            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                            onTap: () {
                              if (descriptionController.text.trim().isEmpty) {
                                descriptionError = "Please enter a description";
                                setState(() {});
                                return;
                              }

                              descriptionError = null;
                              descriptions.add(descriptionController.text);
                              descriptionController.text = "";
                              addPressed = false;
                              FocusScope.of(context).unfocus();
                              setState(() {});
                            },
                            child: const Icon(Icons.check).sizing(30, 30),
                          ),
                          obscureText: false,
                          errorText: descriptionError,
                          controller: descriptionController,
                          validator: (p0) {
                            if (p0 == null || p0.trim().isEmpty) {
                              descriptionError = "Please enter a description";
                              setState(() {});
                              return descriptionError;
                            }

                            descriptionError = null;
                            setState(() {});
                            return descriptionError;
                          },
                        );
                      }),
                      24.heightSizing,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
