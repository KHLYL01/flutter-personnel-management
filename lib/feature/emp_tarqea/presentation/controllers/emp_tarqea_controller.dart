import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/int_extension.dart';
import 'package:personnel_management/feature/emp_eqrar/presentation/controllers/emp_eqrar_search_controller.dart';
import 'package:personnel_management/feature/employee/data/repository/employee_repository.dart';
import 'package:personnel_management/feature/tarmeez_jobs/data/repository/jobs_repository.dart';
import 'package:personnel_management/feature/tarmeez_parts/data/repository/parts_repository.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../../../core/utils/helper_method.dart';
import '../../data/model/emp_tarqea_model.dart';
import '../../data/repository/emp_tarqea_repository.dart';
import 'emp_tarqea_search_controller.dart';

class EmpTarqeaController extends GetxController {
  final EmpTarqeaRepository _repository;
  final EmployeeRepository _empRepository;
  final JobsRepository _jobsRepository;
  final PartsRepository _partsRepository;

  EmpTarqeaController(this._repository, this._jobsRepository,
      this._partsRepository, this._empRepository);

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
    if (empId.text == "") {
      customSnackBar(title: "خطأ", message: 'يرجى اختيار موظف', isDone: false);
      return;
    }
    if (oldJobId.text == "" || newJobId.text == "") {
      customSnackBar(
          title: "خطأ", message: 'يرجى اختيار المسمى الوظيفي', isDone: false);
      return;
    }

    if (oldFia.text == "" || newFia.text == "") {
      customSnackBar(
          title: "خطأ", message: 'يرجى اختيار المرتبة', isDone: false);
      return;
    }

    if (oldPartId.text == "" || newPartId.text == "") {
      customSnackBar(title: "خطأ", message: 'يرجى اختيار القسم', isDone: false);
      return;
    }
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
    data.fold((l) => messageError(l.eerMessage), (r) => fillControllers(r));
    isLoading(false);
    if (messageError.isEmpty) {
      Get.find<EmpTarqeaSearchController>().findAll();
      customSnackBar(title: 'تم', message: 'تمت العملية بنجاح');
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
      Get.find<EmpTarqeaSearchController>().findAll();
      customSnackBar(title: 'تم', message: 'تم الحذف بنجاح');
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

  void fillControllers(EmpTarqeaModel r) async {
    id.text = r.id.getValue();
    qrarId.text = r.qrarId.getValue();
    qrarDate.text = r.qrarDate.getValue();
    khetabId.text = r.khetabId.getValue();
    khetabDate.text = r.khetabDate.getValue();
    mosadakaId.text = r.mosadakaId.getValue();
    mosadakaDate.text = r.mosadakaDate.getValue();
    mahdarId.text = r.mahdarId.getValue();
    mahdarDate.text = r.mahdarDate.getValue();
    empId.text = r.empId.getValue();
    oldJobId.text = r.oldJobId.getValue();
    oldFia.text = r.oldFia.getValue();
    oldNo.text = r.oldNo.getValue();
    oldSymble.text = r.oldSymble.getValue();
    oldSalary.text = r.oldSalary.getValue();
    oldNaqlBadal.text = r.oldNaqlBadal.getValue();
    oldJobBadalat.text = "0";
    oldPartId.text = r.oldPartId.getValue();
    newJobId.text = r.newJobId.getValue();
    newFia.text = r.newFia.getValue();
    newNo.text = r.newNo.getValue();
    newSymble.text = r.newSymble.getValue();
    newSalary.text = r.newSalary.getValue();
    newNaqlBadal.text = r.newNaqlBadal.getValue();
    newJobBadalat.text = "0";
    newPartId.text = r.newPartId.getValue();
    percent.text = r.percent.getValue();
    mobasharaDate.text = r.mobasharaDate.getValue();
    mKhetabId.text = r.mKhetabId.getValue();
    mKhetabDate.text = r.mKhetabDate.getValue();
    percent.text = "0";
    mobasharaDay(r.mobasharaDay);

    (await _empRepository.findById(int.parse(empId.text)))
        .fold((l) => l, (r) => empName.text = r.name.getValue());

    (await _jobsRepository.findById(id: int.parse(oldJobId.text)))
        .fold((l) => l, (r) => oldJobName.text = r.name.getValue());
    (await _jobsRepository.findById(id: int.parse(newJobId.text)))
        .fold((l) => l, (r) => newJobName.text = r.name.getValue());

    (await _partsRepository.findById(id: int.parse(oldPartId.text)))
        .fold((l) => l, (r) => oldPartName.text = r.name.getValue());
    (await _partsRepository.findById(id: int.parse(newPartId.text)))
        .fold((l) => l, (r) => newPartName.text = r.name.getValue());
  }

  clearControllers() async {
    qrarId.clear();
    qrarDate.text = nowHijriDate();
    khetabId.clear();
    khetabDate.text = nowHijriDate();
    mosadakaId.clear();
    mosadakaDate.text = nowHijriDate();
    mahdarId.clear();
    mahdarDate.text = nowHijriDate();
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
    mobasharaDate.text = nowHijriDate();
    mKhetabId.clear();
    mKhetabDate.text = nowHijriDate();
    percent.text = "0";
    mobasharaDay("السبت");

    id.text = (await Get.find<EmpTarqeaSearchController>().getId()).toString();
  }
}
