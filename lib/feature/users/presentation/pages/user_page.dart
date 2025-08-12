import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_dropdown_button.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';

import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../data/model/screen_permission.dart';
import '../controllers/user_controller.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserController>();
    double currentWidth = Get.width;
    double currentHeight = Get.height;

    return Scaffold(
      body: BaseScreen(
        widget: Obx(
          () {
            final grouped = <String, List<ScreenPermission>>{};
            for (var perm in controller.permissions) {
              grouped.putIfAbsent(perm.group, () => []).add(perm);
            }
            if (controller.isLoading.value) {
              return const CustomProgressIndicator();
            }
            return Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomTextField(
                          enabled: false,
                          controller: controller.id,
                          label: "مسلسل",
                          customHeight: 30,
                          customWidth: currentWidth / 6,
                        ).marginOnly(right: 20),
                        const SizedBox(width: 18),
                        CustomDropdownButton(
                          label: 'المستخدم',
                          list: controller.usersName,
                          item: controller.userName,
                          onChanged: controller.onChangeUserName,
                          width: currentWidth / 6,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CustomTextField(
                          controller: controller.username,
                          label: "رمز المستخدم",
                          customHeight: 30,
                          customWidth: currentWidth / 6,
                        ).marginOnly(right: 20),
                        CustomTextField(
                          controller: controller.password,
                          label: "كلمة المرور",
                          customHeight: 30,
                          customWidth: currentWidth / 6,
                        ).marginOnly(right: 20),
                      ],
                    ),
                    CustomTextField(
                      controller: controller.empName,
                      label: "اسم الموظف",
                      customHeight: 30,
                      customWidth: currentWidth / 2.85,
                    ).marginOnly(right: 20),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          text: 'إضافة جديدة',
                          onPressed: () => controller.clearController(),
                          height: 40,
                          width: 80,
                        ),
                        CustomButton(
                          text: 'حفظ',
                          onPressed: () => controller.save(),
                          height: 40,
                          width: 80,
                        ),
                        CustomButton(
                          text: 'حذف',
                          onPressed: () => controller.confirmDelete(),
                          height: 40,
                          width: 140,
                        ),
                      ],
                    ),
                  ],
                ).expanded(flex: 2),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 6),
                      child: Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('الكل',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Checkbox(
                                value: controller.canEnter.value,
                                onChanged: (val) =>
                                    controller.onEnterAll(val ?? false),
                              )
                            ],
                          ),
                          const SizedBox().expanded(flex: 3),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('الكل',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Checkbox(
                                value: controller.canSave.value,
                                onChanged: (val) =>
                                    controller.onSaveAll(val ?? false),
                              )
                            ],
                          ).paddingOnly(right: 54).expanded(flex: 1),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('الكل',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Checkbox(
                                value: controller.canEdit.value,
                                onChanged: (val) =>
                                    controller.onEditAll(val ?? false),
                              )
                            ],
                          ).paddingOnly(right: 54).expanded(flex: 1),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('الكل',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Checkbox(
                                value: controller.canDelete.value,
                                onChanged: (val) =>
                                    controller.onDeleteAll(val ?? false),
                              )
                            ],
                          ).paddingOnly(right: 54).expanded(flex: 1),
                        ],
                      ),
                    ),
                    ListView(
                      children: grouped.entries.map((entry) {
                        return Card(
                          color: Colors.transparent,
                          elevation: 0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          child: ExpansionTile(
                            title: Text(entry.key,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                child: Row(
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    const Text('اسم الشاشة',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))
                                        .expanded(flex: 3),
                                    const Text('إضافة',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))
                                        .paddingOnly(right: 54)
                                        .expanded(flex: 1),
                                    const Text('تعديل',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))
                                        .paddingOnly(right: 54)
                                        .expanded(flex: 1),
                                    const Text('حذف',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))
                                        .paddingOnly(right: 54)
                                        .expanded(flex: 1),
                                  ],
                                ),
                              ),
                              const Divider(),
                              ...entry.value.map((perm) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 4),
                                  child: Row(
                                    children: [
                                      Obx(() => Checkbox(
                                            value: perm.canEnter.value,
                                            onChanged: (val) => perm
                                                .canEnter.value = val ?? false,
                                          )),
                                      Text(perm.screenName,
                                              textDirection: TextDirection.rtl)
                                          .expanded(flex: 3),
                                      Obx(() => Checkbox(
                                            value: perm.canSave.value,
                                            onChanged: (val) => perm
                                                .canSave.value = val ?? false,
                                          )).expanded(flex: 1),
                                      Obx(() => Checkbox(
                                            value: perm.canEdit.value,
                                            onChanged: (val) => perm
                                                .canEdit.value = val ?? false,
                                          )).expanded(flex: 1),
                                      Obx(() => Checkbox(
                                            value: perm.canDelete.value,
                                            onChanged: (val) => perm
                                                .canDelete.value = val ?? false,
                                          )).expanded(flex: 1),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        ).paddingAll(2);
                      }).toList(),
                    ).expanded(flex: 1),
                  ],
                ).expanded(flex: 3),
              ],
            );
          },
        ),
      ),
    );
  }
}
