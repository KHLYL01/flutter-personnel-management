import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:personnel_management/feature/emp_holiday/presentation/controllers/emp_holiday_controller.dart';
import 'package:pluto_grid/pluto_grid.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../data/model/emp_holiday_model.dart';
import '../../data/repository/emp_holiday_repository.dart';

class EmpHolidaySearchController extends GetxController {
  final EmpHolidayRepository _repository;

  EmpHolidaySearchController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<EmpHolidaySearchModel> empHolidays = <EmpHolidaySearchModel>[].obs;

  final TextEditingController empId = TextEditingController();
  final TextEditingController empName = TextEditingController();
  final TextEditingController cardId = TextEditingController();
  final TextEditingController name = TextEditingController();
  // final TextEditingController empType = TextEditingController();
  final TextEditingController holidayTypeId = TextEditingController();
  final TextEditingController holidayType = TextEditingController();

  final List<String> empTypeList = [
    "",
    "موظف",
    "مستخدم",
    "عامل بند اجور",
    "عامل أجنبي",
    "عامل نظافة - عقد",
  ];

  RxString empType = ''.obs;

  void onChangedEmpType(String? value) {
    empType(value!);
  }

  Future<void> findAll() async {
    isLoading(true);
    messageError("");
    final data = await _repository.search(
      name: name.text,
      cardId: cardId.text,
      empId: empId.text != "" ? int.parse(empId.text) : null,
      empType: empType.value,
      holidayType:
          holidayTypeId.text != "" ? int.parse(holidayTypeId.text) : null,
    );
    data.fold((l) => messageError(l.eerMessage), (r) => empHolidays(r));
    isLoading(false);
  }

  Future<void> findById(int id) async {
    isLoading(true);
    messageError("");
    final data = await _repository.findById(id);
    data.fold((l) => messageError(l.eerMessage),
        (r) => Get.find<EmpHolidayController>().fillControllers(r));
    isLoading(false);
  }

  void clearControllers() {
    empId.clear();
    empName.clear();
    name.clear();
    cardId.clear();
    empType('');
    holidayTypeId.clear();
    holidayType.clear();
  }

  // حل مبدأي
  Future<int> getId() async {
    int max = 0;
    await findAll();
    for (EmpHolidaySearchModel m in empHolidays) {
      if (m.id! > max) {
        max = m.id!;
      }
    }
    return max + 1;
  }
}
