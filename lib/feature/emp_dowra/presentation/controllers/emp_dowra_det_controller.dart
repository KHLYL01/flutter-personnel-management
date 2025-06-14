import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../data/model/emp_dowra_det_model.dart';
import '../../data/repository/emp_dowra_det_repository.dart';

class EmpDowraDetController extends GetxController {
  final EmpDowraDetRepository _repository;

  EmpDowraDetController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<EmpDowraDetModel> dowraDets = RxList([]);

  final TextEditingController maxId = TextEditingController();
  final TextEditingController empId = TextEditingController();
  final TextEditingController dowraId = TextEditingController();

  final TextEditingController empName = TextEditingController();
  final TextEditingController salary = TextEditingController(text: "0");
  final TextEditingController draga = TextEditingController(text: "0");
  final TextEditingController fia = TextEditingController();
  final TextEditingController mokafaa = TextEditingController(text: "0");
  final TextEditingController badalEntidab = TextEditingController(text: "0");
  final TextEditingController badalTransfare = TextEditingController(text: "0");
  final TextEditingController ticketCost = TextEditingController(text: "0");

  int selectedDetId = 0;

  Future<void> getDowraDetNextId() async {
    messageError('');
    final data = await _repository.getNextId();
    data.fold(
        (l) => messageError(l.eerMessage), (r) => maxId.text = r.toString());
  }

  Future<void> getDowraDetByDowraId(int dowraId) async {
    isLoading(true);
    messageError('');
    this.dowraId.text = dowraId.toString();
    final data = await _repository.findEmpDowraDetById(dowraId);
    data.fold((l) => messageError(l.eerMessage), (r) {
      return dowraDets(r);
    });
    isLoading(false);
  }

  Future<void> save() async {
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      EmpDowraDetModel(
        maxId: int.parse(maxId.text),
        dowraId: int.parse(dowraId.text),
        empId: int.parse(empId.text),
        mokafaa: int.parse(mokafaa.text),
        badalEntidab: int.parse(badalEntidab.text),
        badalTransfare: int.parse(badalTransfare.text),
        ticketCost: int.parse(ticketCost.text),
        total: int.parse(mokafaa.text) +
            int.parse(badalEntidab.text) +
            int.parse(badalTransfare.text) +
            int.parse(ticketCost.text),
      ),
    );
    data.fold((l) => messageError(l.eerMessage), (r) => r);
    isLoading(false);
    if (messageError.isEmpty) {
      getDowraDetByDowraId(int.parse(dowraId.text));
      getDowraDetNextId();
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
      getDowraDetByDowraId(int.parse(dowraId.text));
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
    await getDowraDetNextId();
    empId.clear();
    empName.clear();
    fia.clear();
    salary.text = "0";
    draga.text = "0";
    mokafaa.text = "0";
    badalEntidab.text = "0";
    badalTransfare.text = "0";
    ticketCost.text = "0";
  }

  void resetSelectedRow() {
    selectedDetId = 0;
  }

  void clearAllData() {
    clearControllers();
    dowraDets.clear();
  }

// void fillControllers(EmpDowraDetResponseModel r) {}
}
