import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../data/model/emp_entedab_det_model.dart';
import '../../data/repository/emp_entedab_det_repository.dart';

class EmpEntedabDetController extends GetxController {
  final EmpEntedabDetRepository _repository;

  EmpEntedabDetController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<EmpEntedabDetModel> entedabDets = RxList([]);

  final TextEditingController maxId = TextEditingController();
  final TextEditingController entedabId = TextEditingController();
  final TextEditingController empId = TextEditingController();
  final TextEditingController empName = TextEditingController();
  final TextEditingController fia = TextEditingController();
  final TextEditingController salary = TextEditingController(text: "0");
  final TextEditingController draga = TextEditingController(text: "0");
  final TextEditingController naqlBadal = TextEditingController(text: "0");
  final TextEditingController entedabBadal = TextEditingController(text: "0");
  final TextEditingController prev = TextEditingController(text: "0");
  final TextEditingController externalEntedab =
      TextEditingController(text: "0");

  int selectedDetId = 0;

  Future<void> getEntedabDetNextId() async {
    messageError('');
    final data = await _repository.getNextId();
    data.fold(
        (l) => messageError(l.eerMessage), (r) => maxId.text = r.toString());
  }

  Future<void> getEntedabDetByEntedabId(int entedabId) async {
    isLoading(true);
    messageError('');
    this.entedabId.text = entedabId.toString();
    final data = await _repository.findEmpEntedabDetById(entedabId);
    data.fold((l) => messageError(l.eerMessage), (r) {
      return entedabDets(r);
    });
    isLoading(false);
  }

  Future<void> save() async {
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      EmpEntedabDetModel(
        maxId: int.parse(maxId.text),
        entedabId: int.parse(entedabId.text),
        empId: int.parse(empId.text),
        prev: int.parse(prev.text),
        externalEntedab: double.parse(externalEntedab.text),
      ),
    );
    data.fold((l) => messageError(l.eerMessage), (r) => r);
    isLoading(false);
    if (messageError.isEmpty) {
      getEntedabDetByEntedabId(int.parse(entedabId.text));
      getEntedabDetNextId();
      customSnackBar(title: 'تم', message: 'تمت الإضافة بنجاح');
      return;
    }
    customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  }

  beforeSaveDet() {
    if (empId.text == "") {
      customSnackBar(title: "خطأ", message: 'يرجى اختيار موظف', isDone: false);
      return;
    }
    save();
  }

  Future<void> delete() async {
    isLoading(true);
    messageError("");
    final data = await _repository.delete(selectedDetId);
    data.fold((l) => messageError(l.eerMessage), (r) => r);
    isLoading(false);
    if (messageError.isEmpty) {
      getEntedabDetByEntedabId(int.parse(entedabId.text));
      customSnackBar(title: 'تم', message: 'تم الحذف بنجاح');
      return;
    }
    customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  }

  void confirmDelete({bool withGoBack = true}) async {
    if (selectedDetId == 0) {
      customSnackBar(title: 'خطأ', message: 'يرجى تحديد الموظف', isDone: false);
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

  void clearControllers() async {
    await getEntedabDetNextId();
    empId.clear();
    empName.clear();
    fia.clear();
    salary.text = "0";
    draga.text = "0";
    naqlBadal.text = "0";
    entedabBadal.text = "0";
    prev.text = "0";
    externalEntedab.text = "0";
  }

  void resetSelectedRow() {
    selectedDetId = 0;
  }

  void clearAllData() {
    clearControllers();
    entedabDets.clear();
  }

// void fillControllers(EmpEntedabDetResponseModel r) {}
}
