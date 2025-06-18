import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:personnel_management/feature/employee/presentation/controllers/employee_controller.dart';
import 'package:pluto_grid/pluto_grid.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../data/model/employee_model.dart';
import '../../data/repository/employee_repository.dart';

class EmployeeSearchController extends GetxController {
  final EmployeeRepository _repository;

  EmployeeSearchController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<EmployeeSearchModel> employees = <EmployeeSearchModel>[].obs;

  get length => employees.length;

  final TextEditingController id = TextEditingController();
  final TextEditingController empName = TextEditingController();
  final TextEditingController cardId = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController jobId = TextEditingController();
  final TextEditingController jobName = TextEditingController();
  final TextEditingController partId = TextEditingController();
  final TextEditingController partName = TextEditingController();
  final TextEditingController fia = TextEditingController();
  final TextEditingController draga = TextEditingController();

  RxString jobState = "".obs;

  final List<String> jobStateList = [
    "",
    "مشغولة",
    "مشغولة ومتوقف عن العمل",
    "شاغرة",
  ];

  void onChangedJobState(String? value) {
    jobState(value!);
  }

  RxString empType = "".obs;

  final List<String> empTypeList = [
    "",
    "موظف",
    "مستخدم",
    "عامل بند إجور",
    "عامل أجنبي",
    "عامل نظافة - عقد"
  ];

  void onChangedJobWork(String? value) {
    empType(value!);
  }

  Future<void> findAll() async {
    isLoading(true);
    messageError("");
    final data = await _repository.search(
      id: id.text == "" ? null : int.parse(id.text),
      name: name.text,
      cardId: cardId.text,
      jobId: jobId.text == "" ? null : int.parse(jobId.text),
      partId: partId.text == "" ? null : int.parse(partId.text),
      fia: fia.text,
      draga: draga.text == "" ? null : double.parse(draga.text),
      jobState: jobState.value,
      empType: empType.value,
    );
    data.fold((l) => messageError(l.eerMessage), (r) => employees(r));
    isLoading(false);
  }

  Future<void> findById(int id) async {
    isLoading(true);
    messageError("");
    final data = await _repository.findById(id);
    data.fold((l) => messageError(l.eerMessage),
        (r) => Get.find<EmployeeController>().fillControllers(r));
    isLoading(false);
  }

  void clearControllers() {
    id.clear();
    empName.clear();
    name.clear();
    cardId.clear();
    jobId.clear();
    jobName.clear();
    jobState("");
    partId.clear();
    partName.clear();
    fia.clear();
    draga.clear();
    empType("");
  }

//  حل مبدأي
  Future<int> getId() async {
    int max = 0;
    await findAll();
    for (EmployeeSearchModel m in employees) {
      if (m.id! > max) {
        max = m.id!;
      }
    }
    return max + 1;
  }
}
