import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../data/model/emp_overtime_model.dart';
import '../../data/repository/emp_overtime_repository.dart';
import 'emp_overtime_search_controller.dart';

class EmpOvertimeController extends GetxController {
  final EmpOvertimeRepository _repository;

  EmpOvertimeController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  final TextEditingController id = TextEditingController();
  final TextEditingController part = TextEditingController();
  final TextEditingController qararId = TextEditingController();
  final TextEditingController hijriQararDate = TextEditingController();
  final TextEditingController geoQararDate = TextEditingController();
  final TextEditingController mission = TextEditingController();
  final TextEditingController khitamNum = TextEditingController();
  final TextEditingController khitabDate = TextEditingController();
  final TextEditingController geoKhitabDate = TextEditingController();
  final TextEditingController hijriStartDateOvertime = TextEditingController();
  final TextEditingController geoStartDateOvertime = TextEditingController();
  final TextEditingController hijriEndDateOvertime = TextEditingController();
  final TextEditingController geoEndDateOvertime = TextEditingController();
  final TextEditingController dayNum = TextEditingController();
  final TextEditingController hoursAvg = TextEditingController();

  final List<String> days = [
    "السبت",
    'الأحد',
    "الأثنين",
    "الثلاثاء",
    "الأربعاء",
    "الخميس",
  ];
  RxString selectedDay = 'السبت'.obs;

  onChangedDay(String? value) {
    selectedDay(value!);
  }

  var isEidFutur = false.obs; // if false => isEidAdhaa = true
  var isPicture = false.obs;

  Future<void> save() async {
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      EmpOvertimeModel(
        id: id.text != ""
            ? int.parse(id.text)
            : await Get.find<EmpOvertimeSearchController>().getId(),
        day: selectedDay.value,
        hoursAvg: double.tryParse(hoursAvg.text),
        qrarId: qararId.text,
        place: part.text,
      ),
    );
    data.fold((l) => messageError(l.eerMessage), (r) => fillControllers(r));
    isLoading(false);
    if (messageError.isEmpty) {
      Get.find<EmpOvertimeSearchController>().findAll();
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
      Get.find<EmpOvertimeSearchController>().findAll();
      return;
    }
    customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  }

  void clearControllers() {}

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

  void fillControllers(EmpOvertimeModel r) {}
}
