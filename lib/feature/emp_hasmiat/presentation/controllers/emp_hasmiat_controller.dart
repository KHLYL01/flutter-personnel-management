import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/int_extension.dart';
import 'package:personnel_management/feature/emp_hasmiat/presentation/controllers/emp_hasmiat_search_controller.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../../../core/utils/helper_method.dart';
import '../../data/model/emp_hasmiat_model.dart';
import '../../data/repository/emp_hasmiat_repository.dart';
import 'emp_hasmiat_det_controller.dart';

class EmpHasmiatController extends GetxController {
  final EmpHasmiatRepository _repository;

  EmpHasmiatController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  final TextEditingController id = TextEditingController();
  final TextEditingController datBegin = TextEditingController();
  final TextEditingController datEnd = TextEditingController();
  final TextEditingController qrarId = TextEditingController();
  final TextEditingController datQrar = TextEditingController();
  final TextEditingController month1 = TextEditingController();
  final TextEditingController year1 = TextEditingController();
  final TextEditingController month2 = TextEditingController();
  final TextEditingController year2 = TextEditingController();
  final TextEditingController dependOn = TextEditingController();
  var isPicture = false.obs;
  var hasmType = 'حسم عن غياب'.obs;
  onChangedPicture() {
    isPicture.value = !isPicture.value;
  }

  updateRadioListTileValue(value) {
    hasmType.value = value;
  }

  Future<void> save() async {
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      EmpHasmiatModel(
        id: id.text != ""
            ? int.parse(id.text)
            : await Get.find<EmpHasmiatSearchController>().getId(),
        datBegin: datBegin.text,
        datEnd: datEnd.text,
        qrarId: qrarId.text,
        datQrar: datQrar.text,
        hasmType: hasmType.value,
        month1: month1.text,
        year1: year1.text,
        month2: month2.text,
        year2: year2.text,
        dependOn: dependOn.text,
      ),
    );
    data.fold((l) => messageError(l.eerMessage), (r) => fillControllers(r));
    isLoading(false);
    if (messageError.isEmpty) {
      Get.find<EmpHasmiatSearchController>().findAll();
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
      Get.find<EmpHasmiatSearchController>().findAll();
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

  void fillControllers(EmpHasmiatModel r) {
    id.text = r.id.getValue();
    datBegin.text = r.datBegin.getValue();
    datEnd.text = r.datEnd.getValue();
    qrarId.text = r.qrarId.getValue();
    datQrar.text = r.datQrar.getValue();
    month1.text = r.month1.getValue();
    year1.text = r.year1.getValue();
    month2.text = r.month2.getValue();
    year2.text = r.year2.getValue();
    dependOn.text = r.dependOn.getValue();
    hasmType(r.hasmType);
  }

  clearControllers() async {
    datBegin.text = nowHijriDate();
    datEnd.text = nowHijriDate();
    qrarId.clear();
    datQrar.text = nowHijriDate();
    month1.clear();
    year1.clear();
    month2.clear();
    year2.clear();
    dependOn.clear();
    hasmType('حسم عن غياب');

    Get.find<EmpHasmiatDetController>().clearAllData();
    id.text = (await Get.find<EmpHasmiatSearchController>().getId()).toString();
    Get.find<EmpHasmiatDetController>().hasmId.text = id.text;
  }
}
