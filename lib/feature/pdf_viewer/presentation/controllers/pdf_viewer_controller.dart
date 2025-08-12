import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:personnel_management/core/functions/custom_snack_bar.dart';
import 'package:printing/printing.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart' as sfpdf;

class PlacedSignature {
  final Uint8List image;
  final int pageIndex;
  Rx<Offset> offset;
  RxDouble width;
  RxDouble height;

  PlacedSignature({
    required this.image,
    required this.pageIndex,
    required Offset initialOffset,
    double width = 120,
    double height = 80,
  })  : offset = initialOffset.obs,
        width = width.obs,
        height = height.obs;
}

class CustomPdfViewerController extends GetxController {
  Rx<Uint8List?> pdfData = Rx(null);

  Rx<Uint8List?> selectedImage = Rx(null);
  Rx<PlacedSignature?> placedSignature = Rx(null);

  PdfViewerController sfPdfController = PdfViewerController();

  RxInt totalPage = 0.obs;
  RxInt pageIndex = 1.obs;

  RxBool loadSFPdf = false.obs;

  TextEditingController password = TextEditingController();

  void setPdfx(Uint8List pdfBytes) {
    // pdfController(null);
    // pdfController(pdfx.PdfController(
    //     document: pdfx.PdfDocument.openData(pdfData.value!)));
  }

  void addSignature(Offset offset) {
    if (selectedImage.value == null) {
      log("image is null");
      return;
    }
    log("image is found");
    // for centre image
    Offset centerOffset = Offset(offset.dx - 60, offset.dy - 70);
    placedSignature(
      PlacedSignature(
        image: selectedImage.value!,
        pageIndex: pageIndex.value - 1, // because start with 0
        initialOffset: centerOffset,
      ),
    );
    log("sfPdfScrolling: ${sfPdfController.scrollOffset}");
    log("${placedSignature.value!.offset.value}");
  }

  /// Updates the position of a signature based on a drag gesture.
  void updateSignatureOffset(Offset offset) {
    double w = placedSignature.value!.width.value;
    double h = placedSignature.value!.height.value;

    if (offset.dy < 30 + (h / 2) ||
        offset.dy > Get.height / 16 * 15 ||
        offset.dx > (Get.width / 7 * 6) ||
        offset.dx < (w / 2)) {
      return;
    }

    Offset centerOffset = Offset(offset.dx - (w / 2), offset.dy - 30 - (h / 2));
    placedSignature.value!.offset.value = centerOffset;
  }

  rotatePdf() async {
    sfpdf.PdfDocument pdf = sfpdf.PdfDocument(inputBytes: pdfData.value!);

    // تدوير كل الصفحات (أو صفحة محددة)
    for (int i = 0; i < pdf.pages.count; i++) {
      pdf.pages[i].rotation = sfpdf.PdfPageRotateAngle.rotateAngle270;
    }

    // حفظ المستند بعد التدوير
    pdfData.value = Uint8List.fromList(await pdf.save());
    pdf.dispose();
  }

  Future<void> saveSignatureOnPdf() async {
    loadSFPdf(true);
    if (pdfData.value == null || placedSignature.value == null) {
      customSnackBar(title: "تنبيه", message: "التقرير أو التوقيع غير متوفر");
      loadSFPdf(false);
      return;
    }

    sfpdf.PdfDocument document = sfpdf.PdfDocument(inputBytes: pdfData.value!);
    var signature = placedSignature.value!;

    sfpdf.PdfBitmap image = sfpdf.PdfBitmap(signature.image);

    sfpdf.PdfPage page = document.pages[signature.pageIndex];
    log("size: ${page.size}");

    if (page.rotation == sfpdf.PdfPageRotateAngle.rotateAngle270) {
      double width = signature.height.value * page.size.height / (955);
      double height =
          signature.width.value * page.size.width / (Get.width / 8 * 7);

      double left = (page.size.width -
          ((signature.offset.value.dy + sfPdfController.scrollOffset.dy % 955) *
              page.size.height /
              (Get.width / 8 * 7)) -
          height);

      double top =
          signature.offset.value.dx / (Get.width / 8 * 7) * page.size.height;

      page.graphics.translateTransform(left + (width / 2), top + (height / 2));

      page.graphics.rotateTransform(90);
      page.graphics
          .translateTransform(-(left + (width / 2)), -(top + (height / 2)));

      page.graphics.drawImage(
        image,
        Rect.fromLTWH(left, top, width, height),
      );
    } else {
      page.graphics.drawImage(
        image,
        Rect.fromLTWH(
          signature.offset.value.dx * page.size.width / (Get.width / 8 * 7),
          (signature.offset.value.dy + sfPdfController.scrollOffset.dy % 1900) *
              page.size.height /
              (1900),
          signature.width.value * page.size.width / (Get.width / 8 * 7),
          signature.height.value * page.size.height / (1900),
        ),
      );
    }
    pdfData.value = Uint8List.fromList(await document.save());
    document.dispose();
    loadSFPdf(false);
    log(sfPdfController.scrollOffset.toString());
  }

  Future<void> saveSignature() async {
    loadSFPdf(true);
    if (pdfData.value == null || placedSignature.value == null) {
      customSnackBar(title: "تنبيه", message: "التقرير أو التوقيع غير متوفر");
      return;
    }

    try {
      final pw.Document pdf = pw.Document();

      // قم بتحديد دقة عالية لتحويل الصورة، مثلاً 300 أو 600
      const double highResolutionDpi = 150;

      int i = 0;
      var signature = placedSignature.value!;
      await for (PdfRaster page
          in Printing.raster(pdfData.value!, dpi: highResolutionDpi)) {
        final image = await page.toPng();
        final pageFormat = PdfPageFormat(
          page.width.toDouble() / (150 / 72),
          page.height.toDouble() / (150 / 72),
          marginAll: 0,
        );

        if (i == signature.pageIndex) {
          final double currentVerticalOffset = sfPdfController.scrollOffset.dy;
          final Offset screenPosition = signature.offset.value;
          const double pdfViewHeight = 1900;
          final double viewPortX =
              (screenPosition.dx + (signature.width / 2)) * 7 / 8;
          final double viewPortY = screenPosition.dy + (signature.height / 2);
          final double pdfX = viewPortX;
          final double pdfY =
              (viewPortY + (currentVerticalOffset % pdfViewHeight));
          const double pixelsToPointsFactor = 150 / 72;

          log("height: ${Get.height}");
          log("width: ${Get.width}");

          pdf.addPage(
            pw.Page(
              pageTheme: pw.PageTheme(pageFormat: pageFormat),
              build: (pw.Context context) {
                return pw.Stack(
                  children: [
                    // عرض محتوى الصفحة الأصلية كصورة
                    pw.Image(pw.MemoryImage(image)),

                    // عرض التوقيع في الموضع المحدد
                    pw.Positioned(
                      // left: (((signature.offset.value.dx + 40) * 7 / 8) / pixelsToPointsFactor),
                      // top: ((signature.offset.value.dy - 44 + (sfPdfController.scrollOffset.dy % 1900)) / pixelsToPointsFactor),
                      left: (pdfX / pixelsToPointsFactor),
                      top: (pdfY / pixelsToPointsFactor),
                      child: pw.Image(
                        pw.MemoryImage(signature.image),
                        width: (signature.width.value / pixelsToPointsFactor),
                        height: (signature.height.value / pixelsToPointsFactor),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        } else {
          pdf.addPage(
            pw.Page(
              pageTheme: pw.PageTheme(pageFormat: pageFormat),
              build: (pw.Context context) {
                return pw.Stack(
                  children: [
                    // عرض محتوى الصفحة الأصلية كصورة
                    pw.Image(pw.MemoryImage(image)),
                  ],
                );
              },
            ),
          );
        }
        i++;
      }
      pdfData(await pdf.save());
    } catch (e) {
      log(e.toString());
      customSnackBar(title: "تنبيه", message: "التقرير أو التوقيع غير متوفر");
    }
    loadSFPdf(false);
  }

  void sharePdfFile() async {
    await Printing.sharePdf(bytes: pdfData.value!);
  }
}
