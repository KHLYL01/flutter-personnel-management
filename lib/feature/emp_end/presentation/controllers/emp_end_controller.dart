import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/feature/emp_end/presentation/controllers/emp_end_search_controller.dart';

import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../data/model/emp_end_model.dart';
import '../../data/repository/emp_end_repository.dart';

class EmpEndController extends GetxController {
  final EmpEndRepository _repository;

  EmpEndController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  final TextEditingController id = TextEditingController();
  final TextEditingController decisionNumber = TextEditingController();
  final TextEditingController decisionDate = TextEditingController();
  final TextEditingController empId = TextEditingController();
  final TextEditingController empName = TextEditingController();
  final TextEditingController draga = TextEditingController();
  final TextEditingController salary = TextEditingController();
  final TextEditingController statusCardNumber = TextEditingController();
  final TextEditingController job = TextEditingController();
  final TextEditingController fia = TextEditingController();
  final TextEditingController cardId = TextEditingController();
  final TextEditingController empType = TextEditingController();
  final TextEditingController endDate = TextEditingController();
  final TextEditingController days = TextEditingController();
  final TextEditingController birthDate = TextEditingController();
  final TextEditingController age = TextEditingController(text: 0.toString());

  var isPicture = false.obs;
  var salaryFor4Months = false.obs;
  var salaryFor6Months = false.obs;
  var selectedRadioListTileValue = 'تقاعد نظامي'.obs;
  void toggleCheckBoxValue(var variable) {
    variable.value = !variable.value;
  }

  onChangePicture() {
    toggleCheckBoxValue(isPicture);
  }

  onChangeSalaryFor4Months() {
    toggleCheckBoxValue(salaryFor4Months);
  }

  onChangeSalaryFor6Months() {
    toggleCheckBoxValue(salaryFor6Months);
  }

  updateRadioListTileValue(value) {
    selectedRadioListTileValue.value = value;
    if (value != "تقاعد مبكر") {
      age.text = 0.toString();
      birthDate.clear();
    }
  }

  Future<void> save() async {
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      EmpEndModel(
        id: id.text != ""
            ? int.parse(id.text)
            : await Get.find<EmpEndSearchController>().getId(),
        qrarId: decisionNumber.text,
        qrarDate: decisionDate.text,
        empId: empId.text == "" ? null : int.parse(empId.text),
        days: days.text,
        endDate: endDate.text,
        birthDate: birthDate.text,
        age: int.parse(age.text),
        reward: salaryFor4Months.value ? 1 : 0,
        reward1: salaryFor6Months.value ? 1 : 0,
        taqa7d: selectedRadioListTileValue.value == 'تقاعد نظامي'
            ? 0
            : selectedRadioListTileValue.value == 'تقاعد مبكر'
                ? 1
                : 2,
      ),
    );
    data.fold((l) => messageError(l.eerMessage), (r) => fillControllers(r));
    isLoading(false);
    if (messageError.isEmpty) {
      Get.find<EmpEndSearchController>().findAll();
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
      Get.find<EmpEndSearchController>().findAll();
      return;
    }
    customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  }

  void clearControllers() {
    id.clear();
    decisionNumber.clear();
    decisionDate.clear();
    empId.clear();
    empName.clear();
    draga.clear();
    salary.clear();
    statusCardNumber.clear();
    job.clear();
    fia.clear();
    cardId.clear();
    empType.clear();
    endDate.clear();
    days.clear();
    birthDate.clear();
    age.text = 0.toString();
    selectedRadioListTileValue("تقاعد نظامي");
    salaryFor4Months(false);
    salaryFor6Months(false);
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

  void fillControllers(EmpEndModel r) {
    id.text = r.id.toString();
    decisionNumber.text = r.qrarId.toString();
    decisionDate.text = r.qrarDate.toString();
    empId.text = r.empId.toString();
    // empName.text = r.toString();
    // draga.text = r.toString();
    // salary.text = r.toString();
    // statusCardNumber.text = r.toString();
    // job.text = r.toString();
    // fia.text = r.toString();
    // cardId.text = r.toString();
    // empType.text = r.toString();
    endDate.text = r.endDate.toString();
    days.text = r.days.toString();
    birthDate.text = r.birthDate.toString();
    age.text = r.age.toString();
    selectedRadioListTileValue(r.taqa7d == 0
        ? "تقاعد نظامي"
        : r.taqa7d == 1
            ? "تقاعد مبكر"
            : "تقاعد الوفاه");
    salaryFor4Months(r.reward == 1);
    salaryFor6Months(r.reward1 == 1);
  }
}
