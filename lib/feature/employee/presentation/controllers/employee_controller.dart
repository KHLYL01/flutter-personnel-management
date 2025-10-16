import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/int_extension.dart';
import 'package:personnel_management/feature/actions/presentation/controllers/actions_controller.dart';
import 'package:personnel_management/feature/employee/presentation/controllers/employee_search_controller.dart';
import 'package:personnel_management/feature/tarmeez_nations/data/repository/nations_repository.dart';
import 'package:personnel_management/feature/tarmeez_parts/data/repository/parts_repository.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../../../core/functions/image_picker.dart';
import '../../../../core/utils/helper_method.dart';
import '../../../banks/data/repository/banks_repository.dart';
import '../../../tarmeez_jobs/data/repository/jobs_repository.dart';
import '../../data/model/employee_model.dart';
import '../../data/repository/employee_repository.dart';

class EmployeeController extends GetxController {
  final EmployeeRepository _repository;
  final JobsRepository _jobsRepository;
  final PartsRepository _partsRepository;
  final NationsRepository _nationsRepository;
  final BanksRepository _banksRepository;

  EmployeeController(this._repository, this._jobsRepository,
      this._partsRepository, this._nationsRepository, this._banksRepository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  final TextEditingController id = TextEditingController();
  //TextEditingController updateEmployeeNumber = TextEditingController();
  final TextEditingController fia = TextEditingController();
  final TextEditingController draga = TextEditingController(text: "0");
  final TextEditingController draga2 = TextEditingController();
  final TextEditingController jobNo = TextEditingController(text: "0");
  final TextEditingController salary = TextEditingController(text: "0");
  final TextEditingController naqlBadal = TextEditingController(text: "0");
  final TextEditingController elawa = TextEditingController(text: "0");
  final TextEditingController outEntedabBadal =
      TextEditingController(text: "0");
  final TextEditingController inEntedabBadal = TextEditingController(text: "0");
  final TextEditingController jobId = TextEditingController();
  final TextEditingController jobName = TextEditingController();
  final TextEditingController symble = TextEditingController();

  final TextEditingController partId = TextEditingController();
  final TextEditingController partName = TextEditingController();
  final TextEditingController datJob = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController nationId = TextEditingController();
  final TextEditingController nationName = TextEditingController();
  final TextEditingController cardId = TextEditingController();
  final TextEditingController iqazatMosagalah = TextEditingController();
  final TextEditingController bok = TextEditingController();
  final TextEditingController makanAlsodor = TextEditingController();
  final TextEditingController sodorDate = TextEditingController();
  final TextEditingController datBirth = TextEditingController();
  final TextEditingController education = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController workJob = TextEditingController();
  final TextEditingController datAkdBegin = TextEditingController();
  final TextEditingController datAkdEnd = TextEditingController();

  final TextEditingController datBok = TextEditingController();
  final TextEditingController bokPlace = TextEditingController();
  final TextEditingController birthPlace = TextEditingController();
  var employeePhoto = ''.obs;
  var isPicture = false.obs;
  var isHasm3 = false.obs;
  RxString empType = 'موظف'.obs;
  RxString jobState = 'مشغولة'.obs;
  RxString esthqaqEndAkd = 'غير ملزم بدفع مبالغ عند نهاية الخدمة'.obs;
  var nationalityRadoiListTileValue = ''.obs;

  final TextEditingController degreeId = TextEditingController(text: "");
  final TextEditingController jobbadalat = TextEditingController(text: "0");
  final TextEditingController datWork = TextEditingController();
  final TextEditingController educationName = TextEditingController();
  final TextEditingController datEducation = TextEditingController();

  final TextEditingController dissent = TextEditingController(text: "0");
  final TextEditingController akdNoTasleef = TextEditingController();
  final TextEditingController datStartTasleef = TextEditingController();
  final TextEditingController datEndTasleef = TextEditingController();
  final TextEditingController qestTasleef = TextEditingController();
  final TextEditingController moneyTasleef = TextEditingController();

  final TextEditingController sandok = TextEditingController(text: "0");
  final TextEditingController akdNoSandok = TextEditingController();
  final TextEditingController datStartSandok = TextEditingController();
  final TextEditingController datEndSandok = TextEditingController();
  final TextEditingController qestSandok = TextEditingController();
  final TextEditingController moneySandok = TextEditingController();

  final TextEditingController zeraee = TextEditingController(text: "0");
  final TextEditingController akdNoZeraee = TextEditingController();
  final TextEditingController datStartZeraee = TextEditingController();
  final TextEditingController datEndZeraee = TextEditingController();
  final TextEditingController qestZeraee = TextEditingController();
  final TextEditingController moneyZeraee = TextEditingController();

  final TextEditingController takenHolidays = TextEditingController(text: "0");
  final TextEditingController cardNo = TextEditingController(text: "0");
  final TextEditingController cardStart = TextEditingController();
  final TextEditingController qardQest = TextEditingController(text: "0");
  final TextEditingController qardMony = TextEditingController(text: "0");
  final TextEditingController taka3odM = TextEditingController(text: "0");
  final TextEditingController hasm1 = TextEditingController(text: "0");
  final TextEditingController hasm2 = TextEditingController(text: "0");
  final TextEditingController badal2 = TextEditingController(text: "0");
  final TextEditingController badal4 = TextEditingController(text: "0");

  final TextEditingController bankId = TextEditingController();
  final TextEditingController bankName = TextEditingController();
  final TextEditingController ibanNum = TextEditingController();

  onChangeNationalityRadoiListTileValue(value) {
    nationalityRadoiListTileValue.value = value;
  }

  final List<String> jobDataTypes = [
    'موظف',
    'مستخدم',
    'عامل بند إجور',
    'عامل أجنبي',
    'عامل نظافة - عقد',
    'ندب',
    'مكافأة رئيس البلدية',
    'مكافأة المجلس البلدي',
    'عامل بند إجور غير سعودى',
    'متعاقد غير سعودي',
  ];

  final List<String> jobStatus = [
    'مشغولة',
    'مشغولة و متوقف عن العمل',
    'شاغرة',
    'مشغولة و متقاعد عن العمل',
  ];

  final List<String> esthqaqAkd = [
    'غير ملزم بدفع مبالغ عند نهاية الخدمة',
    'ملزم بدفع مبالغ عند نهاية الخدمة',
  ];
  onChangeIsPicture() {
    isPicture.value = !isPicture.value;
  }

  onChangeSaned() {
    isHasm3.value = !isHasm3.value;
  }

  onChangeJobDataType(value) {
    empType(value);
  }

  onChangeJobDataStatu(value) {
    jobState(value);
  }

  onChangeEsthqaqEndAkd(value) {
    esthqaqEndAkd(value);
  }

  void pickImage() async {
    final picker = WebImagePicker();
    final image = await picker.pickImage();

    if (image != null) {
      employeePhoto.value = image;
    }
  }

  Future<void> save() async {
    if (degreeId.text == "") {
      customSnackBar(
          title: "خطأ", message: 'يرجى اختيار بيانات الوظيفة', isDone: false);
      return;
    }
    if (jobId.text == "") {
      customSnackBar(
          title: "خطأ", message: 'يرجى اختيار مسمى الوظيفة', isDone: false);
      return;
    }
    if (partId.text == "") {
      customSnackBar(title: "خطأ", message: 'يرجى اختيار القسم', isDone: false);
      return;
    }
    if (nationId.text == "") {
      customSnackBar(
          title: "خطأ", message: 'يرجى اختيار الجنسية', isDone: false);
      return;
    }
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      EmployeeModel(
        id: id.text != ""
            ? int.parse(id.text)
            : await Get.find<EmployeeSearchController>().getId(),
        // بيانات الوظيفة
        // empType .value,
        fia: fia.text,
        draga: double.parse(draga.text),
        jobNo: int.parse(jobNo.text),
        salary: double.parse(salary.text),
        naqlBadal: double.parse(naqlBadal.text),
        elawa: double.parse(elawa.text),
        inEntedabBadal: double.parse(inEntedabBadal.text),
        outEntedabBadal: double.parse(outEntedabBadal.text),
        jobId: int.parse(jobId.text),
        symble: symble.text,
        partId: int.parse(partId.text),
        datJob: datJob.text,
        name: name.text,
        cardId: cardId.text,
        nationId: int.parse(nationId.text),
        // رقم الحفيظة
        // مكان الصدور
        // تاريخ الصدور
        birthPlace: birthPlace.text,
        inDate: datWork.text,
        datEducation: datEducation.text,
        address: address.text,
        phone: phone.text,
        cardNo: int.parse(cardNo.text),
        cardStart: cardStart.text,
        // datQard datQard.text,
        datAkdBegin: datAkdBegin.text, // تاريخ بداية القرض
        datAkdEnd: datAkdEnd.text, // تاريخ نهاية القرض
        akdEndService: esthqaqEndAkd.value,
        qardMony: int.parse(qardMony.text),
        qardQest: int.parse(qardQest.text),
        taka3odM: double.parse(taka3odM.text),

        // ضرر عدوى
        // أخرى
        // عقاري
        // رقم العقد
        // البنك الزراعي
        // التأمين الصحي
        // أخرى

        degreeId: degreeId.text.isEmpty ? null : int.parse(degreeId.text),
        jobbadalat: double.parse(jobbadalat.text),
        bok: bok.text,
        bokPlace: bokPlace.text,
        datBok: datBok.text,
        datBirth: datBirth.text,
        datWork: datWork.text,
        educationName: educationName.text,
        education: education.text,
        empType: empType.value,
        jobState: jobState.value,
        workJob: workJob.text, // العمل المكلف به
        takenHolidays:
            int.parse(takenHolidays.text), // الاجازات المسجلة حتى الان
        hasm1: int.parse(hasm1.text),
        hasm2: int.parse(hasm2.text),
        badal2: int.parse(badal2.text),
        badal4: int.parse(badal4.text),
        isHasm3: isHasm3.value ? 1 : 0,

        dissent: double.parse(dissent.text),
        akdNoTasleef: akdNoTasleef.text,
        datStartTasleef: datStartTasleef.text,
        datEndTasleef: datEndTasleef.text,
        qestTasleef: qestTasleef.text.isEmpty ? 0 : int.parse(qestTasleef.text),
        moneyTasleef:
            moneyTasleef.text.isEmpty ? 0 : int.parse(moneyTasleef.text),

        sandok: double.parse(sandok.text),
        akdNoSandok: akdNoSandok.text,
        datStartSandok: datStartSandok.text,
        datEndSandok: datEndSandok.text,
        qestSandok: qestSandok.text.isEmpty ? 0 : int.parse(qestSandok.text),
        moneySandok: moneySandok.text.isEmpty ? 0 : int.parse(moneySandok.text),

        zeraee: double.parse(zeraee.text),
        akdNoZeraee: akdNoZeraee.text,
        datStartZeraee: datStartZeraee.text,
        datEndZeraee: datEndZeraee.text,
        qestZeraee: qestZeraee.text.isEmpty ? 0 : int.parse(qestZeraee.text),
        moneyZeraee: moneyZeraee.text.isEmpty ? 0 : int.parse(moneyZeraee.text),

        bankId: bankId.text,
        ibanNum: ibanNum.text,
      ),
    );
    data.fold((l) => messageError(l.eerMessage), (r) {
      if (id.text.isEmpty) {
        Get.find<ActionsController>().save(
            "حفظ موظف باسم ${name.text} القسم ${partName.text} المسمى الوظيفي ${jobName.text} نوع الوظيفة ${empType.value}");
      } else {
        Get.find<ActionsController>().save(
            "تعديل موظف باسم ${name.text} القسم ${partName.text} المسمى الوظيفي ${jobName.text} نوع الوظيفة ${empType.value}");
      }
      fillControllers(r);
    });
    isLoading(false);
    if (messageError.isEmpty) {
      Get.find<EmployeeSearchController>().findAll();
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
      Get.find<EmployeeSearchController>().findAll();
      customSnackBar(title: 'تم', message: 'تم الحذف بنجاح');
      Get.find<ActionsController>().save(
          "حذف موظف باسم ${name.text} القسم ${partName.text} المسمى الوظيفي ${jobName.text} نوع الوظيفة ${empType.value}");
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

  void fillControllers(EmployeeModel r) async {
    (await _jobsRepository.findById(id: r.jobId))
        .fold((l) => l, (r) => jobName.text = r.name.getValue());
    (await _nationsRepository.findById(id: r.nationId))
        .fold((l) => l, (r) => nationName.text = r.name.getValue());
    (await _partsRepository.findById(id: r.partId))
        .fold((l) => l, (r) => partName.text = r.name.getValue());
    (await _banksRepository.findById(id: r.bankId))
        .fold((l) => l, (r) => bankName.text = r.name.getValue());

    bankId.text = r.bankId.getValue();
    ibanNum.text = r.ibanNum.getValue();

    jobId.text = r.jobId.getValue();
    id.text = r.id.getValue();
    fia.text = r.fia.getValue();
    draga.text = r.draga.getValue();
    jobNo.text = r.jobNo.getValue();
    jobbadalat.text = r.jobbadalat.getValue();
    salary.text = r.salary.getValue();
    naqlBadal.text = r.naqlBadal.getValue();
    elawa.text = r.elawa.getValue();
    inEntedabBadal.text = r.inEntedabBadal.getValue();
    outEntedabBadal.text = r.outEntedabBadal.getValue();
    symble.text = r.symble.getValue();
    partId.text = r.partId.getValue();
    datJob.text = r.datJob.getValue();
    name.text = r.name.getValue();
    cardId.text = r.cardId.getValue();
    nationId.text = r.nationId.getValue();
    birthPlace.text = r.birthPlace.getValue();
    datBirth.text = r.datBirth.getValue();
    datWork.text = r.datWork.getValue();
    education.text = r.education.getValue();
    educationName.text = r.educationName.getValue();
    datEducation.text = r.datEducation.getValue();
    address.text = r.address.getValue();
    phone.text = r.phone.getValue();
    workJob.text = r.workJob.getValue();
    cardNo.text = r.cardNo.getValue();
    cardStart.text = r.cardStart.getValue();

    datAkdBegin.text = r.datAkdBegin.getValue();
    datAkdEnd.text = r.datAkdEnd.getValue();

    taka3odM.text = r.taka3odM.getValue();

    qardMony.text = r.qardMony.getValue();
    qardQest.text = r.qardQest.getValue();

    datBok.text = r.datBok.getValue();
    bokPlace.text = r.bokPlace.getValue();
    bok.text = r.bok.getValue();

    degreeId.text = r.degreeId.getValue();
    takenHolidays.text = r.takenHolidays.getValue();
    hasm1.text = r.hasm1.getValue();
    hasm2.text = r.hasm2.getValue();
    badal2.text = r.badal2.getValue();
    badal4.text = r.badal4.getValue();
    isHasm3.value = r.isHasm3 == 1;

    dissent.text = r.dissent.getValue();
    akdNoTasleef.text = r.akdNoTasleef.getValue();
    datStartTasleef.text = r.datStartTasleef.getValue();
    datEndTasleef.text = r.datEndTasleef.getValue();
    qestTasleef.text = r.qestTasleef.getValue();
    moneyTasleef.text = r.moneyTasleef.getValue();
    sandok.text = r.sandok.getValue();
    akdNoSandok.text = r.akdNoSandok.getValue();
    datStartSandok.text = r.datStartSandok.getValue();
    datEndSandok.text = r.datEndSandok.getValue();
    qestSandok.text = r.qestSandok.getValue();
    moneySandok.text = r.moneySandok.getValue();
    zeraee.text = r.zeraee.getValue();
    akdNoZeraee.text = r.akdNoZeraee.getValue();
    datStartZeraee.text = r.datStartZeraee.getValue();
    datEndZeraee.text = r.datEndZeraee.getValue();
    qestZeraee.text = r.qestZeraee.getValue();
    moneyZeraee.text = r.moneyZeraee.getValue();

    empType(r.empType ?? "موظف");
    jobState(r.jobState ?? "مشغولة");
    esthqaqEndAkd(r.akdEndService ?? "غير ملزم بدفع المبالغ عند نهاية الخدمة");
  }

  clearControllers() async {
    id.clear();
    degreeId.text = "";
    fia.clear();
    draga.text = "0";
    draga2.clear();
    jobNo.text = "0";
    jobbadalat.text = "0";
    salary.text = "0";
    naqlBadal.text = "0";
    elawa.text = "0";
    outEntedabBadal.text = "0";
    inEntedabBadal.text = "0";
    jobId.clear();
    jobName.clear();
    symble.clear();
    partId.clear();
    partName.clear();
    datJob.text = nowHijriDate();
    name.clear();
    nationId.clear();
    nationName.clear();
    cardId.clear();
    takenHolidays.text = "0";
    iqazatMosagalah.clear();
    bok.clear();
    makanAlsodor.clear();
    sodorDate.text = nowHijriDate();
    datBirth.text = nowHijriDate();
    datBirth.text = nowHijriDate();
    datWork.text = nowHijriDate();
    education.clear();
    educationName.clear();
    datEducation.text = nowHijriDate();
    address.clear();
    phone.clear();
    workJob.clear();
    cardNo.text = "0";
    cardStart.clear();
    datAkdBegin.text = nowHijriDate();
    datAkdEnd.text = nowHijriDate();
    qardQest.text = "0";
    qardMony.text = "0";
    taka3odM.text = "0";
    badal2.text = "0";
    badal4.text = "0";
    hasm2.text = "0";
    datBok.text = nowHijriDate();
    bokPlace.clear();
    birthPlace.clear();
    hasm1.text = "0";

    empType("موظف");
    jobState("مشغولة");
    esthqaqEndAkd("غير ملزم بدفع المبالغ عند نهاية الخدمة");

    dissent.text = "0";
    akdNoTasleef.clear();
    datStartTasleef.clear();
    datEndTasleef.clear();
    qestTasleef.clear();
    moneyTasleef.clear();
    sandok.text = "0";
    akdNoSandok.clear();
    datStartSandok.clear();
    datEndSandok.clear();
    qestSandok.clear();
    moneySandok.clear();
    zeraee.text = "0";
    datStartZeraee.clear();
    datEndZeraee.clear();
    qestZeraee.clear();
    moneyZeraee.clear();

    id.text = (await Get.find<EmployeeSearchController>().getId()).toString();
  }
}
