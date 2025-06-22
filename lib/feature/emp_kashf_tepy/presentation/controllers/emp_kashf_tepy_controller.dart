import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/int_extension.dart';
import 'package:personnel_management/feature/emp_kashf_tepy/presentation/controllers/emp_kashf_tepy_search_controller.dart';
import 'package:personnel_management/feature/employee/data/repository/employee_repository.dart';
import 'package:pluto_grid/pluto_grid.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../../../core/utils/helper_method.dart';
import '../../data/model/emp_kashf_tepy_model.dart';
import '../../data/repository/emp_kashf_tepy_repository.dart';

class EmpKashfTepyController extends GetxController {
  final EmpKashfTepyRepository _repository;
  final EmployeeRepository _employeeRepository;

  EmpKashfTepyController(this._repository, this._employeeRepository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  final TextEditingController id = TextEditingController();
  final TextEditingController empId = TextEditingController();
  final TextEditingController empName = TextEditingController();
  final TextEditingController wehdaName = TextEditingController();
  final TextEditingController notes = TextEditingController();
  final TextEditingController requestDate = TextEditingController();
  final TextEditingController endDate = TextEditingController();
  final List<String> units = ['مستشفى', 'مستوصف'];
  final List<String> statesOfEmployee = [
    'قائم بالعمل حتى تاريخه',
    'انقطع عن العمل من تاريخ',
  ];
  RxString wehdaType = "مستشفى".obs;
  RxString employeeStatus = "قائم بالعمل حتى تاريخه".obs;
  final TextEditingController cardId = TextEditingController();

  onChangedUnitType(value) {
    wehdaType(value);
  }

  onChangedEmployeeState(value) {
    employeeStatus(value);
  }

  var isPicture = false.obs;

  void onChangedPicture() {
    isPicture.value = !isPicture.value;
  }

  Future<void> save() async {
    if (empId.text == "") {
      customSnackBar(title: "خطأ", message: 'يرجى اختيار موظف', isDone: false);
      return;
    }
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      EmpKashfTepyModel(
        id: id.text != ''
            ? int.parse(id.text)
            : await Get.find<EmpKashfTepySearchController>().getId(),
        empId: int.parse(empId.text),
        notes: notes.text,
        employeeStatus: employeeStatus.value,
        wehdaName: wehdaName.text,
        wehdaType: wehdaType.value,
        requestDateString: requestDate.text,
        endDateString: endDate.text,
      ),
    );
    data.fold((l) => messageError(l.eerMessage), (r) => fillControllers(r));
    isLoading(false);
    if (messageError.isEmpty) {
      Get.find<EmpKashfTepySearchController>().findAll();
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
      Get.find<EmpKashfTepySearchController>().findAll();
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

  void fillControllers(EmpKashfTepyModel r) async {
    id.text = r.id.getValue();
    empId.text = r.empId.getValue();
    // empName.text = r..getValue();
    wehdaName.text = r.wehdaName.getValue();
    notes.text = r.notes.getValue();
    requestDate.text = r.requestDateString.getValue();
    endDate.text = r.endDateString.getValue();
    wehdaType(r.wehdaType);
    employeeStatus(r.employeeStatus);
    (await _employeeRepository.findById(int.parse(empId.text))).fold((l) => l,
        (r) {
      empName.text = r.name!;
      cardId.text = r.cardId!;
    });
  }

  clearControllers() async {
    empId.clear();
    empName.clear();
    wehdaName.clear();
    notes.clear();
    requestDate.text = nowHijriDate();
    endDate.text = nowHijriDate();
    wehdaType("مستشفى");
    employeeStatus("قائم بالعمل حتى تاريخه");

    id.text =
        (await Get.find<EmpKashfTepySearchController>().getId()).toString();
  }
}
