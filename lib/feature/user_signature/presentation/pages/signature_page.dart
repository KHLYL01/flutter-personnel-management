import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/network/api_constants.dart';
import 'package:personnel_management/core/widgets/custom_button.dart';
import 'package:personnel_management/core/widgets/custom_dropdown_button.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';

import '../controllers/signature_controller.dart';
import 'add_signature_page.dart';
import 'image_page.dart';

class SignaturePage extends StatelessWidget {
  const SignaturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignatureController>();

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "إدارة التوقيعات",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ).center().paddingSymmetric(vertical: 16),
          Obx(
            () => Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomDropdownButton(
                  label: '',
                  width: 200,
                  list: controller.usersEmpName,
                  item: controller.selectedUser,
                  onChanged: controller.onChangeUser,
                ),
                if (controller.selectedUser.value != "الكل")
                  CustomButton(
                    text: "إضافة توقيع",
                    onPressed: () {
                      controller.fillControllerAdmin();
                      Get.dialog(const AddSignaturePage());
                    },
                    height: 60,
                    width: 200,
                  ),
              ],
            ),
          ),
          Obx(
            () {
              if (controller.isLoading.value) {
                return const CustomProgressIndicator()
                    .center()
                    .expanded(flex: 1);
              }
              return ListView.builder(
                itemCount: controller.length,
                itemBuilder: (context, index) {
                  var item = controller.signatures[index];
                  return ListTile(
                    onTap: () => Get.to(
                      () => ImagePage(
                        image: item.image!,
                      ),
                    ),
                    title: Text(item.content ?? ''),
                    subtitle: Text(item.empName ?? ''),
                    leading: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.network(
                        baseURL + (item.imageUrl ?? ""),
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => controller.deleteById(item.id!),
                    ),
                  );
                },
              ).expanded(flex: 1);
            },
          ),
        ],
      ).paddingSymmetric(horizontal: 500),
    );
  }
}
