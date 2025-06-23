import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../../../core/utils/helper_method.dart';
import '../../data/model/emp_takleef_det_model.dart';
import '../../data/repository/emp_takleef_det_repository.dart';

class EmpTakleefDetController extends GetxController {
  final EmpTakleefDetRepository _repository;

  EmpTakleefDetController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<EmpTakleefDetModel> takleefDets = RxList([]);

  final TextEditingController id = TextEditingController();
  final TextEditingController takleefId = TextEditingController();
  final TextEditingController empId = TextEditingController();
  final TextEditingController empName = TextEditingController();
  final TextEditingController salary = TextEditingController(text: "0");
  final TextEditingController naqlBadal = TextEditingController(text: "0");
  final TextEditingController period = TextEditingController(text: "0");
  final TextEditingController datBegin = TextEditingController();
  final TextEditingController datEnd = TextEditingController();
  final TextEditingController empWork = TextEditingController();

  int selectedDetId = 0;

  Future<void> getTakleefDetNextId() async {
    messageError('');
    final data = await _repository.getNextId();
    data.fold((l) => messageError(l.eerMessage), (r) => id.text = r.toString());
  }

  Future<void> getTakleefDetByTakleefId(int takleefId) async {
    isLoading(true);
    messageError('');
    this.takleefId.text = takleefId.toString();
    final data = await _repository.findEmpTakleefDetById(takleefId);
    data.fold((l) => messageError(l.eerMessage), (r) => takleefDets(r));
    isLoading(false);
  }

  Future<void> save() async {
    if (empId.text == "") {
      customSnackBar(title: "خطأ", message: 'يرجى اختيار موظف', isDone: false);
      return;
    }
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      EmpTakleefDetModel(
        maxId: int.parse(id.text),
        empId: int.parse(empId.text),
        takleefId: int.parse(takleefId.text),
        datBegin: datBegin.text,
        datEnd: datEnd.text,
        period: double.parse(period.text),
        empWork: empWork.text,
      ),
    );
    data.fold((l) => messageError(l.eerMessage), (r) => r);
    isLoading(false);
    if (messageError.isEmpty) {
      getTakleefDetByTakleefId(int.parse(takleefId.text));
      getTakleefDetNextId();
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
      getTakleefDetByTakleefId(int.parse(takleefId.text));
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
    await getTakleefDetNextId();
    empId.clear();
    empName.clear();
    salary.text = "0";
    naqlBadal.text = "0";
    period.text = "0";
    datBegin.text = nowHijriDate();
    datEnd.text = nowHijriDate();
    empWork.clear();
  }

  void resetSelectedRow() {
    selectedDetId = 0;
  }

  void clearAllData() {
    clearControllers();
    takleefDets.clear();
  }

  // void fillControllers(EmpTakleefDetResponseModel r) {}
}
