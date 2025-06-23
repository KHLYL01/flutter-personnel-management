import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/int_extension.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../../../core/utils/helper_method.dart';
import '../../data/model/emp_mokhalfat_model.dart';
import '../../data/repository/emp_mokhalfat_repository.dart';
import 'emp_mokhalfat_det_controller.dart';
import 'emp_mokhalfat_search_controller.dart';

class EmpMokhalfatController extends GetxController {
  final EmpMokhalfatRepository _repository;

  EmpMokhalfatController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  final TextEditingController id = TextEditingController();
  final TextEditingController startDate = TextEditingController();
  final TextEditingController endDate = TextEditingController();
  final TextEditingController description = TextEditingController();
  RxString mokhalfaType = 'لفت نظر'.obs;
  final List<String> mokhalfaTypes = ["لفت نظر", 'انذار', 'حسم جزاء'];
  onChangedDissentType(value) {
    mokhalfaType(value);
  }

  var isPicture = false.obs;
  onChangedPicture() {
    isPicture.value = !isPicture.value;
  }

  Future<void> save() async {
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      EmpMokhalfatModel(
        id: id.text != ''
            ? int.parse(id.text)
            : await Get.find<EmpMokhalfatSearchController>().getId(),
        startDateString: startDate.text,
        endDateString: endDate.text,
        description: description.text,
        mokhalfaType: mokhalfaType.value,
      ),
    );
    data.fold((l) => messageError(l.eerMessage), (r) => fillControllers(r));
    isLoading(false);
    if (messageError.isEmpty) {
      Get.find<EmpMokhalfatSearchController>().findAll();
      customSnackBar(title: 'تم', message: 'تمت العملية بنجاح');
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
      Get.find<EmpMokhalfatSearchController>().findAll();
      customSnackBar(title: 'تم', message: 'تم الحذف بنجاح');
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

  void fillControllers(EmpMokhalfatModel r) {
    id.text = r.id.getValue();
    startDate.text = r.startDateString.getValue();
    endDate.text = r.endDateString.getValue();
    description.text = r.description.getValue();
    mokhalfaType(r.mokhalfaType);
  }

  clearControllers() async {
    startDate.text = nowHijriDate();
    endDate.text = nowHijriDate();
    description.clear();
    mokhalfaType('لفت نظر');

    Get.find<EmpMokhalfatDetController>().clearAllData();
    id.text =
        (await Get.find<EmpMokhalfatSearchController>().getId()).toString();
    Get.find<EmpMokhalfatDetController>().mokhalfaId.text = id.text;
  }
}
