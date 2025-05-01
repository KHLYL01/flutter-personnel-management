import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../data/model/employee_model.dart';
import '../../data/repository/employee_repository.dart';

class EmployeeFindController extends GetxController {
  final EmployeeRepository _repository;

  EmployeeFindController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<EmployeeFindModel> findEmployees = <EmployeeFindModel>[].obs;

  get length => findEmployees.length;

  final TextEditingController id = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController cardId = TextEditingController();

  RxString empType = "".obs;

  final List<String> empTypeList = [
    "",
    "موظف",
    "مستخدم",
    "عامل بند اجور",
    "عامل أجنبي",
    "عامل نظافة - عقد"
  ];

  void onChangedJobWork(String? value) {
    empType(value!);
  }

  Future<void> findEmployee() async {
    isLoading(true);
    messageError("");
    final data = await _repository.find(
      id: id.text == "" ? null : int.parse(id.text),
      name: name.text,
      cardId: cardId.text,
      empType: empType.value,
    );
    data.fold((l) => messageError(l.eerMessage), (r) => findEmployees(r));
    isLoading(false);
  }

  void clearControllers() {
    id.clear();
    name.clear();
    cardId.clear();
    empType("");
  }
}
