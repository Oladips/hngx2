import 'package:flutter/material.dart';
import 'package:hng_stage_2/component/model/skills.dart';
import 'package:hng_stage_2/component/widgets/custom_text.dart';
import 'package:hng_stage_2/utils/extension.dart';

import '../../../component/core/base_navigator.dart';
import '../../../component/widgets/custom_textfield.dart';

class AddSkill extends StatefulWidget {
  final Skill? skill;
  final List<Skill>? skillList;

  const AddSkill({
    super.key,
    this.skill,
    this.skillList,
  });

  @override
  State<AddSkill> createState() => _AddSkillState();
}

class _AddSkillState extends State<AddSkill> {
  Skill? skill;

  final skillFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  DateTime? startDate;
  DateTime? endDate;

  final skillController = TextEditingController();

  String? skillError;

  @override
  void initState() {
    super.initState();
    skill = widget.skill;
    if (skill != null) {
      skillController.text = skill!.skill ?? "";
    }
  }

  @override
  void dispose() {
    skillFocus.dispose();
    skillController.dispose();
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
                  data: "Add Skill",
                  style: context.headline2.copyWith(
                    fontSize: 16,
                  ),
                ),
                InkWell(
                  overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      BaseNavigator.pop(
                        Skill(
                          id: skill?.id ?? widget.skillList!.length + 1,
                          skill: skillController.text,
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
              focus: skillFocus,
              labelText: "Skill",
              hintText: "",
              filled: true,
              suffix: false,
              obscureText: false,
              errorText: skillError,
              controller: skillController,
              validator: (p0) {
                if (p0 == null || p0.trim().isEmpty) {
                  skillError = "Please enter your skill";
                  setState(() {});
                  return skillError;
                }

                skillError = null;
                setState(() {});
                return skillError;
              },
            ),
            24.heightSizing,
          ],
        ),
      ),
    );
  }
}
