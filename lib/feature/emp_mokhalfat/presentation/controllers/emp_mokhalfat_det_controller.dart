import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../data/model/emp_mokhalfat_det_model.dart';
import '../../data/repository/emp_mokhalfat_det_repository.dart';

class EmpMokhalfatDetController extends GetxController {
  final EmpMokhalfatDetRepository _repository;

  EmpMokhalfatDetController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<EmpMokhalfatDetModel> mokhalfatDets = RxList([]);

  final TextEditingController maxId = TextEditingController();
  final TextEditingController mokhalfaId = TextEditingController();
  final TextEditingController empId = TextEditingController();
  final TextEditingController empName = TextEditingController();
  final TextEditingController gza = TextEditingController(text: "0");
  final TextEditingController salary = TextEditingController(text: "0");
  final TextEditingController fia = TextEditingController(text: "0");
  final TextEditingController draga = TextEditingController(text: "0");
  final TextEditingController naqlBadal = TextEditingController(text: "0");

  int selectedDetId = 0;

  Future<void> getMokhalfatDetNextId() async {
    messageError('');
    final data = await _repository.getNextId();
    data.fold(
        (l) => messageError(l.eerMessage), (r) => maxId.text = r.toString());
  }

  Future<void> getMokhalfatDetByMokhalfatId(int mokhalfaId) async {
    isLoading(true);
    messageError('');
    this.mokhalfaId.text = mokhalfaId.toString();
    final data = await _repository.findEmpMokhalfatDetById(mokhalfaId);
    data.fold((l) => messageError(l.eerMessage), (r) => mokhalfatDets(r));
    isLoading(false);
  }

  Future<void> save() async {
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      EmpMokhalfatDetModel(
        maxId: int.parse(maxId.text),
        mokhalfaId: int.parse(mokhalfaId.text),
        empId: int.parse(empId.text),
        gza: double.parse(gza.text),
      ),
    );
    data.fold((l) => messageError(l.eerMessage), (r) => r);
    isLoading(false);
    if (messageError.isEmpty) {
      getMokhalfatDetByMokhalfatId(int.parse(mokhalfaId.text));
      getMokhalfatDetNextId();
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
      getMokhalfatDetByMokhalfatId(int.parse(mokhalfaId.text));
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

  clearControllers() async {
    await getMokhalfatDetNextId();
    empId.clear();
    empName.clear();
    salary.text = "0";
    naqlBadal.text = "0";
    draga.text = "0";
    fia.text = "0";
    gza.text = "0";
  }

  void resetSelectedRow() {
    selectedDetId = 0;
  }

  void clearAllData() {
    clearControllers();
    mokhalfatDets.clear();
  }

  // void fillControllers(EmpMokhalfatDetResponseModel r) {}
}
