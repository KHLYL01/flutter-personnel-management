import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/int_extension.dart';
import 'package:pluto_grid/src/model/pluto_cell.dart';

import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../../../core/utils/helper_method.dart';
import '../../data/model/emp_holiday_tamdeed_model.dart';
import '../../data/repository/emp_holiday_tamdeed_repository.dart';
import '../../data/repository/emp_holiday_type_repository.dart';

class EmpHolidayTamdeedController extends GetxController {
  final EmpHolidayTamdeedRepository _repository;
  final EmpHolidayTypeRepository _typeRepository;

  EmpHolidayTamdeedController(this._repository, this._typeRepository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<EmpHolidayTamdeedModel> empHolidayTamdeeds =
      <EmpHolidayTamdeedModel>[].obs;

  get length => empHolidayTamdeeds.length;

  final TextEditingController id = TextEditingController();
  final TextEditingController tamdeedPeriod = TextEditingController(text: "0");
  final TextEditingController tamdeedBegin = TextEditingController();
  final TextEditingController tamdeedEnd = TextEditingController();
  final TextEditingController tepyNo = TextEditingController();
  final TextEditingController tepyDate = TextEditingController();
  final TextEditingController hospital = TextEditingController();
  final TextEditingController holidayType =
      TextEditingController(text: "0"); // id
  final TextEditingController holidayTypeName =
      TextEditingController(text: "إعتيادية سنوى"); // id

  int holidaysId = 0;
  int selectedId = 0;

  Future<void> findAllByHolidaysId(int holidaysId) async {
    isLoading(true);
    messageError("");
    log("holidays: $holidaysId");
    final data = await _repository.findAllByHolidayTamdeedsId(holidaysId);
    data.fold((l) => messageError(l.eerMessage), (r) => empHolidayTamdeeds(r));
    isLoading(false);
    this.holidaysId = holidaysId;
  }

  // Future<void> getHolidayTamdeedNextId() async {
  //   messageError('');
  //   final data = await _repository.getNextHolidayTamdeedId();
  //   data.fold((l) => messageError(l.eerMessage), (r) => id.text = r.toString());
  // }

  Future<void> save() async {
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      EmpHolidayTamdeedModel(
        id: int.parse(id.text),
        holidaysId: holidaysId,
        hospital: hospital.text,
        holidayType: int.parse(holidayType.text),
        tamdeedBegin: tamdeedBegin.text,
        tamdeedEnd: tamdeedEnd.text,
        tamdeedPeriod: int.parse(tamdeedPeriod.text),
        tepyNo: tepyNo.text,
        tepyDate: tepyDate.text,
      ),
    );
    data.fold((l) => messageError(l.eerMessage), (r) => r);
    isLoading(false);
    if (messageError.isEmpty) {
      findAllByHolidaysId(holidaysId);
      id.text = (await getId()).toString();
      return;
    }
    customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  }

  Future<void> delete() async {
    isLoading(true);
    messageError("");
    final data = await _repository.delete(selectedId);
    data.fold((l) => messageError(l.eerMessage), (r) => r);
    isLoading(false);
    if (messageError.isEmpty) {
      findAllByHolidaysId(holidaysId);
      return;
    }
    customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  }

  void confirmDelete({bool withGoBack = true}) async {
    if (selectedId == 0) {
      customSnackBar(
          title: 'خطأ', message: 'يرجى تحديد التمديد', isDone: false);
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

  // حل مبدأي
  Future<int> getId() async {
    int max = 0;
    RxList<EmpHolidayTamdeedModel> list = RxList([]);
    (await _repository.findAll()).fold((l) => l, (r) => list(r));
    for (EmpHolidayTamdeedModel m in list) {
      if (m.id! > max) {
        max = m.id!;
      }
    }
    log("max id: ${max + 1}");
    return max + 1;
  }

  clearControllers() async {
    id.text = (await getId()).toString();
    tamdeedPeriod.text = "0";
    tamdeedBegin.text = nowHijriDate();
    tamdeedEnd.text = nowHijriDate();
    tepyNo.clear();
    tepyDate.text = nowHijriDate();
    hospital.clear();
    holidayType.text = "0";
    holidayTypeName.text = 'إعتيادية سنوى';
  }

  void clearAllData() {
    clearControllers();
    empHolidayTamdeeds.clear();
  }

  void fillControllers(Map<String, PlutoCell> cells) async {
    if (cells['id']?.value != null) {
      id.text = cells['id']!.value.toString();
    }

    if (cells['tamdeedPeriods']?.value != null) {
      tamdeedPeriod.text = cells['tamdeedPeriods']!.value.toString();
    }

    if (cells['tamdeedBegin']?.value != null) {
      tamdeedBegin.text = cells['tamdeedBegin']!.value.toString();
    }

    if (cells['tamdeedEnd']?.value != null) {
      tamdeedEnd.text = cells['tamdeedEnd']!.value.toString();
    }

    if (cells['tepyNo']?.value != null) {
      tepyNo.text = cells['tepyNo']!.value.toString();
    }

    if (cells['tepyDate']?.value != null) {
      tepyDate.text = cells['tepyDate']!.value.toString();
    }

    if (cells['hospital']?.value != null) {
      hospital.text = cells['hospital']!.value.toString();
    }

    if (cells['holidayType']?.value != null) {
      holidayType.text = cells['holidayType']!.value.toString();
      // Only try to get holiday type name if we have a valid number
      final type = int.tryParse(holidayType.text);
      if (type != null) {
        holidayTypeName.text = await getHolidayType(type);
      }
    }
  }

  Future<String> getHolidayType(int value) async {
    String name = "";
    (await _typeRepository.findById(value))
        .fold((l) => l, (r) => name = r.name.getValue());
    return name;
  }
}
