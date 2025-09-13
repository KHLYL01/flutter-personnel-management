import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/int_extension.dart';
import 'package:personnel_management/feature/emp_holiday/data/repository/emp_holiday_type_repository.dart';
import 'package:personnel_management/feature/emp_holiday/presentation/controllers/emp_holiday_search_controller.dart';
import 'package:personnel_management/feature/emp_holiday/presentation/controllers/emp_holiday_tamdeed_controller.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../../../core/utils/helper_method.dart';
import '../../data/model/emp_holiday_model.dart';
import '../../data/repository/emp_holiday_repository.dart';

class EmpHolidayController extends GetxController {
  final EmpHolidayRepository _repository;
  final EmpHolidayTypeRepository _typeRepository;

  EmpHolidayController(this._repository, this._typeRepository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  final TextEditingController id = TextEditingController();
  final TextEditingController empId = TextEditingController();
  final TextEditingController empName = TextEditingController();
  final TextEditingController mrtaba = TextEditingController();
  final TextEditingController draga = TextEditingController();
  final TextEditingController salary = TextEditingController();
  final TextEditingController naqlBadal = TextEditingController();
  final TextEditingController holidayType = TextEditingController();
  final TextEditingController holidayTypeName = TextEditingController();
  final TextEditingController startDate = TextEditingController();
  final TextEditingController endDate = TextEditingController();
  final TextEditingController requestDate = TextEditingController();
  final TextEditingController period =
      TextEditingController(text: 0.toString());
  final TextEditingController address = TextEditingController();
  final TextEditingController notesForPrint = TextEditingController();
  final TextEditingController boss = TextEditingController();
  final TextEditingController bossJob = TextEditingController();
  final TextEditingController qrarId = TextEditingController();
  final TextEditingController qrarDate = TextEditingController();
  final TextEditingController istehqaqDate = TextEditingController();
  final TextEditingController eligibilityStartDate = TextEditingController();
  final TextEditingController eligibilityEndDate = TextEditingController();
  final TextEditingController badeel = TextEditingController();
  final TextEditingController fileNo = TextEditingController();
  final TextEditingController forr = TextEditingController();
  final TextEditingController tepyNo = TextEditingController();
  final TextEditingController tepyDate = TextEditingController();
  final TextEditingController hospital = TextEditingController();
  final TextEditingController inputDate = TextEditingController();
  final TextEditingController separationDate = TextEditingController();
  final TextEditingController edara = TextEditingController();
  RxString sarf = 'لا أرغب بصرف راتبها مقدما'.obs;
  final List<String> sarfRatebIgazat = [
    'لا أرغب بصرف راتبها مقدما',
    'أرغب بصرف راتبها مقدما'
  ];
  var isPicture = false.obs;

// مش معروف لاي حقل
  var nadeb = false.obs;
//
  var etemad = false.obs;
  var cancel = false.obs;
  var mostahaka = false.obs;
  var directBoss = false.obs;
  var tamdeedIgazahAccept = false.obs;

  void toggleCheckBoxValue(var variable) {
    variable.value = !variable.value;
  }

  onChangPicture() {
    toggleCheckBoxValue(isPicture);
  }

  onChangeEtemad() {
    toggleCheckBoxValue(etemad);
  }

  onChangeCancel() {
    toggleCheckBoxValue(cancel);
  }

  onChangNadeb() {
    toggleCheckBoxValue(nadeb);
  }

  onChangeDirectBoss() {
    toggleCheckBoxValue(directBoss);
  }

  onChangeTamdeedIgazahAccept() {
    toggleCheckBoxValue(tamdeedIgazahAccept);
  }

  onChangeMostahaka() {
    toggleCheckBoxValue(mostahaka);
  }

  void onChangeSarfRatebIgazah(value) {
    sarf(value);
  }

  Future<void> save() async {
    if (empId.text == "") {
      customSnackBar(title: "خطأ", message: 'يرجى اختيار موظف', isDone: false);
      return;
    }
    if (holidayType.text == "") {
      customSnackBar(
          title: "خطأ", message: 'يرجى اختيار نوع الإجازة', isDone: false);
      return;
    }
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      EmpHolidayModel(
        id: id.text != ""
            ? int.parse(id.text)
            : await Get.find<EmpHolidaySearchController>().getId(),
        qrarId: qrarId.text,
        qrarDateString: qrarDate.text,
        startDateString: startDate.text,
        endDateString: endDate.text,
        requestDateString: requestDate.text,
        holidayType:
            holidayType.text == "" ? null : int.parse(holidayType.text),
        period: double.parse(period.text),
        address: address.text,
        badeel: badeel.text,
        forr: forr.text,
        sarf: sarf.value == 'لا أرغب بصرف راتبها مقدما' ? 0 : 1,
        boss: boss.text,
        bossJob: bossJob.text,
        eligibilityStartDate: eligibilityStartDate.text,
        eligibilityEndDate: eligibilityEndDate.text,
        fileNo: fileNo.text,
        tepyNo: tepyNo.text,
        tepyDate: tepyDate.text,
        hospital: hospital.text,
        inputDate: inputDate.text,
        separationDate: separationDate.text,
        empId: int.parse(empId.text),
        salary: salary.text == "" ? 0 : double.parse(salary.text),
        naqlBadal: naqlBadal.text == "" ? 0 : double.parse(naqlBadal.text),
        draga: draga.text == "" ? 0 : double.parse(draga.text),
        mrtaba: mrtaba.text,
        footer: notesForPrint.text,
        edara: edara.text,
        etemad: etemad.value ? 1 : 0,
        cancel: cancel.value ? 1 : 0,
        directBoss: directBoss.value ? 1 : 0,
        mostahaka: mostahaka.value ? 1 : 0,
        prev: tamdeedIgazahAccept.value ? 1 : 0,
      ),
    );
    data.fold((l) => messageError(l.eerMessage), (r) => fillControllers(r));
    isLoading(false);
    if (messageError.isEmpty) {
      Get.find<EmpHolidaySearchController>().findAll();
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
      Get.find<EmpHolidaySearchController>().findAll();
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

  void fillControllers(EmpHolidayModel r) async {
    id.text = r.id.getValue();
    empId.text = r.empId.getValue();
    mrtaba.text = r.mrtaba.getValue();
    draga.text = r.draga.getValue();
    salary.text = r.salary.getValue();
    naqlBadal.text = r.naqlBadal.getValue();
    holidayType.text = r.holidayType.getValue();
    startDate.text = r.startDateString.getValue();
    endDate.text = r.endDateString.getValue();
    requestDate.text = r.requestDateString.getValue();
    period.text = r.period.getValue();
    address.text = r.address.getValue();
    notesForPrint.text = r.footer.getValue();
    boss.text = r.boss.getValue();
    bossJob.text = r.bossJob.getValue();
    qrarId.text = r.qrarId.getValue();
    qrarDate.text = r.qrarDate.getValue();
    // istehqaqDate.text = r.mostahaka.getValue();
    eligibilityStartDate.text = r.eligibilityStartDate.getValue();
    eligibilityEndDate.text = r.eligibilityEndDate.getValue();
    badeel.text = r.badeel.getValue();
    fileNo.text = r.fileNo.getValue();
    forr.text = r.forr.getValue();
    tepyNo.text = r.tepyNo.getValue();
    tepyDate.text = r.tepyDate.getValue();
    hospital.text = r.hospital.getValue();
    inputDate.text = r.inputDate.getValue();
    separationDate.text = r.separationDate.getValue();
    edara.text = r.edara.getValue();
    sarf(r.sarf == 0 ? 'لا أرغب بصرف راتبها مقدما' : 'أرغب بصرف راتبها مقدما');
    etemad(r.etemad == 1);
    cancel(r.cancel == 1);
    mostahaka(r.mostahaka == 1);
    directBoss(r.directBoss == 1);
    tamdeedIgazahAccept(r.prev == 1);

    (await _typeRepository.findById(int.parse(holidayType.text)))
        .fold((l) => l, (r) => holidayTypeName.text = (r.name ?? ""));
  }

  clearControllers() async {
    empId.clear();
    empName.clear();
    mrtaba.clear();
    draga.clear();
    salary.clear();
    naqlBadal.clear();
    holidayType.clear();
    holidayTypeName.clear();
    startDate.text = nowHijriDate();
    endDate.text = nowHijriDate();
    requestDate.text = nowHijriDate();
    period.text = 0.toString();
    address.clear();
    notesForPrint.clear();
    boss.clear();
    bossJob.clear();
    qrarId.clear();
    qrarDate.text = nowHijriDate();
    istehqaqDate.text = nowHijriDate();
    eligibilityStartDate.text = nowHijriDate();
    eligibilityEndDate.text = nowHijriDate();
    badeel.clear();
    fileNo.clear();
    forr.clear();
    tepyNo.clear();
    tepyDate.text = nowHijriDate();
    hospital.clear();
    inputDate.text = nowHijriDate();
    separationDate.text = nowHijriDate();
    edara.clear();
    sarf('لا أرغب بصرف راتبها مقدما');
    etemad(false);
    cancel(false);
    mostahaka(false);
    directBoss(false);
    tamdeedIgazahAccept(false);

    Get.find<EmpHolidayTamdeedController>().clearAllData();
    id.text = (await Get.find<EmpHolidaySearchController>().getId()).toString();
    // Get.find<EmpHolidayTamdeedController>().holidaysId.text = id.text;
  }
}
