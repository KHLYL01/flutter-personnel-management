import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';

import '../../data/model/emp_takleef_model.dart';
import '../../data/repository/emp_takleef_repository.dart';
import 'emp_takleef_search_controller.dart';

class EmpTakleefController extends GetxController {
  final EmpTakleefRepository _repository;

  EmpTakleefController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  final TextEditingController id = TextEditingController();
  final TextEditingController place = TextEditingController();
  final TextEditingController qrarId = TextEditingController();
  final TextEditingController datQrar = TextEditingController();
  final TextEditingController datQrarGo = TextEditingController();
  final TextEditingController task = TextEditingController();
  final TextEditingController khetabId = TextEditingController();
  final TextEditingController datKhetab = TextEditingController();
  final TextEditingController datKhetabGo = TextEditingController();
  final TextEditingController datBegin = TextEditingController();
  final TextEditingController datBeginGo = TextEditingController();
  final TextEditingController datEnd = TextEditingController();
  final TextEditingController datEndGo = TextEditingController();
  final TextEditingController periodOthersDay =
      TextEditingController(text: "0");
  final TextEditingController hoursAvg = TextEditingController();

  final List<String> days = [
    "السبت",
    'الأحد',
    "الأثنين",
    "الثلاثاء",
    "الأربعاء",
    "الخميس",
  ];
  RxString day = 'السبت'.obs;

  onChangedDay(String? value) {
    day(value!);
  }

  var isEidFutur = false.obs;
  var isEidAdhaa = false.obs;
  var isPicture = false.obs;

  void onChangedEidFutur() {
    isEidFutur.value = !isEidFutur.value;
    if (isEidAdhaa.isTrue && isEidFutur.isTrue) {
      onChangedEidAdhaa();
    }
  }

  void onChangedEidAdhaa() {
    isEidAdhaa.value = !isEidAdhaa.value;
    if (isEidAdhaa.isTrue && isEidFutur.isTrue) {
      onChangedEidFutur();
    }
  }

  void onChangedPicture() {
    isPicture.value = !isPicture.value;
  }

  Future<void> save() async {
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      EmpTakleefModel(
        id: id.text != ""
            ? int.parse(id.text)
            : await Get.find<EmpTakleefSearchController>().getId(),
        qrarId: qrarId.text,
        datQrar: datQrar.text,
        datQrarGo: datQrarGo.text,
        place: place.text,
        task: task.text,
        periodOthersDay: int.parse(periodOthersDay.text),
        khetabId: khetabId.text,
        datKhetab: datKhetab.text,
        datKhetabGo: datKhetabGo.text,
        hoursAvg: double.tryParse(hoursAvg.text),
        day: day.value,
        datBegin: datBegin.text,
        datBeginGo: datBeginGo.text,
        datEnd: datEnd.text,
        datEndGo: datEndGo.text,
        inDate: DateTime.now().toIso8601String(),
      ),
    );
    data.fold((l) => messageError(l.eerMessage), (r) => fillControllers(r));
    isLoading(false);
    if (messageError.isEmpty) {
      Get.find<EmpTakleefSearchController>().findAll();
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
      Get.find<EmpTakleefSearchController>().findAll();
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

  void clearControllers() {
    id.clear();
    place.clear();
    qrarId.clear();
    datQrar.clear();
    datQrarGo.clear();
    task.clear();
    khetabId.clear();
    datKhetab.clear();
    datKhetabGo.clear();
    datBegin.clear();
    datBeginGo.clear();
    datEnd.clear();
    datEndGo.clear();
    periodOthersDay.clear();
    hoursAvg.clear();
    day('السبت');
    isEidFutur(false);
    isEidAdhaa(false);
    isPicture(false);
  }

  void fillControllers(EmpTakleefModel r) {
    id.text = r.id.toString();
    place.text = r.place.toString();
    qrarId.text = r.qrarId.toString();
    datQrar.text = r.datQrar.toString();
    datQrarGo.text = r.datQrarGo.toString().substring(0, 10);
    task.text = r.task.toString();
    khetabId.text = r.khetabId.toString();
    datKhetab.text = r.datKhetab.toString();
    datKhetabGo.text = r.datKhetabGo.toString().substring(0, 10);
    datBegin.text = r.datBegin.toString();
    datBeginGo.text = r.datBeginGo.toString().substring(0, 10);
    datEnd.text = r.datEnd.toString();
    datEndGo.text = r.datEndGo.toString().substring(0, 10);
    periodOthersDay.text = r.periodOthersDay.toString();
    hoursAvg.text = r.hoursAvg.toString();
    day(r.day);
  }
}
