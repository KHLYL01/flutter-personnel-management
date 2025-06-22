import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/int_extension.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../../../core/utils/helper_method.dart';
import '../../data/model/emp_mobashra_model.dart';
import '../../data/repository/emp_mobashra_repository.dart';
import 'emp_mobashra_search_controller.dart';

class EmpMobashraController extends GetxController {
  final EmpMobashraRepository _repository;

  EmpMobashraController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  final TextEditingController id = TextEditingController();
  final TextEditingController empId = TextEditingController();
  final TextEditingController empName = TextEditingController();
  final TextEditingController mrtaba = TextEditingController();
  final TextEditingController draga = TextEditingController();
  final TextEditingController salary = TextEditingController();
  final TextEditingController naqlBadal = TextEditingController();
  final TextEditingController qrarId = TextEditingController();
  final TextEditingController qrarDate = TextEditingController();
  final TextEditingController no = TextEditingController();
  final TextEditingController date = TextEditingController();
  final TextEditingController holidayStartDate = TextEditingController();
  final TextEditingController mobashraDate = TextEditingController();
  final TextEditingController period =
      TextEditingController(text: 0.toString());
  final TextEditingController khetabDate = TextEditingController();
  final TextEditingController partBoss = TextEditingController();
  final TextEditingController endDate = TextEditingController();
  final TextEditingController days = TextEditingController(text: 0.toString());
  final TextEditingController forr = TextEditingController();
  final TextEditingController notes = TextEditingController();

  RxString day = 'السبت'.obs;
  var isPicture = false.obs;

  onChangedPicture() {
    isPicture.value = !isPicture.value;
  }

  void onChangeDay(value) {
    day(value);
  }

  final List<String> daysList = [
    'السبت',
    'الأحد',
    'الأثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
  ];

  Future<void> save() async {
    if (empId.text == "") {
      customSnackBar(title: "خطأ", message: 'يرجى اختيار موظف', isDone: false);
      return;
    }
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      EmpMobashraModel(
        id: id.text != ""
            ? int.parse(id.text)
            : await Get.find<EmpMobashraSearchController>().getId(),
        empId: empId.text == '' ? null : int.parse(empId.text),
        no: no.text,
        date: date.text,
        endDate: endDate.text,
        mobashraDate: mobashraDate.text,
        qrarId: qrarId.text,
        qrarDateString: qrarDate.text,
        holidayStartDate: holidayStartDate.text,
        period: double.parse(period.text),
        day: day.value,
        days: double.parse(days.text),
        partBoss: partBoss.text,
        khetabDate: khetabDate.text,
        forr: forr.text,
        notes: notes.text,
      ),
    );
    data.fold((l) => messageError(l.eerMessage), (r) => fillControllers(r));
    isLoading(false);
    if (messageError.isEmpty) {
      Get.find<EmpMobashraSearchController>().findAll();
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
      Get.find<EmpMobashraSearchController>().findAll();
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

  void fillControllers(EmpMobashraModel r) {
    id.text = r.id.getValue();
    empId.text = r.empId.getValue();
    qrarId.text = r.qrarId.getValue();
    qrarDate.text = r.qrarDate.getValue();
    no.text = r.no.getValue();
    date.text = r.date.getValue();
    holidayStartDate.text = r.holidayStartDate.getValue();
    mobashraDate.text = r.mobashraDate.getValue();
    khetabDate.text = r.khetabDate.getValue();
    partBoss.text = r.partBoss.getValue();
    endDate.text = r.endDate.getValue();
    forr.text = r.forr.getValue();
    notes.text = r.notes.getValue();

    days.text = r.days.getValue();
    period.text = r.period.getValue();
    day(r.day);
  }

  clearControllers() async {
    empId.clear();
    empName.clear();
    mrtaba.clear();
    draga.clear();
    salary.clear();
    naqlBadal.clear();
    qrarId.clear();
    qrarDate.text = nowHijriDate();
    no.clear();
    date.text = nowHijriDate();
    holidayStartDate.text = nowHijriDate();
    mobashraDate.text = nowHijriDate();
    khetabDate.text = nowHijriDate();
    partBoss.clear();
    endDate.text = nowHijriDate();
    forr.clear();
    notes.clear();
    days.text = 0.toString();
    period.text = 0.toString();
    day('السبت');

    id.text =
        (await Get.find<EmpMobashraSearchController>().getId()).toString();
  }
}
