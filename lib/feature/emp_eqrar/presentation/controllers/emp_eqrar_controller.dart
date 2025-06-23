import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/int_extension.dart';
import 'package:personnel_management/feature/emp_eqrar/presentation/controllers/emp_eqrar_search_controller.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../../../core/utils/helper_method.dart';
import '../../data/model/emp_eqrar_model.dart';
import '../../data/repository/emp_eqrar_repository.dart';

class EmpEqrarController extends GetxController {
  final EmpEqrarRepository _repository;

  EmpEqrarController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  final TextEditingController id = TextEditingController();
  final TextEditingController decisionDate = TextEditingController();
  final TextEditingController letterName = TextEditingController();
  final TextEditingController letterDate = TextEditingController();
  final TextEditingController letterNumber =
      TextEditingController(text: 0.toString());
  final TextEditingController decisionName = TextEditingController();
  final TextEditingController decisionPlace = TextEditingController();
  var isPicture = false.obs;
  void onChangedPicture() {
    isPicture.value = !isPicture.value;
  }

  Future<void> save() async {
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      EmpEqrarModel(
        id: id.text != ""
            ? int.parse(id.text)
            : await Get.find<EmpEqrarSearchController>().getId(),
        decisionDate: decisionDate.text,
        letterName: letterName.text,
        letterNumber: int.parse(letterNumber.text),
        letterDate: letterDate.text,
        decisionName: decisionName.text,
        decisionPlace: decisionPlace.text,
      ),
    );
    data.fold((l) => messageError(l.eerMessage), (r) => fillControllers(r));
    isLoading(false);
    if (messageError.isEmpty) {
      Get.find<EmpEqrarSearchController>().findAll();
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
      Get.find<EmpEqrarSearchController>().findAll();
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

  void fillControllers(EmpEqrarModel r) {
    id.text = r.id.getValue();
    decisionDate.text = r.decisionDate.getValue();
    letterName.text = r.letterName.getValue();
    letterNumber.text = r.letterNumber.getValue();
    letterDate.text = r.letterDate.getValue();
    decisionName.text = r.decisionName.getValue();
    decisionPlace.text = r.decisionPlace.getValue();
  }

  clearControllers() async {
    decisionDate.text = nowHijriDate();
    letterName.clear();
    letterNumber.text = 0.toString();
    letterDate.text = nowHijriDate();
    decisionName.clear();
    decisionPlace.clear();

    id.text = (await Get.find<EmpEqrarSearchController>().getId()).toString();
  }
}
