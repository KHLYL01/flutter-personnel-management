import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/utils/helper_method.dart';
import 'package:personnel_management/feature/employee/data/model/mosaeer_salary_model.dart';
import '../../data/repository/employee_repository.dart';

class MosaeerSalaryController extends GetxController {
  final EmployeeRepository _repository;

  MosaeerSalaryController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<MosaeerSalaryModel> mosaeer = <MosaeerSalaryModel>[].obs;

  get length => mosaeer.length;

  final TextEditingController startDate =
      TextEditingController(text: nowHijriDate());
  final TextEditingController endDate =
      TextEditingController(text: nowHijriDate());

  RxString empType = "".obs;

  final List<String> empTypeList = [
    "",
    "موظف",
    "مستخدم",
    "عامل بند إجور",
    "موظف | مستخدم | عامل بند إجور",
    "عامل أجنبي",
    "عامل نظافة - عقد",
    "عامل بند إجور | عامل بند إجور غير سعودى"
  ];

  void onChangedJobWork(String? value) {
    empType(value!);
  }

  Future<void> getMosaeer() async {
    isLoading(true);
    messageError("");
    final data = await _repository.getMosaeer(
      empType: empType.value == "" ? null : empType.value,
      startDate: convertToDateTime(startDate.text).toIso8601String(),
      endDate: convertToDateTime(endDate.text).toIso8601String(),
    );
    data.fold((l) => messageError(l.eerMessage), (r) => mosaeer(r));
    isLoading(false);
  }

  void clearControllers() {
    startDate.text = nowHijriDate();
    endDate.text = nowHijriDate();
    empType("");
  }
}
