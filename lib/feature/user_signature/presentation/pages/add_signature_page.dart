import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_button.dart';
import 'package:personnel_management/core/widgets/custom_text_feild.dart';

import '../controllers/signature_controller.dart';

class AddSignaturePage extends StatelessWidget {
  const AddSignaturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignatureController>();

    return Dialog(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.white,
      child: SizedBox(
        width: 340,
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "إضافة توقيع",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ).center().paddingSymmetric(vertical: 16),
              Container(
                width: 128,
                height: 128,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: .2),
                ),
                child: controller.imageBytes.value != null
                    ? Image.memory(
                        controller.imageBytes.value!,
                        fit: BoxFit.cover,
                      ).paddingAll(.6)
                    : null,
              ),
              TextButton(
                onPressed: () => controller.pickImage(),
                child: const Text("اختر صورة"),
              ),
              CustomTextField(
                label: "الاسم",
                enabled: false,
                controller: controller.empName,
                customHeight: 40,
                customWidth: double.infinity,
              ),
              CustomTextField(
                label: "الوصف",
                controller: controller.content,
                customHeight: 40,
                customWidth: double.infinity,
              ),
              CustomTextField(
                label: "رقم التعريف الشخصي",
                controller: controller.password,
                customHeight: 40,
                customWidth: double.infinity,
                obscureText: true,
                maxLine: 1,
              ),
              const SizedBox(height: 20),
              Text(
                "يرجى رفع التوقيع من نوع (png) و حجم اقل من 2 ميجابايت",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.red.shade300,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    text: "إلغاء",
                    onPressed: () => Get.back(),
                    height: 60,
                    width: 200,
                  ),
                  CustomButton(
                    text: "حفظ",
                    onPressed: () => controller.save(),
                    height: 60,
                    width: 200,
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ).paddingSymmetric(horizontal: 20),
        ),
      ),
    );
  }
}
