import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/constants/app_colors.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/functions/custom_snack_bar.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:personnel_management/core/widgets/custom_text_feild.dart';
import 'package:personnel_management/feature/pdf_viewer/presentation/controllers/pdf_viewer_controller.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../core/network/api_constants.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../user_signature/presentation/controllers/signature_controller.dart';
import '../../../user_signature/presentation/pages/add_signature_page.dart';

class PdfViewerPage extends StatelessWidget {
  PdfViewerPage({Key? key}) : super(key: key);

  final controller = Get.find<CustomPdfViewerController>();
  final controllerSign = Get.find<SignatureController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildAppBar(),
          Row(
            children: [
              _buildSideBar(),
              _buildPdf(),
            ],
          ).expanded(flex: 1),
        ],
      ),
    );
  }

  _buildAppBar() {
    return Container(
      color: AppColors.greyDark,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Get.back();
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            "عرض التقرير",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          const SizedBox(width: 32),
          _buildPdfArrows(),
          _buildSelectedSignature(),
          const Spacer(),
          TextButton(
            onPressed: () {
              controller.sharePdfFile();
            },
            child: const Text(
              "مشاركة",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: () {
              controller.printPdfFile();
            },
            child: const Text(
              "طباعة",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  _buildPdf() {
    return Column(
      children: [
        _buildPdfViewer(),
      ],
    ).expanded(flex: 7);
  }

  _buildSelectedSignature() {
    return Obx(
      () {
        if (controller.selectedImage.value == null) {
          return Container();
        }
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "التوقيع المحدد: ",
              style: TextStyle(
                color: Colors.white,
              ),
            ).paddingOnly(right: 8),
            const SizedBox(width: 4),
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Image.memory(controller.selectedImage.value!, height: 30),
            ),
            TextButton(
              onPressed: () {
                controller.selectedImage.value = null;
                controller.placedSignature.value = null;
              },
              child: const Text(
                "إلغاء",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            if (controller.placedSignature.value != null)
              TextButton(
                onPressed: () async {
                  await controller.saveSignatureOnPdf();
                  controller.selectedImage.value = null;
                  controller.placedSignature.value = null;
                },
                child: const Text(
                  "حفظ",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  _buildPdfArrows() {
    return Obx(
      () => Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "عدد الصفحات: ${controller.totalPage.value}",
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(width: 8),
          IconButton(
              onPressed: () {
                controller.sfPdfController.firstPage();
              },
              icon: const Icon(
                Icons.keyboard_double_arrow_right,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                controller.sfPdfController.previousPage();
              },
              icon: const Icon(
                Icons.keyboard_arrow_right,
                color: Colors.white,
              )),
          const SizedBox(width: 8),
          Text(
            controller.pageIndex.value.toString(),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {
              controller.sfPdfController.nextPage();
            },
            icon: const Icon(
              Icons.keyboard_arrow_left,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              controller.sfPdfController.lastPage();
            },
            icon: const Icon(
              Icons.keyboard_double_arrow_left,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  _buildPdfViewer() {
    return Obx(
      () {
        if (controller.loadSFPdf.value) {
          return const CustomProgressIndicator().center().expanded(flex: 1);
        }
        return GestureDetector(
          onTapDown: (details) {
            if (controller.selectedImage.value == null) {
              return;
            }
            controller.password.clear();
            Get.dialog(
              Dialog(
                child: SizedBox(
                  height: 180,
                  width: 300,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "تأكيد التوقيع",
                        style: TextStyle(fontSize: 20),
                      ).center(),
                      const SizedBox(height: 8),
                      CustomTextField(
                        label: "يرجى إدخال المعرف الشخصي",
                        controller: controller.password,
                        customHeight: 40,
                        customWidth: 200,
                        obscureText: true,
                        maxLine: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomButton(
                            text: "إلغاء",
                            onPressed: () {
                              Get.back();
                            },
                            height: 40,
                            width: 80,
                          ),
                          CustomButton(
                            text: "تأكيد",
                            onPressed: () {
                              if (Get.find<SignatureController>().checkPassword(
                                  controller.selectedImage.value!,
                                  controller.password.text)) {
                                controller.addSignature(details.globalPosition);
                                Get.back();
                                return;
                              }
                              customSnackBar(
                                  title: "تنبيه",
                                  message:
                                      "المعرف الشخصي غير صحيح, يرجى إعادة المحاولة");
                            },
                            height: 40,
                            width: 80,
                          ),
                          const SizedBox(width: 16),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ).center(),
                ),
              ),
            );
          },
          child: Stack(
            children: [
              _buildOriginalPdf(),
              _buildPositionSignature(),
            ],
          ),
        ).expanded(flex: 1);
      },
    );
  }

  _buildSideBar() {
    return Column(
      children: [
        const SizedBox(height: 8),
        const Text(
          "التوقيعات",
          style: TextStyle(fontSize: 18, color: AppColors.greyDark),
        ).center(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomButton(
              text: "إضافة توقيع",
              onPressed: () {
                Get.find<SignatureController>().clearControllers();
                Get.dialog(const AddSignaturePage());
              },
              height: 60,
              width: 200,
            ),
          ],
        ),
        const SizedBox(height: 8),
        _buildSignatureListView(),
        // _buildSelectedSignature(),
      ],
    ).expanded(flex: 1);
  }

  _buildSignatureListView() {
    return Obx(
      () {
        if (controllerSign.isLoading.value) {
          return const CustomProgressIndicator().center().expanded(flex: 1);
        }
        return ListView.builder(
          itemCount: controllerSign.length,
          itemBuilder: (context, index) {
            final item = controllerSign.signatures[index];
            return GestureDetector(
              onTap: () {
                controller.selectedImage.value = item.image;
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: Image.network(baseURL + (item.imageUrl ?? "")),
              ),
            );
          },
        ).expanded(flex: 1);
      },
    );
  }

  _buildOriginalPdf() {
    return SizedBox(
      width: Get.width / 8 * 7, // العرض المطلوب
      height: Get.height - 30, // الارتفاع المطلوب
      child: SfPdfViewer.memory(
        controller.pdfData.value!,
        controller: controller.sfPdfController,
        pageLayoutMode: PdfPageLayoutMode.continuous,
        enableTextSelection: false,
        onDocumentLoaded: (PdfDocumentLoadedDetails details) {
          controller.totalPage(details.document.pages.count);
          controller.pageIndex(1);
        },
        onPageChanged: (details) {
          controller.pageIndex(details.newPageNumber);
        },

        // child: PdfView(
        //   controller: controller.pdfController.value!,
        //   pageSnapping: false,
        //   physics: const NeverScrollableScrollPhysics(),
        //   backgroundDecoration: const BoxDecoration(color: Colors.grey),
        //   onDocumentLoaded: (document) {
        //     controller.totalPage(document.pagesCount);
        //     controller.pageIndex(1);
        //   },
        // ),
      ),
    );
  }

  _buildPositionSignature() {
    return Obx(
      () {
        if (controller.placedSignature.value == null) {
          return Container();
        }
        var item = controller.placedSignature.value!;
        return Positioned(
          left: item.offset.value.dx,
          top: item.offset.value.dy,
          child: GestureDetector(
            onPanUpdate: (details) =>
                controller.updateSignatureOffset(details.globalPosition),
            child: Column(
              children: [
                SizedBox(
                  width: item.width.value,
                  height: item.height.value,
                  child: Column(
                    children: [
                      Image.memory(
                        item.image,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
