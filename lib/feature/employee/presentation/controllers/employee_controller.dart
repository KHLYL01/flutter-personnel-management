import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:personnel_management/feature/employee/presentation/controllers/employee_search_controller.dart';
import 'package:pluto_grid/pluto_grid.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../../../core/functions/image_picker.dart';
import '../../data/model/employee_model.dart';
import '../../data/repository/employee_repository.dart';

class EmployeeController extends GetxController {
  final EmployeeRepository _repository;

  EmployeeController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  final TextEditingController id = TextEditingController();
  //TextEditingController updateEmployeeNumber = TextEditingController();
  final TextEditingController jobData = TextEditingController();
  final TextEditingController fia = TextEditingController();
  final TextEditingController draga = TextEditingController(text: "0");
  final TextEditingController draga2 = TextEditingController();
  final TextEditingController jobNo = TextEditingController(text: "0");
  final TextEditingController jobbadalat = TextEditingController(text: "0");
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
  final TextEditingController takenHolidays = TextEditingController(text: "0");
  final TextEditingController iqazatMosagalah = TextEditingController();
  final TextEditingController hafezahNumber = TextEditingController();
  final TextEditingController makanAlsodor = TextEditingController();
  final TextEditingController sodorDate = TextEditingController();
  final TextEditingController dateOfBirth = TextEditingController();
  final TextEditingController datBirth = TextEditingController();
  final TextEditingController inDate = TextEditingController();
  final TextEditingController education = TextEditingController();
  final TextEditingController educationName = TextEditingController();
  final TextEditingController datEducation = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController cardJob = TextEditingController();
  final TextEditingController cardNo = TextEditingController(text: "0");
  final TextEditingController cardStart = TextEditingController();
  final TextEditingController datAkdBegin = TextEditingController();
  final TextEditingController datAkdEnd = TextEditingController();
  final TextEditingController qardQest = TextEditingController(text: "0");
  final TextEditingController qardMony = TextEditingController(text: "0");
  final TextEditingController taka3odM = TextEditingController(text: "0");
  final TextEditingController agriculturalBank = TextEditingController();
  final TextEditingController harmOrInfection = TextEditingController();
  final TextEditingController bankId = TextEditingController();
  final TextEditingController akdNoTasleef = TextEditingController();
  final TextEditingController other1 = TextEditingController();
  final TextEditingController realEstateBank = TextEditingController();
  final TextEditingController contractOfrealEstateBank =
      TextEditingController();
  final TextEditingController other2 = TextEditingController();
  final TextEditingController datBok = TextEditingController();
  final TextEditingController bokPlace = TextEditingController();
  final TextEditingController birthPlace = TextEditingController();
  final TextEditingController healthInsurance = TextEditingController();
  var employeePhoto = ''.obs;
  var isPicture = false.obs;
  var saned = false.obs;
  RxString workJob = 'موظف'.obs;
  RxString jobState = 'مشغولة'.obs;
  var nationalityRadoiListTileValue = ''.obs;
  onChangeNationalityRadoiListTileValue(value) {
    nationalityRadoiListTileValue.value = value;
  }

  final List<String> jobDataTypes = [
    'موظف',
    'مستخدم',
    'عامل بند اجور',
    'عامل أجنبي',
    'عامل نظافة - عقد',
    'ندب',
    'مكافأة رئيس البلدية',
    'مكافأة المجلس البلدي',
    'عامل بند اجور غير سعودي',
  ];
  final List<String> jobStatus = [
    'مشغولة',
    'مشغولة و متوقف عن العمل',
    'شاغرة',
    'مشغولة و متقاعد عن العمل',
  ];
  onChangeIsPicture() {
    isPicture.value = !isPicture.value;
  }

  onChangeSaned() {
    saned.value = !saned.value;
  }

  onChangeJobDataType(value) {
    workJob(value);
  }

  onChangeJobDataStatu(value) {
    jobState(value);
  }

  void pickImage() async {
    final picker = WebImagePicker();
    final image = await picker.pickImage();

    if (image != null) {
      employeePhoto.value = image;
    }
  }

  Future<void> save() async {
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      EmployeeModel(
        id: id.text != ""
            ? int.parse(id.text)
            : await Get.find<EmployeeSearchController>().getId(),
        workJob: workJob.value,
        // بيانات الوظيفة
        // empType .value,
        fia: fia.text,
        draga: double.parse(draga.text),
        jobNo: int.parse(jobNo.text),
        jobbadalat: double.parse(jobbadalat.text),
        salary: double.parse(salary.text),
        naqlBadal: double.parse(naqlBadal.text),
        elawa: double.parse(elawa.text),
        inEntedabBadal: double.parse(inEntedabBadal.text),
        outEntedabBadal: double.parse(outEntedabBadal.text),
        jobId: int.parse(jobId.text),
        symble: symble.text,
        partId: int.parse(partId.text),
        datJob: datJob.text,
        jobState: jobState.value,
        name: name.text,
        cardId: cardId.text,
        takenHolidays:
            int.parse(takenHolidays.text), // الاجازات المسجلة حتى الان
        nationId: int.parse(nationId.text),
        // رقم الحفيظة
        // مكان الصدور
        // تاريخ الصدور
        birthPlace: birthPlace.text,
        datBirth: datBirth.text,
        inDate: inDate.text,
        educationName: educationName.text,
        education: education.text,
        datEducation: datEducation.text,
        address: address.text,
        phone: phone.text,
        cardJob: cardJob.text, // العمل المكلف به
        cardNo: int.parse(cardNo.text),
        cardStart: cardStart.text,
        // datQard datQard.text,
        datAkdBegin: datAkdBegin.text, // تاريخ بداية القرض
        datAkdEnd: datAkdEnd.text, // تاريخ نهاية القرض
        qardMony: int.parse(qardMony.text),
        qardQest: int.parse(qardQest.text),
        taka3odM: double.parse(taka3odM.text),

        // ضرر عدوى
        // أخرى
        bankId: bankId.text,
        akdNoTasleef: akdNoTasleef.text,
        // عقاري
        // رقم العقد
        // البنك الزراعي
        // التأمين الصحي
        // أخرى
        datBok: datBok.text,
        bokPlace: bokPlace.text,
      ),
    );
    data.fold((l) => messageError(l.eerMessage), (r) => fillControllers(r));
    isLoading(false);
    if (messageError.isEmpty) {
      Get.find<EmployeeSearchController>().findAll();
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
      return;
    }
    customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  }

  void clearControllers() {
    id.clear();
    jobData.clear();
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
    datJob.clear();
    name.clear();
    nationId.clear();
    nationName.clear();
    cardId.clear();
    takenHolidays.text = "0";
    iqazatMosagalah.clear();
    hafezahNumber.clear();
    makanAlsodor.clear();
    sodorDate.clear();
    dateOfBirth.clear();
    datBirth.clear();
    inDate.clear();
    education.clear();
    educationName.clear();
    datEducation.clear();
    address.clear();
    phone.clear();
    cardJob.clear();
    cardNo.text = "0";
    cardStart.clear();
    datAkdBegin.clear();
    datAkdEnd.clear();
    qardQest.text = "0";
    qardMony.text = "0";
    taka3odM.text = "0";
    agriculturalBank.clear();
    harmOrInfection.clear();
    bankId.clear();
    akdNoTasleef.clear();
    other1.clear();
    realEstateBank.clear();
    contractOfrealEstateBank.clear();
    other2.clear();
    datBok.clear();
    bokPlace.clear();
    birthPlace.clear();
    healthInsurance.clear();
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

  void fillControllers(EmployeeModel r) {
    id.text = r.id.toString();
    fia.text = r.fia.toString();
    draga.text = r.draga.toString();
    jobNo.text = r.jobNo.toString();
    jobbadalat.text = r.jobbadalat.toString();
    salary.text = r.salary.toString();
    naqlBadal.text = r.naqlBadal.toString();
    elawa.text = r.elawa.toString();
    inEntedabBadal.text = r.inEntedabBadal.toString();
    outEntedabBadal.text = r.outEntedabBadal.toString();
    symble.text = r.symble.toString();
    partId.text = r.partId.toString();
    datJob.text = r.datJob.toString();
    name.text = r.name.toString();
    cardId.text = r.cardId.toString();
    nationId.text = r.nationId.toString();
    birthPlace.text = r.birthPlace.toString();
    datBirth.text = r.datBirth.toString();
    inDate.text = r.inDate.toString();
    educationName.text = r.educationName.toString();
    education.text = r.education.toString();
    datEducation.text = r.datEducation.toString();
    address.text = r.address.toString();
    phone.text = r.phone.toString();
    cardJob.text = r.cardJob.toString();
    cardNo.text = r.cardNo.toString();
    cardStart.text = r.cardStart.toString();
    datAkdBegin.text = r.datAkdBegin.toString();
    datAkdEnd.text = r.datAkdEnd.toString();
    qardMony.text = r.qardMony.toString();
    qardQest.text = r.qardQest.toString();
    taka3odM.text = r.taka3odM.toString();
    jobId.text = r.jobId.toString();
    bankId.text = r.bankId.toString();
    akdNoTasleef.text = r.akdNoTasleef.toString();
    datBok.text = r.datBok.toString();
    bokPlace.text = r.bokPlace.toString();
    workJob('موظف');
    jobState('مشغولة');
  }
}
