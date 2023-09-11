import 'package:flutter/material.dart';
import 'package:hng_stage_2/component/core/base_navigator.dart';
import 'package:hng_stage_2/component/model/education_model.dart';
import 'package:hng_stage_2/component/model/language_model.dart';
import 'package:hng_stage_2/component/model/skills.dart';
import 'package:hng_stage_2/component/model/work_experience_model.dart';
import 'package:hng_stage_2/component/widgets/custom_text.dart';
import 'package:hng_stage_2/screens/edit/bottomsheet/edu_bottom_sheet.dart';
import 'package:hng_stage_2/screens/edit/bottomsheet/exp_bottom_sheet.dart';
import 'package:hng_stage_2/screens/edit/bottomsheet/language_bottomsheet.dart';
import 'package:hng_stage_2/screens/edit/bottomsheet/skill_bottomsheet.dart';
import 'package:hng_stage_2/screens/edit/widgets/empty_page.dart';
import 'package:hng_stage_2/utils/extension.dart';
import 'package:intl/intl.dart';

import '../../../component/theme/color.dart';
import '../../../component/widgets/custom_textfield.dart';

class EditPage extends StatefulWidget {
  final String fullName;
  final String username;
  final String bio;
  final String? image;
  final String phone;

  final String email;
  final String github;
  final String address;
  final List<WorkExperience> workExperiences;
  final List<EducationModel> education;
  final List<Language> languages;
  final List<Skill> skills;

  static const String routeName = "edit_screen";

  const EditPage({
    super.key,
    required this.fullName,
    required this.username,
    required this.bio,
    required this.email,
    required this.github,
    required this.address,
    required this.workExperiences,
    required this.education,
    required this.languages,
    required this.skills,
    required this.image,
    required this.phone,
  });

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> with TickerProviderStateMixin {
  final TextEditingController fullName = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController bio = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController github = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController phone = TextEditingController();

  late List<WorkExperience> workExp = [];

  late List<EducationModel> education = [];
  late List<Language> languages = [];
  late List<Skill> skills = [];
  String? image;

  final _contactInfo = GlobalKey<FormState>();

  final FocusNode fullNameFocus = FocusNode();
  final FocusNode usernameNameFocus = FocusNode();
  final FocusNode bioNameFocus = FocusNode();
  final FocusNode emailNameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode githubNameFocus = FocusNode();
  final FocusNode addressNameFocus = FocusNode();

  String? fullNameError;
  String? usernameError;
  String? emailError;
  String? phoneError;
  String? githubError;
  String? addressError;
  String? bioError;

  late final TabController controller;

  @override
  void initState() {
    super.initState();
    fullName.text = widget.fullName;
    username.text = widget.username;
    bio.text = widget.bio;
    email.text = widget.email;
    github.text = widget.github;
    address.text = widget.address;
    phone.text = widget.phone;
    workExp = widget.workExperiences;
    education = widget.education;
    languages = widget.languages;
    skills = widget.skills;
    image = widget.image;
    controller = TabController(
      length: 5,
      vsync: this,
    );
  }

  @override
  void dispose() {
    fullName.dispose();
    username.dispose();
    bio.dispose();
    email.dispose();
    github.dispose();
    address.dispose();
    phone.dispose();
    phoneFocus.dispose();
    fullNameFocus.dispose();
    usernameNameFocus.dispose();
    bioNameFocus.dispose();
    emailNameFocus.dispose();
    githubNameFocus.dispose();
    addressNameFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundLightMode2,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  InkWell(
                    overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                    onTap: () {
                      BaseNavigator.pop();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                    ).sizing(30, 30),
                  ),
                  16.widthSizing,
                  CustomText(
                    textAlign: TextAlign.center,
                    data: "Edit CV",
                    style: context.headline3.copyWith(
                      fontSize: 18,
                      color: AppColor.textLightModeBlack,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () async {
                      if (workExp.isEmpty) {
                        BaseNavigator.showSnackBar(
                          context,
                          isFail: true,
                          expanded: true,
                          color: AppColor.errorColor,
                          message: "You need to add one or more work experience(s).",
                        );
                        return;
                      }
                      if (education.isEmpty) {
                        BaseNavigator.showSnackBar(
                          context,
                          isFail: true,
                          expanded: true,
                          color: AppColor.errorColor,
                          message: "You need to add one or more education experience(s).",
                        );
                        return;
                      }
                      if (languages.isEmpty) {
                        BaseNavigator.showSnackBar(
                          context,
                          isFail: true,
                          expanded: true,
                          color: AppColor.errorColor,
                          message: "You need to add one or more fluenty spoken language(s).",
                        );
                        return;
                      }
                      if (skills.isEmpty) {
                        BaseNavigator.showSnackBar(
                          context,
                          isFail: true,
                          expanded: true,
                          color: AppColor.errorColor,
                          message: "You need to add one or more skill(s).",
                        );
                        return;
                      }
                      controller.animateTo(0, duration: const Duration(milliseconds: 150));
                      await Future.delayed(const Duration(milliseconds: 180));
                      if (_contactInfo.currentState!.validate()) {
                        BaseNavigator.pop({
                          "full_name": fullName.text,
                          "user_name": username.text,
                          "bio": bio.text,
                          "email": email.text,
                          "github": github.text,
                          "phone": phone.text,
                          "address": address.text,
                          "work_experiences": workExp,
                          "education": education,
                          "languages": languages,
                          "skills": skills,
                          "image": image,
                        });
                      }
                    },
                    overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                    child: CustomText(
                      textAlign: TextAlign.center,
                      data: "Save",
                      style: context.headline2.copyWith(
                        fontSize: 16,
                        color: AppColor.textLightModeBlack,
                      ),
                    ),
                  ),
                ],
              ),
              16.heightSizing,
              Stack(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(4),
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(
                        "assets/img/test.jpeg",
                      ),
                    ),
                  ),
                ],
              ),
              24.heightSizing,
              TabBar(
                controller: controller,
                labelColor: const Color(0xFF01002E),
                unselectedLabelColor: AppColor.textLightModeFF2E.withOpacity(.4),
                overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                indicatorColor: const Color(0xFF01002E),
                indicatorSize: TabBarIndicatorSize.label,
                tabs: const [
                  Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Icon(Icons.contact_mail_rounded),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Icon(Icons.work_history),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Icon(Icons.school_rounded),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Icon(Icons.language_rounded),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Icon(Icons.draw),
                  ),
                ],
              ),
              16.heightSizing,
              Expanded(
                child: TabBarView(
                  controller: controller,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomText(
                          data: "Contact Information",
                          style: context.headline2.copyWith(
                            color: AppColor.textLightModeFF2E,
                            fontSize: 16,
                          ),
                        ),
                        24.heightSizing,
                        Expanded(
                          child: Form(
                            key: _contactInfo,
                            child: ListView(
                              children: [
                                CustomTextField(
                                  inputlabelPresent: true,
                                  focus: fullNameFocus,
                                  labelText: "Full Name",
                                  hintText: "",
                                  filled: true,
                                  suffix: false,
                                  obscureText: false,
                                  errorText: fullNameError,
                                  controller: fullName,
                                  validator: (p0) {
                                    if (p0 == null || p0.trim().isEmpty) {
                                      fullNameError = "Please enter your full name";
                                      setState(() {});
                                      return fullNameError;
                                    }

                                    fullNameError = null;
                                    setState(() {});
                                    return fullNameError;
                                  },
                                ),
                                12.heightSizing,
                                CustomTextField(
                                  inputlabelPresent: true,
                                  focus: usernameNameFocus,
                                  labelText: "Username",
                                  hintText: "",
                                  filled: true,
                                  suffix: false,
                                  obscureText: false,
                                  errorText: usernameError,
                                  controller: username,
                                  validator: (p0) {
                                    if (p0 == null || p0.trim().isEmpty) {
                                      usernameError = "Please enter your username";
                                      setState(() {});
                                      return usernameError;
                                    }

                                    usernameError = null;
                                    setState(() {});
                                    return usernameError;
                                  },
                                ),
                                12.heightSizing,
                                CustomTextField(
                                  inputlabelPresent: true,
                                  focus: bioNameFocus,
                                  labelText: "Bio",
                                  hintText: "",
                                  filled: true,
                                  suffix: false,
                                  obscureText: false,
                                  errorText: bioError,
                                  maxLines: 6,
                                  controller: bio,
                                  validator: (p0) {
                                    if (p0 == null || p0.trim().isEmpty) {
                                      bioError = "Please enter your bio as it can't be empty";
                                      setState(() {});
                                      return bioError;
                                    }

                                    bioError = null;
                                    setState(() {});
                                    return bioError;
                                  },
                                ),
                                12.heightSizing,
                                CustomTextField(
                                  inputlabelPresent: true,
                                  focus: emailNameFocus,
                                  labelText: "Email Address",
                                  hintText: "",
                                  filled: true,
                                  suffix: false,
                                  obscureText: false,
                                  errorText: emailError,
                                  controller: email,
                                  validator: (p0) {
                                    if (p0 == null || p0.trim().isEmpty) {
                                      emailError = "Please enter your email address";
                                      setState(() {});
                                      return emailError;
                                    }

                                    emailError = null;
                                    setState(() {});
                                    return emailError;
                                  },
                                ),
                                12.heightSizing,
                                CustomTextField(
                                  inputlabelPresent: true,
                                  focus: phoneFocus,
                                  labelText: "Phone Number",
                                  hintText: "",
                                  filled: true,
                                  suffix: false,
                                  obscureText: false,
                                  errorText: phoneError,
                                  controller: phone,
                                  validator: (p0) {
                                    if (p0 == null || p0.trim().isEmpty) {
                                      phoneError = "Please enter your phone number";
                                      setState(() {});
                                      return phoneError;
                                    }

                                    phoneError = null;
                                    setState(() {});
                                    return phoneError;
                                  },
                                ),
                                12.heightSizing,
                                CustomTextField(
                                  inputlabelPresent: true,
                                  focus: githubNameFocus,
                                  labelText: "Github address",
                                  hintText: "",
                                  filled: true,
                                  suffix: false,
                                  obscureText: false,
                                  errorText: githubError,
                                  controller: github,
                                  validator: (p0) {
                                    if (p0 == null || p0.trim().isEmpty) {
                                      githubError = "Please enter your a github address";
                                      setState(() {});
                                      return githubError;
                                    }

                                    githubError = null;
                                    setState(() {});
                                    return githubError;
                                  },
                                ),
                                12.heightSizing,
                                CustomTextField(
                                  inputlabelPresent: true,
                                  focus: addressNameFocus,
                                  labelText: "Address",
                                  hintText: "",
                                  filled: true,
                                  suffix: false,
                                  obscureText: false,
                                  maxLines: 4,
                                  errorText: addressError,
                                  controller: address,
                                  validator: (p0) {
                                    if (p0 == null || p0.trim().isEmpty) {
                                      addressError = "Please enter your address";
                                      setState(() {});
                                      return addressError;
                                    }

                                    addressError = null;
                                    setState(() {});
                                    return addressError;
                                  },
                                ),
                                24.heightSizing,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomText(
                              data: "Work Experience",
                              style: context.headline2.copyWith(
                                color: AppColor.textLightModeFF2E,
                                fontSize: 16,
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                final res = await BaseNavigator.bottomSheet(
                                  child: AddExperience(
                                    workExp: workExp,
                                  ),
                                  context: context,
                                );

                                if (!mounted) return;

                                setState(() {});
                                if (res != null) {
                                  final check = workExp.where((element) => element.id == res.id);
                                  if (check.isEmpty) {
                                    workExp.add(res);
                                    setState(() {});
                                  }
                                }
                              },
                              overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                              child: const Icon(
                                Icons.add,
                              ).sizing(30, 30),
                            )
                          ],
                        ),
                        16.heightSizing,
                        Expanded(
                          child: Builder(builder: (context) {
                            if (workExp.isEmpty) {
                              return const EmptyPage(
                                message: "You have no work experience.\nYou can add your job experience by clicking on the + icon",
                              );
                            }
                            return ListView(
                              children: workExp
                                  .map(
                                    (exp) => Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                CustomText(
                                                  data: exp.title ?? "",
                                                  textAlign: TextAlign.start,
                                                  style: context.headline2.copyWith(
                                                    fontSize: 15,
                                                    letterSpacing: 0,
                                                  ),
                                                ),
                                                4.heightSizing,
                                                Text.rich(
                                                  TextSpan(children: [
                                                    TextSpan(
                                                      text: exp.workplace,
                                                      style: context.body1.copyWith(
                                                        letterSpacing: 0,
                                                        fontSize: 13,
                                                        color: AppColor.textLightModeFF2E.withOpacity(.8),
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: " - ",
                                                      style: context.body1.copyWith(
                                                        letterSpacing: 0,
                                                        fontSize: 13,
                                                        color: AppColor.textLightModeFF2E.withOpacity(.5),
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: exp.location,
                                                      style: context.body1.copyWith(
                                                        letterSpacing: 0,
                                                        fontSize: 13,
                                                        color: AppColor.textLightModeFF2E.withOpacity(.5),
                                                      ),
                                                    ),
                                                  ]),
                                                ),
                                                4.heightSizing,
                                                CustomText(
                                                  data:
                                                      "${DateFormat.yMMM().format(exp.startTime ?? DateTime.now())} to ${DateTime.now().month == exp.endTime?.month ? 'Present' : DateFormat.yMMM().format(exp.endTime ?? DateTime.now())}",
                                                  textAlign: TextAlign.start,
                                                  style: context.body1.copyWith(
                                                    fontSize: 13,
                                                    color: AppColor.textLightModeFF2E.withOpacity(.5),
                                                  ),
                                                ),
                                                10.heightSizing,
                                                Column(
                                                  children: exp.activitiesDone
                                                          ?.map(
                                                            (e) => Padding(
                                                              padding: const EdgeInsets.only(bottom: 4),
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
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                          .toList() ??
                                                      [],
                                                ),
                                              ],
                                            ),
                                          ),
                                          12.widthSizing,
                                          InkWell(
                                            onTap: () async {
                                              final res = await BaseNavigator.bottomSheet(
                                                child: AddExperience(
                                                  work: WorkExperience(
                                                    id: exp.id,
                                                    startTime: exp.startTime,
                                                    endTime: exp.endTime,
                                                    title: exp.title,
                                                    workplace: exp.workplace,
                                                    location: exp.location,
                                                    activitiesDone: List<String>.from(exp.activitiesDone!),
                                                  ),
                                                  workExp: workExp,
                                                ),
                                                context: context,
                                              );

                                              if (!mounted) return;

                                              if (res != null) {
                                                final check = workExp.where((element) => element.id == res.id);
                                                if (check.isNotEmpty) {
                                                  final index = workExp.indexWhere((element) => element.id == res.id);
                                                  workExp.removeAt(index);
                                                  workExp.insert(index, res);
                                                  setState(() {});
                                                }
                                              }
                                            },
                                            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                                            child: const Icon(
                                              Icons.edit_note_rounded,
                                              color: AppColor.textLightModeFF2E,
                                            ).sizing(30, 30),
                                          ),
                                          12.widthSizing,
                                          InkWell(
                                            onTap: () async {
                                              workExp.removeWhere((element) => element.id == exp.id);
                                              setState(() {});
                                            },
                                            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                                            child: const Icon(
                                              Icons.delete,
                                              color: AppColor.errorColor,
                                            ).sizing(30, 30),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            );
                          }),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomText(
                              data: "Education",
                              style: context.headline2.copyWith(
                                color: AppColor.textLightModeFF2E,
                                fontSize: 16,
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                final res = await BaseNavigator.bottomSheet(
                                  child: AddEducationExperience(
                                    educationList: education,
                                  ),
                                  context: context,
                                );

                                if (!mounted) return;

                                if (res != null) {
                                  final check = education.where((element) => element.id == res.id);
                                  if (check.isEmpty) {
                                    education.add(res);
                                    setState(() {});
                                  }
                                }
                              },
                              overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                              child: const Icon(
                                Icons.add,
                              ).sizing(30, 30),
                            )
                          ],
                        ),
                        16.heightSizing,
                        Expanded(
                          child: Builder(builder: (context) {
                            if (education.isEmpty) {
                              return const EmptyPage(
                                message: "You have no previous education experience.\nYou can add your education experience by clicking on the + icon",
                              );
                            }
                            return ListView(
                              children: education
                                  .map(
                                    (edu) => Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                CustomText(
                                                  data: edu.qualification ?? "",
                                                  textAlign: TextAlign.start,
                                                  style: context.headline2.copyWith(
                                                    fontSize: 15,
                                                    letterSpacing: 0,
                                                  ),
                                                ),
                                                4.heightSizing,
                                                CustomText(
                                                  data: edu.school ?? "",
                                                  textAlign: TextAlign.start,
                                                  style: context.body1.copyWith(
                                                    fontSize: 13,
                                                    color: AppColor.textLightModeFF2E.withOpacity(.5),
                                                  ),
                                                ),
                                                4.heightSizing,
                                                CustomText(
                                                  data:
                                                      "${DateFormat.yMMM().format(edu.startTime ?? DateTime.now())} to ${DateTime.now().month == edu.endTime?.month ? 'Present' : DateFormat.yMMM().format(edu.endTime ?? DateTime.now())}",
                                                  textAlign: TextAlign.start,
                                                  style: context.body2.copyWith(
                                                    fontSize: 13,
                                                    color: AppColor.textLightModeFF2E.withOpacity(.5),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          12.widthSizing,
                                          InkWell(
                                            onTap: () async {
                                              final res = await BaseNavigator.bottomSheet(
                                                child: AddEducationExperience(
                                                  education: edu,
                                                  educationList: education,
                                                ),
                                                context: context,
                                              );

                                              if (!mounted) return;

                                              if (res != null) {
                                                final check = education.where((element) => element.id == res.id);
                                                if (check.isNotEmpty) {
                                                  final index = education.indexWhere((element) => element.id == res.id);
                                                  education.removeAt(index);
                                                  education.insert(index, res);
                                                  setState(() {});
                                                }
                                              }
                                            },
                                            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                                            child: const Icon(
                                              Icons.edit_note_rounded,
                                              color: AppColor.textLightModeFF2E,
                                            ).sizing(30, 30),
                                          ),
                                          12.widthSizing,
                                          InkWell(
                                            onTap: () async {
                                              education.removeWhere((element) => element.id == edu.id);
                                              setState(() {});
                                            },
                                            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                                            child: const Icon(
                                              Icons.delete,
                                              color: AppColor.errorColor,
                                            ).sizing(30, 30),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            );
                          }),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomText(
                              data: "Languages",
                              style: context.headline2.copyWith(
                                color: AppColor.textLightModeFF2E,
                                fontSize: 16,
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                final res = await BaseNavigator.bottomSheet(
                                  child: AddLanguage(
                                    languageList: languages,
                                  ),
                                  context: context,
                                );

                                if (!mounted) return;

                                if (res != null) {
                                  final check = languages.where((element) => element.id == res.id);
                                  if (check.isEmpty) {
                                    languages.add(res);
                                    setState(() {});
                                  }
                                }
                              },
                              overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                              child: const Icon(
                                Icons.add,
                              ).sizing(30, 30),
                            )
                          ],
                        ),
                        16.heightSizing,
                        Expanded(
                          child: Builder(builder: (context) {
                            if (languages.isEmpty) {
                              return const EmptyPage(
                                message: "You have no fluent spoken languages.\nYou can add your spoken languages by clicking on the + icon",
                              );
                            }
                            return ListView(
                              children: languages
                                  .map(
                                    (lang) => Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
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
                                              data: "${lang.language}",
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
                                              final res = await BaseNavigator.bottomSheet(
                                                child: AddLanguage(
                                                  language: lang,
                                                  languageList: languages,
                                                ),
                                                context: context,
                                              );

                                              if (!mounted) return;

                                              if (res != null) {
                                                final check = languages.where((element) => element.id == res.id);
                                                if (check.isNotEmpty) {
                                                  final index = languages.indexWhere((element) => element.id == res.id);
                                                  languages.removeAt(index);
                                                  languages.insert(index, res);
                                                  setState(() {});
                                                }
                                              }
                                            },
                                            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                                            child: const Icon(
                                              Icons.edit_note_rounded,
                                              color: AppColor.textLightModeFF2E,
                                            ).sizing(30, 30),
                                          ),
                                          12.widthSizing,
                                          InkWell(
                                            onTap: () async {
                                              languages.removeWhere((element) => element.id == lang.id);
                                              setState(() {});
                                            },
                                            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                                            child: const Icon(
                                              Icons.delete,
                                              color: AppColor.errorColor,
                                            ).sizing(30, 30),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            );
                          }),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomText(
                              data: "Skills",
                              style: context.headline2.copyWith(
                                color: AppColor.textLightModeFF2E,
                                fontSize: 16,
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                final res = await BaseNavigator.bottomSheet(
                                  child: AddSkill(
                                    skillList: skills,
                                  ),
                                  context: context,
                                );

                                if (!mounted) return;

                                if (res != null) {
                                  final check = skills.where((element) => element.id == res.id);
                                  if (check.isEmpty) {
                                    skills.add(res);
                                    setState(() {});
                                  }
                                }
                              },
                              overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                              child: const Icon(
                                Icons.add,
                              ).sizing(30, 30),
                            )
                          ],
                        ),
                        16.heightSizing,
                        Expanded(
                          child: Builder(builder: (context) {
                            if (skills.isEmpty) {
                              return const EmptyPage(
                                message: "You have no inputed skill.\nYou can add your skills by clicking on the + icon",
                              );
                            }
                            return ListView(
                              children: skills
                                  .map(
                                    (skill) => Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
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
                                              data: skill.skill ?? "",
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
                                              final res = await BaseNavigator.bottomSheet(
                                                child: AddSkill(
                                                  skill: skill,
                                                  skillList: skills,
                                                ),
                                                context: context,
                                              );

                                              if (!mounted) return;

                                              if (res != null) {
                                                final check = skills.where((element) => element.id == res.id);
                                                if (check.isNotEmpty) {
                                                  final index = skills.indexWhere((element) => element.id == res.id);
                                                  skills.removeAt(index);
                                                  skills.insert(index, res);
                                                  setState(() {});
                                                }
                                              }
                                            },
                                            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                                            child: const Icon(
                                              Icons.edit_note_rounded,
                                              color: AppColor.textLightModeFF2E,
                                            ).sizing(30, 30),
                                          ),
                                          12.widthSizing,
                                          InkWell(
                                            onTap: () async {
                                              skills.removeWhere((element) => element.id == skill.id);
                                              setState(() {});
                                            },
                                            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                                            child: const Icon(
                                              Icons.delete,
                                              color: AppColor.errorColor,
                                            ).sizing(30, 30),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            );
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
