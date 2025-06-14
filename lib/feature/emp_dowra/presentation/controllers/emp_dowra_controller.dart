import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/int_extension.dart';
import 'package:personnel_management/feature/emp_dowra/presentation/controllers/emp_dowra_search_controller.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../../../core/utils/helper_method.dart';
import '../../data/model/emp_dowra_model.dart';
import '../../data/repository/emp_dowra_repository.dart';
import 'emp_dowra_det_controller.dart';

class EmpDowraController extends GetxController {
  final EmpDowraRepository _repository;

  EmpDowraController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  final TextEditingController id = TextEditingController();
  final TextEditingController startDate = TextEditingController();
  final TextEditingController endDate = TextEditingController();
  final TextEditingController courseDays =
      TextEditingController(text: 0.toString());
  final TextEditingController extraDays = TextEditingController();
  final TextEditingController decisionNumber = TextEditingController();
  final TextEditingController decisionDate = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController footer = TextEditingController();

  Future<void> save() async {
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      EmpDowraModel(
        id: id.text != ""
            ? int.parse(id.text)
            : await Get.find<EmpDowraSearchController>().getId(),
        startDate: startDate.text,
        endDate: endDate.text,
        courseDays: int.parse(courseDays.text),
        decisionDate: decisionDate.text,
        decisionNumber: decisionNumber.text,
        extraDays: int.parse(extraDays.text),
        title: title.text,
        footer: footer.text,
      ),
    );
    data.fold((l) => messageError(l.eerMessage), (r) => fillControllers(r));
    isLoading(false);
    if (messageError.isEmpty) {
      Get.find<EmpDowraSearchController>().findAll();
      return;
    }
    customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  }

  Future<void> delete(int id) async {
    isLoading(true);
    messageError("");
    final data = await _repository.delete(id);
    data.fold((l) => messageError(l.eerMessage), (r) => r);
    isLoading(false);
    if (messageError.isEmpty) {
      Get.find<EmpDowraSearchController>().findAll();
      return;
    }
    customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  }

  void confirmDelete(int id, {bool withGoBack = true}) async {
    await alertDialog(
      title: 'تحذير',
      middleText: "هل تريد حذف الوظيفة بالفعل",
      onPressedConfirm: () {
        if (withGoBack) {
          Get.back();
        }
        delete(id);
      },
    );
  }

  void fillControllers(EmpDowraModel r) {
    id.text = r.id.getValue();
    startDate.text = r.startDate.getValue();
    endDate.text = r.endDate.getValue();
    courseDays.text = r.courseDays.getValue();
    extraDays.text = r.extraDays.getValue();
    decisionNumber.text = r.decisionNumber.getValue();
    decisionDate.text = r.decisionDate.getValue();
    title.text = r.title.getValue();
    footer.text = r.footer.getValue();
  }

  clearControllers() async {
    startDate.text = nowHijriDate();
    endDate.text = nowHijriDate();
    courseDays.text = 0.toString();
    extraDays.text = 0.toString();
    decisionNumber.clear();
    decisionDate.clear();
    title.clear();
    footer.clear();

    Get.find<EmpDowraDetController>().clearAllData();
    id.text = (await Get.find<EmpDowraSearchController>().getId()).toString();
    Get.find<EmpDowraDetController>().dowraId.text = id.text;
  }
}
