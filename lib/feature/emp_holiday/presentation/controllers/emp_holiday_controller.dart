import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/int_extension.dart';
import 'package:personnel_management/feature/emp_holiday/data/repository/emp_holiday_type_repository.dart';
import 'package:personnel_management/feature/emp_holiday/presentation/controllers/emp_holiday_search_controller.dart';
import 'package:personnel_management/feature/emp_holiday/presentation/controllers/emp_holiday_tamdeed_controller.dart';
import 'package:personnel_management/feature/emp_holiday/presentation/controllers/emp_holiday_type_controller.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../../../core/utils/helper_method.dart';
import '../../../actions/presentation/controllers/actions_controller.dart';
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

  final TextEditingController dayDate =
      TextEditingController(text: nowHijriDate());
  final TextEditingController startWorkDate =
      TextEditingController(text: nowHijriDate());
  String empType = "";
  int takenHoliday = 0;
  int lblall = 0,
      lblhave = 0,
      lblremain = 0,
      lblallNew = 0,
      lblhaveNew = 0,
      lblremainNew = 0,
      lblallall = 0,
      lblhavehave = 0,
      lblremainremain = 0,
      lblmorahalhave = 0,
      lblmorahalremain = 0,
      lblMofaraqHave = 0,
      lblMofaraqRemain = 0;

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
    data.fold((l) => messageError(l.eerMessage), (r) {
      if (id.text.isEmpty) {
        Get.find<ActionsController>().save(
            "حفظ إجازة بإسم ${empName.text} نوع الإجازة ${holidayType.text} المدة ${period.text} تاريخ بداية الإجازة ${startDate.text}");
      } else {
        Get.find<ActionsController>().save(
            "تعديل إجازة بإسم ${empName.text} نوع الإجازة ${holidayType.text} المدة ${period.text} تاريخ بداية الإجازة ${startDate.text}");
      }

      fillControllers(r);
    });
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
      Get.find<ActionsController>().save(
          "حذف إجازة بإسم ${empName.text} نوع الإجازة ${holidayType.text} المدة ${period.text} تاريخ بداية الإجازة ${startDate.text}");
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

    // (await _typeRepository.findById(int.parse(holidayType.text)))
    //     .fold((l) => l, (r) => holidayTypeName.text = (r.name ?? ""));

    holidayTypeName.text = Get.find<EmpHolidayTypeController>()
        .getName(int.parse(holidayType.text));
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

    lblall = 0;
    lblhave = 0;
    lblremain = 0;
    lblallNew = 0;
    lblhaveNew = 0;
    lblremainNew = 0;
    lblallall = 0;
    lblhavehave = 0;
    lblremainremain = 0;
    lblmorahalhave = 0;
    lblmorahalremain = 0;
    lblMofaraqHave = 0;
    lblMofaraqRemain = 0;
  }

  Future<double> countHoliday(int empId, List<int> holidaysType,
      DateTime? fromDate, DateTime? toDate) async {
    String? fDate =
        fromDate?.toIso8601String().substring(0, 10).replaceAll("/", "-");
    String? tDate =
        toDate?.toIso8601String().substring(0, 10).replaceAll("/", "-");

    messageError('');
    double result = 0;
    final data = await _repository.count(empId, holidaysType, fDate, tDate);
    data.fold((l) => messageError(l.eerMessage), (r) => result = r);
    return result;
  }

  Future<double> countHolidayTamdeed(int empId, List<int> holidaysType,
      DateTime? fromDate, DateTime? toDate) async {
    String? fDate =
        fromDate?.toIso8601String().substring(0, 10).replaceAll("/", "-");
    String? tDate =
        toDate?.toIso8601String().substring(0, 10).replaceAll("/", "-");
    messageError('');
    double result = 0;
    final data =
        await _repository.countTamdeed(empId, holidaysType, tDate, fDate);
    data.fold((l) => messageError(l.eerMessage), (r) => result = r);
    return result;
  }

  Future<double> countHolidayMotfareqa(int empId, List<int> holidaysType,
      DateTime? fromDate, DateTime? toDate) async {
    String? fDate =
        fromDate?.toIso8601String().substring(0, 10).replaceAll("/", "-");
    String? tDate =
        toDate?.toIso8601String().substring(0, 10).replaceAll("/", "-");
    messageError('');
    double result = 0;
    final data =
        await _repository.countMotfareqa(empId, holidaysType, tDate, fDate);
    data.fold((l) => messageError(l.eerMessage), (r) => result = r);
    return result;
  }

  Future<double> countHolidayMorahal(
      int empId, List<int> holidaysType, String year) async {
    messageError('');
    double result = 0;
    final data = await _repository.countMorahal(empId, holidaysType, year);
    data.fold((l) => messageError(l.eerMessage), (r) => result = r);
    return result;
  }

  Future<void> calculateRaseed() async {
    if (empId.text.isNotEmpty) {
      lblall = 0;
      lblhave = 0;
      lblremain = 0;
      lblallNew = 0;
      lblhaveNew = 0;
      lblremainNew = 0;
      lblallall = 0;
      lblhavehave = 0;
      lblremainremain = 0;
      lblmorahalhave = 0;
      lblmorahalremain = 0;
      lblMofaraqHave = 0;
      lblMofaraqRemain = 0;

      int daysd = 0, daysb = 0, daysa = 0;
      double all1 = 0, all2 = 0, all3 = 0;
      double all = 0;

      //تاريخ بداية العمل قبل 1426/05/15
      if (dateCompare(startWorkDate.text, "1426/05/14") == 0) {
        daysd = daysbett(startWorkDate.text, "1426/05/14");
        daysb = daysbett("1426/05/15", "1429/03/14");
        daysa = daysbett("1429/03/15", "1439/12/30");
        all1 = ((daysa / 12) / 30) * 36;
        all2 = ((daysb / 12) / 30) * 35;
        all3 = ((daysd / 12) / 30) * 30;
        all = all1 + all2 + all3;
        all = all.roundToDouble();
        lblall = all.toInt();
      }
      if (dateCompare(startWorkDate.text, "1426/05/15") == 1 &&
          dateCompare(startWorkDate.text, "1429/03/14") ==
              0) //تاريخ بداية العمل من 1426/05/15 إلى ما قبل 1429/03/15
      {
        daysb = daysbett(startWorkDate.text, "1429/03/14");
        daysa = daysbett("1429/03/15", "1439/12/30");
        all1 = (daysa / 12 / 30) * 36;
        all2 = (daysb / 12 / 30) * 35;
        all = all1 + all2;
        all = all.roundToDouble();
        lblall = all.toInt();
      }
      if (dateCompare(startWorkDate.text, "1429/03/15") ==
          1) //تاريخ بداية العمل من 1429/03/15 و ما بعد
      {
        daysa = daysbett(startWorkDate.text, "1439/12/30");
        all1 = (daysa / 12 / 30) * 36;
        all = all1;
        all = all.roundToDouble();
        lblall = all.toInt();

        //تعديل بتاريخ 10/10/2023 من محمد الضاهر بتصفير رصيد الاجازات القديم للموظفين الجدد بعد تاريخ 17/7/1439 أو 1/1/1440 لا يطبق عليهم نظام الأجازات القديم
        if (dateCompare(startWorkDate.text, "1440/01/01") == 1) {
          lblall = 0;
        }
      }
      //ابتداء من 1439
      //تعديل يوم 29-12-2022 الحساب يكون قبل السنة الحالية بسنتين
      //تعديل يوم 12-2-2023 الحساب يكون قبل السنة الحالية بثلاث سنين
      //int beginyear = 1439;
      int beginyear = int.parse(dayDate.text.split("/")[0]) - 4;
      int datworkbeginYear = int.parse(startWorkDate.text.split("/")[0]);
      int endyear = int.parse(dayDate.text.split("/")[0]);
      int maxholidaydays = 36 * (endyear - beginyear);
      int maxholidaydaysworkbegin = 36 * (endyear - datworkbeginYear);

      if (maxholidaydaysworkbegin < maxholidaydays) {
        lblallNew = maxholidaydaysworkbegin;
      } else {
        lblallNew = maxholidaydays;
      }
      //المتمتع القديم
      double period1 =
          await countHoliday(int.parse(empId.text), [10], null, null);
      double tamdeedHave =
          await countHolidayTamdeed(int.parse(empId.text), [10], null, null);
      double period2 = await countHoliday(int.parse(empId.text), [0, 6, 9],
          hijriToGreg(startWorkDate.text), hijriToGreg("1439/07/03"));
      lblhave = (period1 + period2 + tamdeedHave + takenHoliday).toInt();
      lblremain = lblall - lblhave;
      if (lblremain < 0) {
        lblremain = 0;
      }
      //المتمتع بعد 1439
      beginyear += 1;

      double periodNew1 = await countHoliday(int.parse(empId.text), [0, 6, 9],
          hijriToGreg("$beginyear/01/01"), hijriToGreg(dayDate.text));
      double tamdeedHaveNew = await countHolidayTamdeed(
          int.parse(empId.text),
          [0, 6, 9],
          hijriToGreg("$beginyear/01/01"),
          hijriToGreg(dayDate.text));

      lblhaveNew = (periodNew1 + tamdeedHaveNew).toInt();
      lblremainNew = lblallNew - lblhaveNew;
      if (lblremainNew < 0) {
        lblremainNew = 0;
      }

      //حساب الاعتيادي السنوي الباقي بناءا على كل السنين السابقة من سنة 1440 إلى تاريخ اليوم كي يضاف جميع الأجازات القديمة قبل 4 سنوات
      double periodBefore4Years = await countHoliday(int.parse(empId.text),
          [0, 6, 9], hijriToGreg("1440/01/01"), hijriToGreg(dayDate.text));
      lblremainNew = (36 * (endyear - 1439) - periodBefore4Years).toInt();
      if (lblremainNew > 144) {
        lblremainNew = 144;
      }
      if (maxholidaydaysworkbegin < maxholidaydays) {
        lblremainNew = lblallNew - lblhaveNew;
      }

      lblallall = lblall + lblallNew;
      lblhavehave = lblhave + lblhaveNew;
      lblremainremain = lblremain + lblremainNew;
      if (lblremainremain < 0) {
        lblremainremain = 0;
      }

      //المتفرقة أقل من 5 أيام
      // DataTable dt3 = new DataTable();
      // DataTable dtMotfareqaTamded = new DataTable();
      endyear = int.parse(dayDate.text.split("/")[0]);
      double motfareqa = await countHolidayMotfareqa(int.parse(empId.text), [6],
          hijriToGreg("$endyear/01/01"), hijriToGreg(dayDate.text));

      int baqy = (10 - motfareqa).toInt();

      lblMofaraqHave = motfareqa.toInt();
      lblMofaraqRemain = baqy;

      if (empType != "عامل أجنبي") {
        if (motfareqa <= 10) {
          customSnackBar(
              title: "تنبيه",
              message:
                  "الإجازات المتفرقة للسنة الحالية : $motfareqa المتبقي: $baqy",
              isDone: false);
        } else {
          customSnackBar(
            title: "تنبيه",
            message:
                "تجاوزت الحد المسموح به للإجازات الاعتيادية المتفرقة لهذه السنة",
            isDone: false,
          );
        }
      }
      if (empType == "عامل أجنبي") {
        double dt1 =
            await countHoliday(int.parse(empId.text), [10], null, null);
        lblhave = (dt1 + takenHoliday).toInt();
        daysa = daysbett(startWorkDate.text, dayDate.text);
        all = (daysa / 12 / 30) * 30;
        all = all.roundToDouble();
        lblall = all.toInt();
        lblremain = lblall - lblhave;
        // panel4.Visible = false;
        // panel5.Visible = false;
      }

      //المرحل - قبل 3 سنوات
      int yearmorahal = int.parse(dayDate.text.split("/")[0]) - 3;
      int yearmorahal1 = int.parse(dayDate.text.split("/")[0]) - 2;

      double dt1 = await countHolidayMorahal(
          int.parse(empId.text), [0, 6], yearmorahal.toString());
      double dt2 = await countHolidayMorahal(
          int.parse(empId.text), [9], yearmorahal1.toString());

      lblmorahalhave = dt1.toInt();
      lblmorahalremain = (36 - lblmorahalhave + dt2).toInt();
    }
  }
}
