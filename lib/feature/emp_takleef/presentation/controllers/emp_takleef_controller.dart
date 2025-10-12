import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/int_extension.dart';
import 'package:personnel_management/core/utils/helper_method.dart';
import 'package:personnel_management/feature/emp_takleef/presentation/controllers/emp_takleef_det_controller.dart';

import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';

import '../../../actions/presentation/controllers/actions_controller.dart';
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
  final TextEditingController period = TextEditingController(text: "0");
  final TextEditingController hoursAvg = TextEditingController();

  final List<String> days = [
    "السبت",
    'الأحد',
    "الأثنين",
    "الثلاثاء",
    "الأربعاء",
    "الخميس",
    "الجمعة",
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
        datQrarGo: datQrarGo.text.replaceAll("/", "-"),
        place: place.text,
        task: task.text,
        periodOthersDay: int.parse(period.text),
        khetabId: khetabId.text,
        datKhetab: datKhetab.text,
        datKhetabGo: datKhetabGo.text.replaceAll("/", "-"),
        hoursAvg: double.tryParse(hoursAvg.text),
        day: day.value,
        datBegin: datBegin.text,
        datBeginGo: datBeginGo.text.replaceAll("/", "-"),
        datEnd: datEnd.text,
        datEndGo: datEndGo.text.replaceAll("/", "-"),
        inDate: DateTime.now().toIso8601String(),
      ),
    );
    data.fold((l) => messageError(l.eerMessage), (r) {
      if (id.text.isEmpty) {
        Get.find<ActionsController>().save(
            "حفظ خارج الدوام بإسم ${task.text} القسم ${place.text} المدة ${period.text} معدل الساعات ${hoursAvg.text} تاريخ البداية ${datBegin.text} تاريخ النهاية ${datEnd.text}");
      } else {
        Get.find<ActionsController>().save(
            "تعديل خارج الدوام بإسم ${task.text} القسم ${place.text} المدة ${period.text} معدل الساعات ${hoursAvg.text} تاريخ البداية ${datBegin.text} تاريخ النهاية ${datEnd.text}");
      }
      fillControllers(r);
    });
    isLoading(false);
    if (messageError.isEmpty) {
      Get.find<EmpTakleefSearchController>().findAll();
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
      Get.find<EmpTakleefSearchController>().findAll();
      customSnackBar(title: 'تم', message: 'تم الحذف بنجاح');
      Get.find<ActionsController>().save(
          "حذف خارج الدوام بإسم ${task.text} القسم ${place.text} المدة ${period.text} معدل الساعات ${hoursAvg.text} تاريخ البداية ${datBegin.text} تاريخ النهاية ${datEnd.text}");
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

  void fillControllers(EmpTakleefModel r) {
    id.text = r.id.getValue();
    place.text = r.place.getValue();
    qrarId.text = r.qrarId.getValue();
    datQrar.text = r.datQrar.getValue();
    datQrarGo.text =
        r.datQrarGo.getValue().substring(0, 10).replaceAll("-", "/");
    task.text = r.task.getValue();
    khetabId.text = r.khetabId.getValue();
    datKhetab.text = r.datKhetab.getValue();
    datKhetabGo.text =
        r.datKhetabGo.getValue().substring(0, 10).replaceAll("-", "/");
    datBegin.text = r.datBegin.getValue();
    datBeginGo.text =
        r.datBeginGo.getValue().substring(0, 10).replaceAll("-", "/");
    datEnd.text = r.datEnd.getValue();
    datEndGo.text = r.datEndGo.getValue().substring(0, 10).replaceAll("-", "/");
    period.text = r.periodOthersDay.getValue();
    hoursAvg.text = r.hoursAvg.getValue();
    day(r.day);
  }

  clearControllers() async {
    place.clear();
    qrarId.clear();
    datQrar.text = nowHijriDate();
    datQrarGo.text = nowDate();
    task.clear();
    khetabId.clear();
    datKhetab.text = nowHijriDate();
    datKhetabGo.text = nowDate();
    datBegin.text = nowHijriDate();
    datBeginGo.text = nowDate();
    datEnd.text = nowHijriDate();
    datEndGo.text = nowDate();
    period.clear();
    hoursAvg.clear();
    day('السبت');
    isEidFutur(false);
    isEidAdhaa(false);
    isPicture(false);

    Get.find<EmpTakleefDetController>().clearAllData();
    id.text = (await Get.find<EmpTakleefSearchController>().getId()).toString();
    Get.find<EmpTakleefDetController>().takleefId.text = id.text;
  }
}
