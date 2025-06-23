import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/int_extension.dart';
import 'package:personnel_management/feature/emp_end/presentation/controllers/emp_end_search_controller.dart';
import 'package:personnel_management/feature/employee/data/repository/employee_repository.dart';
import 'package:personnel_management/feature/tarmeez_jobs/data/repository/jobs_repository.dart';

import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../../../core/utils/helper_method.dart';
import '../../data/model/emp_end_model.dart';
import '../../data/repository/emp_end_repository.dart';

class EmpEndController extends GetxController {
  final EmpEndRepository _repository;
  final EmployeeRepository _empRepository;
  final JobsRepository _jobsRepository;

  EmpEndController(this._repository, this._empRepository, this._jobsRepository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  final TextEditingController id = TextEditingController();
  final TextEditingController decisionNumber = TextEditingController();
  final TextEditingController decisionDate = TextEditingController();
  final TextEditingController empId = TextEditingController();
  final TextEditingController empName = TextEditingController();
  final TextEditingController draga = TextEditingController();
  final TextEditingController salary = TextEditingController();
  final TextEditingController job = TextEditingController();
  final TextEditingController jobNumber = TextEditingController();
  final TextEditingController fia = TextEditingController();
  final TextEditingController cardId = TextEditingController();
  final TextEditingController empType = TextEditingController();
  final TextEditingController endDate = TextEditingController();
  final TextEditingController days = TextEditingController();
  final TextEditingController birthDate = TextEditingController();
  final TextEditingController age = TextEditingController(text: 0.toString());

  final TextEditingController nqalBadal = TextEditingController();

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
    if (empId.text == "") {
      customSnackBar(title: "خطأ", message: 'يرجى اختيار موظف', isDone: false);
      return;
    }

    isLoading(true);
    messageError("");
    final data = await _repository.save(
      EmpEndModel(
        id: id.text != ""
            ? int.parse(id.text)
            : await Get.find<EmpEndSearchController>().getId(),
        qrarId: decisionNumber.text,
        qrarDate: decisionDate.text,
        empId: int.parse(empId.text),
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
      Get.find<EmpEndSearchController>().findAll();
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

  void fillControllers(EmpEndModel r) async {
    id.text = r.id.getValue();
    decisionNumber.text = r.qrarId.getValue();
    decisionDate.text = r.qrarDate.getValue();
    empId.text = r.empId.getValue();
    endDate.text = r.endDate.getValue();
    days.text = r.days.getValue();
    birthDate.text = r.birthDate.getValue();
    age.text = r.age.getValue();
    selectedRadioListTileValue(r.taqa7d == 0
        ? "تقاعد نظامي"
        : r.taqa7d == 1
            ? "تقاعد مبكر"
            : "تقاعد الوفاه");
    salaryFor4Months(r.reward == 1);
    salaryFor6Months(r.reward1 == 1);

    late int jobId;

    (await _empRepository.findById(int.parse(empId.text))).fold(
      (l) => l,
      (r) {
        empName.text = r.name.getValue();
        jobId = r.jobId.getValue();
        cardId.text = r.cardId.getValue();
        draga.text = r.draga.getValue();
        salary.text = r.salary.getValue();
        fia.text = r.fia.getValue();
        empType.text = r.empType.getValue();
        jobNumber.text = r.jobNo.getValue();
        nqalBadal.text = r.naqlBadal.getValue();
      },
    );

    (await _jobsRepository.findById(id: jobId)).fold(
      (l) => l,
      (r) => job.text = r.name.getValue(),
    );
  }

  clearControllers() async {
    decisionNumber.clear();
    decisionDate.text = nowHijriDate();
    empId.clear();
    empName.clear();
    draga.clear();
    salary.clear();
    cardId.clear();
    job.clear();
    fia.clear();
    empType.clear();
    endDate.text = nowHijriDate();
    days.clear();
    birthDate.text = nowHijriDate();
    age.text = 0.toString();
    selectedRadioListTileValue("تقاعد نظامي");
    salaryFor4Months(false);
    salaryFor6Months(false);

    id.text = (await Get.find<EmpEndSearchController>().getId()).toString();
  }
}
