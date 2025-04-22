import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:personnel_management/feature/emp_eqrar/presentation/controllers/emp_eqrar_search_controller.dart';
import 'package:pluto_grid/pluto_grid.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../data/model/emp_tarqea_model.dart';
import '../../data/repository/emp_tarqea_repository.dart';
import 'emp_tarqea_search_controller.dart';

class EmpTarqeaController extends GetxController {
  final EmpTarqeaRepository _repository;

  EmpTarqeaController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  final TextEditingController id = TextEditingController();
  final TextEditingController qrarId = TextEditingController();
  final TextEditingController qrarDate = TextEditingController();
  final TextEditingController khetabId = TextEditingController();
  final TextEditingController khetabDate = TextEditingController();
  final TextEditingController mosadakaId = TextEditingController();
  final TextEditingController mosadakaDate = TextEditingController();
  final TextEditingController mahdarId = TextEditingController();
  final TextEditingController mahdarDate = TextEditingController();
  final TextEditingController empId = TextEditingController();
  final TextEditingController empName = TextEditingController();
  final TextEditingController statuesCardNumber = TextEditingController();

  //F ====> Field
  //from
  final TextEditingController oldJobId = TextEditingController();
  final TextEditingController oldJobName = TextEditingController();
  final TextEditingController oldFia = TextEditingController();
  final TextEditingController oldNo = TextEditingController();
  final TextEditingController oldSymble = TextEditingController();
  final TextEditingController oldSalary = TextEditingController();
  final TextEditingController oldNaqlBadal = TextEditingController();
  final TextEditingController oldJobBadalat = TextEditingController(text: "0");
  final TextEditingController oldPartId = TextEditingController();
  final TextEditingController oldPartName = TextEditingController();

  //to
  final TextEditingController newJobId = TextEditingController();
  final TextEditingController newJobName = TextEditingController();
  final TextEditingController newFia = TextEditingController();
  final TextEditingController newNo = TextEditingController();
  final TextEditingController newSymble = TextEditingController();
  final TextEditingController newSalary = TextEditingController();
  final TextEditingController newNaqlBadal = TextEditingController();
  final TextEditingController newJobBadalat = TextEditingController(text: "0");
  final TextEditingController newPartId = TextEditingController();
  final TextEditingController newPartName = TextEditingController();

  final TextEditingController percent = TextEditingController(text: "0");
  final TextEditingController mobasharaDate = TextEditingController();
  final TextEditingController mKhetabId = TextEditingController();
  final TextEditingController mKhetabDate = TextEditingController();
  RxString mobasharaDay = 'السبت'.obs;

  var isPicture = false.obs;
  onChangeMobasharahDay(value) {
    mobasharaDay(value);
  }

  onChangedPicture() {
    isPicture.value = !isPicture.value;
  }

  final List<String> mobasharahDays = [
    'السبت',
    'الأحد',
    'الأثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
  ];

  Future<void> save() async {
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      EmpTarqeaModel(
        id: id.text != ""
            ? int.parse(id.text)
            : await Get.find<EmpEqrarSearchController>().getId(),
        empId: int.parse(empId.text),
        khetabId: khetabId.text,
        khetabDate: khetabDate.text,
        qrarId: qrarId.text,
        qrarDate: qrarDate.text,
        mahdarId: mahdarId.text,
        mahdarDate: mahdarDate.text,
        mosadakaId: mosadakaId.text,
        mosadakaDate: mosadakaDate.text,
        mKhetabId: mKhetabId.text,
        mKhetabDate: mKhetabDate.text,
        mobasharaDate: mobasharaDate.text,
        mobasharaDay: mobasharaDay.value,
        oldJobId: int.parse(oldJobId.text),
        oldFia: oldFia.text,
        oldNo: int.parse(oldNo.text),
        oldSymble: oldSymble.text,
        oldSalary: double.parse(oldSalary.text),
        oldNaqlBadal: double.parse(oldNaqlBadal.text),
        oldJobBadalat: double.parse(oldJobBadalat.text),
        oldPartId: int.parse(oldPartId.text),
        newJobId: int.parse(newJobId.text),
        newFia: newFia.text,
        newNo: int.parse(newNo.text),
        newSymble: newSymble.text,
        newSalary: double.parse(newSalary.text),
        newNaqlBadal: double.parse(newNaqlBadal.text),
        newJobBadalat: double.parse(newJobBadalat.text),
        newPartId: int.parse(newPartId.text),
        percent: int.parse(percent.text),
      ),
    );
    data.fold((l) => messageError(l.eerMessage), (r) => r);
    isLoading(false);
    if (messageError.isEmpty) {
      Get.find<EmpTarqeaSearchController>().findAll();
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
      Get.back();
      Get.find<EmpTarqeaSearchController>().findAll();
      return;
    }
    customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  }

  void clearControllers() {
    id.clear();
    qrarId.clear();
    qrarDate.clear();
    khetabId.clear();
    khetabDate.clear();
    mosadakaId.clear();
    mosadakaDate.clear();
    mahdarId.clear();
    mahdarDate.clear();
    empId.clear();
    empName.clear();
    statuesCardNumber.clear();
    oldJobId.clear();
    oldJobName.clear();
    oldFia.clear();
    oldNo.clear();
    oldSymble.clear();
    oldSalary.clear();
    oldNaqlBadal.clear();
    oldJobBadalat.text = "0";
    oldPartId.clear();
    oldPartName.clear();
    newJobId.clear();
    newJobName.clear();
    newFia.clear();
    newNo.clear();
    newSymble.clear();
    newSalary.clear();
    newNaqlBadal.clear();
    newJobBadalat.text = "0";
    newPartId.clear();
    newPartName.clear();
    percent.clear();
    mobasharaDate.clear();
    mKhetabId.clear();
    mKhetabDate.clear();
    percent.text = "0";
    mobasharaDay("السبت");
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

  void fillControllers(EmpTarqeaModel r) {
    id.text = r.id.toString();
    qrarId.text = r.qrarId.toString();
    qrarDate.text = r.qrarDate.toString();
    khetabId.text = r.khetabId.toString();
    khetabDate.text = r.khetabDate.toString();
    mosadakaId.text = r.mosadakaId.toString();
    mosadakaDate.text = r.mosadakaDate.toString();
    mahdarId.text = r.mahdarId.toString();
    mahdarDate.text = r.mahdarDate.toString();
    empId.text = r.empId.toString();
    oldJobId.text = r.oldJobId.toString();
    oldFia.text = r.oldFia.toString();
    oldNo.text = r.oldNo.toString();
    oldSymble.text = r.oldSymble.toString();
    oldSalary.text = r.oldSalary.toString();
    oldNaqlBadal.text = r.oldNaqlBadal.toString();
    oldJobBadalat.text = "0";
    oldPartId.text = r.oldPartId.toString();
    newJobId.text = r.newJobId.toString();
    newFia.text = r.newFia.toString();
    newNo.text = r.newNo.toString();
    newSymble.text = r.newSymble.toString();
    newSalary.text = r.newSalary.toString();
    newNaqlBadal.text = r.newNaqlBadal.toString();
    newJobBadalat.text = "0";
    newPartId.text = r.newPartId.toString();
    percent.text = r.percent.toString();
    mobasharaDate.text = r.mobasharaDate.toString();
    mKhetabId.text = r.mKhetabId.toString();
    mKhetabDate.text = r.mKhetabDate.toString();
    percent.text = "0";
    mobasharaDay("السبت");
  }
}
