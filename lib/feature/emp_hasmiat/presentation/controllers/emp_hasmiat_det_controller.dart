import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../data/model/emp_hasmiat_det_model.dart';
import '../../data/repository/emp_hasmiat_det_repository.dart';

class EmpHasmiatDetController extends GetxController {
  final EmpHasmiatDetRepository _repository;

  EmpHasmiatDetController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<EmpHasmiatDetModel> hasmialDets = RxList([]);

  final TextEditingController maxId = TextEditingController();
  final TextEditingController hasmId = TextEditingController();
  final TextEditingController empId = TextEditingController();
  final TextEditingController empName = TextEditingController();
  final TextEditingController salary = TextEditingController(text: "0");
  final TextEditingController naqlBadal = TextEditingController(text: "0");
  final TextEditingController ghyab = TextEditingController(text: "0");
  final TextEditingController tagmee3 = TextEditingController(text: "0");
  final TextEditingController min = TextEditingController(text: "0");
  final TextEditingController gza = TextEditingController(text: "0");
  final TextEditingController notes = TextEditingController();

  int selectedDetId = 0;

  Future<void> getHasmiatDetNextId() async {
    messageError('');
    final data = await _repository.getNextId();
    data.fold(
        (l) => messageError(l.eerMessage), (r) => maxId.text = r.toString());
  }

  Future<void> getHasmiatDetByHasmiatId(int hasmiatId) async {
    isLoading(true);
    messageError('');
    hasmId.text = hasmiatId.toString();
    final data = await _repository.findEmpHasmiatDetById(hasmiatId);
    data.fold((l) => messageError(l.eerMessage), (r) => hasmialDets(r));
    isLoading(false);
  }

  Future<void> save() async {
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      EmpHasmiatDetModel(
        maxId: int.parse(maxId.text),
        hasmId: int.parse(hasmId.text),
        empId: int.parse(empId.text),
        min: min.text,
        tagmee3: double.parse(tagmee3.text),
        ghyab: double.parse(ghyab.text),
        gza: double.parse(gza.text),
        notes: notes.text,
      ),
    );
    data.fold((l) => messageError(l.eerMessage), (r) => r);
    isLoading(false);
    if (messageError.isEmpty) {
      getHasmiatDetByHasmiatId(int.parse(hasmId.text));
      getHasmiatDetNextId();
      customSnackBar(title: 'تم', message: 'تمت الإضافة بنجاح');
      return;
    }
    customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  }

  beforeSaveDet() {
    if (empId.text == "") {
      customSnackBar(title: "خطأ", message: 'يرجى اختيار موظف', isDone: false);
      return;
    }
    save();
  }

  Future<void> delete() async {
    isLoading(true);
    messageError("");
    final data = await _repository.delete(selectedDetId);
    data.fold((l) => messageError(l.eerMessage), (r) => r);
    isLoading(false);
    if (messageError.isEmpty) {
      getHasmiatDetByHasmiatId(int.parse(hasmId.text));
      customSnackBar(title: 'تم', message: 'تم الحذف بنجاح');
      return;
    }
    customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  }

  void confirmDelete({bool withGoBack = true}) async {
    if (selectedDetId == 0) {
      customSnackBar(title: 'خطأ', message: 'يرجى تحديد الموظف', isDone: false);
      return;
    }
    await alertDialog(
      title: 'تحذير',
      middleText: "هل تريد حذف الوظيفة بالفعل",
      onPressedConfirm: () {
        if (withGoBack) {
          Get.back();
        }
        delete();
      },
    );
  }

  void clearControllers() async {
    await getHasmiatDetNextId();
    empId.clear();
    empName.clear();
    salary.text = "0";
    naqlBadal.text = "0";
    ghyab.text = "0";
    tagmee3.text = "0";
    min.text = "0";
    gza.text = "0";
    notes.clear();
  }

  void resetSelectedRow() {
    selectedDetId = 0;
  }

  void clearAllData() {
    clearControllers();
    hasmialDets.clear();
  }

// void fillControllers(EmpHasmiatDetResponseModel r) {}
}
