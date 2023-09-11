import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hng_stage_2/component/core/base_navigator.dart';
import 'package:hng_stage_2/component/model/education_model.dart';
import 'package:hng_stage_2/component/model/language_model.dart';
import 'package:hng_stage_2/component/model/work_experience_model.dart';
import 'package:hng_stage_2/component/theme/color.dart';
import 'package:hng_stage_2/component/widgets/custom_button.dart';
import 'package:hng_stage_2/screens/edit/pages/edit_page.dart';
import 'package:hng_stage_2/utils/extension.dart';
import 'package:intl/intl.dart';

import '../../../component/model/skills.dart';
import '../../../component/widgets/custom_text.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "home_screen";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController controller = ScrollController();

  String? fullName = "Adedoyin Oladipupo Abiodun";
  String? userName = "Ab10duN";
  String? image;
  String? bio =
      "I am a versatile professional and individual always ready to learn something new every day. I currently work using flutter as a tool which I absolutely love. I will describe myself as a critical thinker, skilled team player with strong background in high- paced environments. I also work well independently to handle assignments and I am always ready to go beyond basics assignments. A quick learner with good computer abilities and always dedicated to the business success.";
  String? email = "abiodundipupo@gmail.com";
  String? phone = "+2348038827305";
  String? github = "https://github.com/Oladips/hngx2";
  String? address = "5 Etegbin last bustop opposite prince kosoko elemikaiye street, shibiri, Ojo, Lagos.";

  List<Skill> skills = [
    Skill(id: 1, skill: "Flutter"),
    Skill(id: 2, skill: "Dart"),
    Skill(id: 3, skill: "Git"),
    Skill(id: 4, skill: "Figma"),
    Skill(id: 5, skill: "Firebase"),
    Skill(id: 6, skill: "Javascript"),
    Skill(id: 7, skill: "Node.js"),
    Skill(id: 8, skill: "Adobe Illustrator"),
    Skill(id: 9, skill: "Rest APIs"),
    Skill(id: 10, skill: "GraphQl"),
  ];

  List<Language> languages = [
    Language(
      id: 1,
      language: "English",
      fluency: "Fluent",
    )
  ];

  List<EducationModel> education = [
    EducationModel(
      id: 1,
      startTime: DateTime(2015, 8),
      endTime: DateTime(2020, 12),
      school: 'Federal University of Technology Akure',
      qualification: "Bachalor of Engineering(B.Eng)",
    )
  ];
  List<WorkExperience> workExperiences = [
    WorkExperience(
      id: 1,
      startTime: DateTime(2018, 12),
      endTime: DateTime(2019, 3),
      title: "Mobile Developer Intern",
      workplace: "Devs District",
      location: "Ondo, Nigeria",
      activitiesDone: [
        "Indepth study and implementation of DART language.",
        "Introduction to OOP (Object Oriented Programming).",
        "Introduction to Flutter.",
        "Introduction to the iOS and android ecosystem.",
        "Built clones of existing applications.",
      ],
    ),
    WorkExperience(
      id: 2,
      startTime: DateTime(2021, 8),
      endTime: DateTime(2021, 10),
      title: "Mobile Developer Intern",
      workplace: "HNG(Remote)",
      location: "Lagos, Nigeria",
      activitiesDone: [
        "Introduction to Architecture",
        "Introduction to state management (Bloc, Provider, Stacked,Getx).",
        "Contribution to an opensource project",
      ],
    ),
    WorkExperience(
      id: 3,
      startTime: DateTime(2021, 10),
      endTime: DateTime(2022, 6),
      title: "Junior Mobile Developer",
      workplace: "Casamart",
      location: "Lagos, Nigeria",
      activitiesDone: [
        "Implemented design prototypes.",
        "Analyzed information to determine, recommend, and direction of the new product",
      ],
    ),
    WorkExperience(
      id: 4,
      startTime: DateTime(2022, 5),
      endTime: DateTime(2023, 9),
      title: "Mobile Developer",
      workplace: "Zettlo",
      location: "Oslo, Norway",
      activitiesDone: [
        "Liaised with the CEO to size and estimate software changes and features based upon functional and technical experience.",
        "Performed technical analysis to determine best ways to meet functional objectives.",
        "Implemented rapid prototypes to get products to market quickly.",
        "Discovered, evaluated, and implemented modern technologies to maximize development efficiency and optimize developer experience.",
        "Analyzed embedded code to troubleshoot problems between embedded software and mobile app.",
        "Cultivated and established best practices for mobile applications and evangelized continuous delivery with focus on speed, risks, and fast end-user feedback.",
        "Proposed solutions that integrated with proprietary platforms and third-party systems using native software development kits, web services, and other technologies.",
        "Documented style guidelines to keep the design consistent across the team.",
        "Continuously studied and improved abilities with wide range of web technologies, design tools and programming practices.",
      ],
    ),
    WorkExperience(
      id: 5,
      startTime: DateTime(2022, 6),
      endTime: DateTime(2023, 9),
      title: "Lead Mobile Developer",
      workplace: "Apex Network",
      location: "Lagos, Nigeria",
      activitiesDone: [
        "Collaborated with cross-functional teams to define, design, and ship new features.",
        "Performed technical analysis to determine best ways to meet functional objectives.",
        "Implemented rapid prototypes to get products to market quickly.",
        "Proposed solutions that integrated with proprietary platforms and third-party systems using native software development kits, web services, and other technologies.",
        "Focused on continuous improvement by keeping up-to-date on latest Android and iOS developments and trends and presenting for architectural review.",
        "Cultivated and established best practices for mobile applications and evangelized continuous delivery with focus on speed, risks, and fast end-user feedback.",
        "Discovered, evaluated, and implemented modern technologies to maximize development efficiency and optimize developer experience.",
        "Analyzed embedded code to troubleshoot problems between embedded software and mobile app.",
        "Documented style guidelines to keep the design consistent across the team."
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  double get top {
    double res = context.height * .15;
    if (controller.hasClients) {
      double offset = controller.offset;
      if (offset < (res - kToolbarHeight)) {
        res -= offset;
      } else {
        res = kToolbarHeight;
      }
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColor.backgroundLightMode2,
        body: Stack(
          alignment: Alignment.center,
          children: [
            NestedScrollView(
              controller: controller,
              physics: const BouncingScrollPhysics(),
              headerSliverBuilder: (context, value) {
                return [
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: context.height * .15,
                    collapsedHeight: kToolbarHeight + 20,
                    stretch: true,
                    flexibleSpace: DecoratedBox(
                      decoration: BoxDecoration(
                        image: image != null
                            ? DecorationImage(
                                image: FileImage(File(image!)),
                                fit: BoxFit.cover,
                              )
                            : const DecorationImage(
                                image: AssetImage("assets/img/vector_png.png"),
                                fit: BoxFit.cover,
                              ),
                        gradient: LinearGradient(
                          colors: <Color>[
                            const Color(0xFF01002E).withOpacity(.8),
                            const Color(0xFF01002E).withOpacity(.9),
                            const Color(0xFF01002E).withOpacity(.95),
                            const Color(0xFF01002E),
                          ],
                        ),
                      ),
                      child: SafeArea(
                        child: FlexibleSpaceBar(
                          expandedTitleScale: 1,
                          collapseMode: CollapseMode.parallax,
                          stretchModes: const [
                            StretchMode.zoomBackground,
                            StretchMode.blurBackground,
                          ],
                          titlePadding: EdgeInsets.zero,
                          title: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            height: context.height * .24,
                            width: context.width,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Builder(builder: (context) {
                                if (!(top < (kToolbarHeight + 50))) {
                                  return const SizedBox.shrink();
                                }
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                                      onTap: () {},
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        padding: const EdgeInsets.all(2),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.green.withOpacity(.3),
                                          ),
                                          child: Builder(builder: (context) {
                                            if (image != null) {
                                              return CircleAvatar(
                                                radius: 40,
                                                backgroundImage: FileImage(
                                                  File(image!),
                                                ),
                                              );
                                            }
                                            return const CircleAvatar(
                                              radius: 40,
                                              backgroundImage: AssetImage(
                                                "assets/img/test.jpeg",
                                              ),
                                            );
                                          }),
                                        ),
                                      ),
                                    ),
                                    12.widthSizing,
                                    CustomText(
                                      data: "$fullName ☀️",
                                      textAlign: TextAlign.left,
                                      style: context.headline3.copyWith(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () async {
                                        final result = await BaseNavigator.pushNamed(
                                          EditPage.routeName,
                                          arguments: {
                                            "full_name": fullName,
                                            "user_name": userName,
                                            "bio": bio,
                                            "email": email,
                                            "image": image,
                                            "phone": phone,
                                            "github": github,
                                            "address": address,
                                            "work_experiences": List<WorkExperience>.from(workExperiences),
                                            "education": List<EducationModel>.from(education),
                                            "languages": List<Language>.from(languages),
                                            "skills": List<Skill>.from(skills),
                                          },
                                        );

                                        if (!mounted) return;

                                        if (result != null) {
                                          setState(() {
                                            fullName = result["full_name"];
                                            userName = result["user_name"];
                                            bio = result["bio"];
                                            email = result["email"];
                                            github = result["github"];
                                            address = result["address"];
                                            phone = result["phone"];
                                            workExperiences = result["work_experiences"];
                                            education = result["education"];
                                            languages = result["languages"];
                                            skills = result["skills"];
                                            image = result["image"];
                                          });
                                        }
                                      },
                                      child: const Icon(
                                        Icons.edit_document,
                                        color: Colors.white,
                                      ).sizing(30, 30),
                                    )
                                  ],
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView(
                    children: [
                      CustomText(
                        textAlign: TextAlign.center,
                        data: fullName ?? "",
                        style: context.headline3.copyWith(
                          fontSize: 18,
                        ),
                      ),
                      CustomText(
                        data: "@$userName",
                        textAlign: TextAlign.center,
                        style: context.body1.copyWith(
                          fontSize: 13,
                        ),
                      ),
                      10.heightSizing,
                      Column(
                        children: [
                          CustomButton(
                            buttonText: "Edit CV",
                            backgroundColor: const Color(0xFFE6E5EA),
                            onPressed: () async {
                              final result = await BaseNavigator.pushNamed(
                                EditPage.routeName,
                                arguments: {
                                  "full_name": fullName,
                                  "user_name": userName,
                                  "bio": bio,
                                  "email": email,
                                  "github": github,
                                  "phone": phone,
                                  "address": address,
                                  "work_experiences": List<WorkExperience>.from(workExperiences),
                                  "education": List<EducationModel>.from(education),
                                  "languages": List<Language>.from(languages),
                                  "skills": List<Skill>.from(skills),
                                  "image": image,
                                },
                              );

                              if (!mounted) return;

                              if (result != null) {
                                setState(() {
                                  fullName = result["full_name"];
                                  userName = result["user_name"];
                                  bio = result["bio"];
                                  email = result["email"];
                                  github = result["github"];
                                  phone = result["phone"];
                                  address = result["address"];
                                  workExperiences = result["work_experiences"];
                                  education = result["education"];
                                  languages = result["languages"];
                                  skills = result["skills"];
                                  image = result["image"];
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      16.heightSizing,
                      Divider(
                        color: AppColor.textLightModeFF2E.withOpacity(.04),
                      ),
                      CustomText(
                        data: "Bio",
                        style: context.headline2.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      8.heightSizing,
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: CustomText(
                          data: bio ?? "",
                          textAlign: TextAlign.left,
                          style: context.body1.copyWith(
                            fontSize: 14,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      16.heightSizing,
                      CustomText(
                        data: "Basic Information",
                        style: context.headline2.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      8.heightSizing,
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            8.heightSizing,
                            Builder(builder: (context) {
                              if (email == null) {
                                return const SizedBox.shrink();
                              }

                              if (email!.isEmpty) {
                                return const SizedBox.shrink();
                              }
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.email,
                                    size: 16,
                                  ),
                                  4.widthSizing,
                                  CustomText(
                                    data: email ?? "",
                                    textAlign: TextAlign.start,
                                    style: context.body1.copyWith(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              );
                            }),
                            10.heightSizing,
                            Builder(builder: (context) {
                              if (phone == null) {
                                return const SizedBox.shrink();
                              }

                              if (phone!.isEmpty) {
                                return const SizedBox.shrink();
                              }
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.phone,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: CustomText(
                                      data: phone ?? "",
                                      style: context.body1.copyWith(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                            10.heightSizing,
                            Builder(builder: (context) {
                              if (github == null) {
                                return const SizedBox.shrink();
                              }

                              if (github!.isEmpty) {
                                return const SizedBox.shrink();
                              }
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        "assets/img/github.png",
                                      ),
                                    ),
                                  ),
                                  4.widthSizing,
                                  Expanded(
                                    child: CustomText(
                                      data: github ?? "",
                                      textAlign: TextAlign.start,
                                      style: context.body1.copyWith(
                                        fontSize: 14,
                                        letterSpacing: 0,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                            10.heightSizing,
                            Builder(builder: (context) {
                              if (address == null) {
                                return const SizedBox.shrink();
                              }

                              if (address!.isEmpty) {
                                return const SizedBox.shrink();
                              }
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.location_pin,
                                    size: 16,
                                  ),
                                  4.widthSizing,
                                  Expanded(
                                    child: CustomText(
                                      data: address ?? "",
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.clip,
                                      style: context.body1.copyWith(
                                        fontSize: 14,
                                        letterSpacing: 0,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                      16.heightSizing,
                      Builder(builder: (context) {
                        if (workExperiences.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomText(
                              data: "Work Experience",
                              style: context.headline3.copyWith(
                                fontSize: 16,
                              ),
                            ),
                            8.heightSizing,
                            Column(
                              children: workExperiences
                                  .map(
                                    (exp) => Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
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
                                  )
                                  .toList(),
                            ),
                            16.heightSizing,
                          ],
                        );
                      }),
                      Builder(builder: (_) {
                        if (education.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomText(
                              data: "Education",
                              style: context.headline3.copyWith(
                                fontSize: 16,
                              ),
                            ),
                            8.heightSizing,
                            Column(
                              children: education
                                  .map(
                                    (edu) => Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
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
                                  )
                                  .toList(),
                            ),
                            16.heightSizing,
                          ],
                        );
                      }),
                      Builder(builder: (_) {
                        if (languages.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomText(
                              data: "Languages",
                              style: context.headline3.copyWith(
                                fontSize: 16,
                              ),
                            ),
                            8.heightSizing,
                            Column(
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
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                            16.heightSizing,
                          ],
                        );
                      }),
                      Builder(builder: (_) {
                        if (skills.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomText(
                              data: "Skills",
                              style: context.headline3.copyWith(
                                fontSize: 16,
                              ),
                            ),
                            8.heightSizing,
                            Column(
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
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                            16.heightSizing,
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: top - context.height * .01,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                opacity: top < (kToolbarHeight + 50) ? 0 : 1,
                child: top < (kToolbarHeight + 50)
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          height: 120,
                          width: 120,
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
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
