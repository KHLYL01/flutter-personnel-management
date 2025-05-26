import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/feature/employee/presentation/controllers/employee_search_controller.dart';
import 'package:personnel_management/feature/tarmeez_nations/data/repository/nations_repository.dart';
import 'package:personnel_management/feature/tarmeez_parts/data/repository/parts_repository.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../../../core/functions/image_picker.dart';
import '../../../tarmeez_jobs/data/repository/jobs_repository.dart';
import '../../data/model/employee_model.dart';
import '../../data/repository/employee_repository.dart';

class EmployeeController extends GetxController {
  final EmployeeRepository _repository;
  final JobsRepository _jobsRepository;
  final PartsRepository _partsRepository;
  final NationsRepository _nationsRepository;

  EmployeeController(this._repository, this._jobsRepository,
      this._partsRepository, this._nationsRepository);

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
  final TextEditingController contractOfrealEstateBank =
      TextEditingController();
  final TextEditingController datBok = TextEditingController();
  final TextEditingController bokPlace = TextEditingController();
  final TextEditingController birthPlace = TextEditingController();
  var employeePhoto = ''.obs;
  var isPicture = false.obs;
  var isHasm3 = false.obs;
  RxString empType = 'موظف'.obs;
  RxString jobState = 'مشغولة'.obs;
  var nationalityRadoiListTileValue = ''.obs;

  final TextEditingController degreeId = TextEditingController(text: "0");
  final TextEditingController jobbadalat = TextEditingController(text: "0");
  final TextEditingController datWork = TextEditingController();
  final TextEditingController educationName = TextEditingController();
  final TextEditingController datEducation = TextEditingController();
  final TextEditingController dissent = TextEditingController(text: "0");
  final TextEditingController akdNoTasleef = TextEditingController();
  final TextEditingController takenHolidays = TextEditingController(text: "0");
  final TextEditingController sandok = TextEditingController(text: "0");
  final TextEditingController cardNo = TextEditingController(text: "0");
  final TextEditingController cardStart = TextEditingController();
  final TextEditingController qardQest = TextEditingController(text: "0");
  final TextEditingController qardMony = TextEditingController(text: "0");
  final TextEditingController taka3odM = TextEditingController(text: "0");
  final TextEditingController hasm1 = TextEditingController();
  final TextEditingController hasm2 = TextEditingController();
  final TextEditingController badal2 = TextEditingController();
  final TextEditingController badal4 = TextEditingController();
  final TextEditingController zeraee = TextEditingController();

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
    isHasm3.value = !isHasm3.value;
  }

  onChangeJobDataType(value) {
    empType(value);
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

        degreeId: int.parse(degreeId.text),
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
        dissent: double.parse(dissent.text),
        akdNoTasleef: akdNoTasleef.text,
        takenHolidays:
            int.parse(takenHolidays.text), // الاجازات المسجلة حتى الان
        sandok: double.parse(sandok.text),
        hasm1: int.parse(hasm1.text),
        hasm2: int.parse(hasm2.text),
        badal2: int.parse(badal2.text),
        badal4: int.parse(badal4.text),
        zeraee: double.parse(zeraee.text),
        isHasm3: isHasm3.value ? 1 : 0,
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
    degreeId.clear();
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
    bok.clear();
    makanAlsodor.clear();
    sodorDate.clear();
    datBirth.clear();
    datBirth.clear();
    datWork.clear();
    education.clear();
    educationName.clear();
    datEducation.clear();
    address.clear();
    phone.clear();
    workJob.clear();
    cardNo.text = "0";
    cardStart.clear();
    datAkdBegin.clear();
    datAkdEnd.clear();
    qardQest.text = "0";
    qardMony.text = "0";
    taka3odM.text = "0";
    zeraee.clear();
    badal2.clear();
    dissent.clear();
    akdNoTasleef.clear();
    badal4.clear();
    sandok.clear();
    contractOfrealEstateBank.clear();
    hasm2.clear();
    datBok.clear();
    bokPlace.clear();
    birthPlace.clear();
    hasm1.clear();
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
        .fold((l) => l, (r) => jobName.text = r.name ?? "");
    (await _nationsRepository.findById(id: r.nationId))
        .fold((l) => l, (r) => nationName.text = r.name ?? "");
    (await _partsRepository.findById(id: r.partId))
        .fold((l) => l, (r) => partName.text = r.name ?? "");

    jobId.text = (r.jobId ?? "0").toString();
    id.text = (r.id ?? "0").toString();
    fia.text = (r.fia ?? "0").toString();
    draga.text = (r.draga ?? "0").toString();
    jobNo.text = (r.jobNo ?? "0").toString();
    jobbadalat.text = (r.jobbadalat ?? "0").toString();
    salary.text = (r.salary ?? "0").toString();
    naqlBadal.text = (r.naqlBadal ?? "0").toString();
    elawa.text = (r.elawa ?? "0").toString();
    inEntedabBadal.text = (r.inEntedabBadal ?? "0").toString();
    outEntedabBadal.text = (r.outEntedabBadal ?? "0").toString();
    symble.text = r.symble ?? "";
    partId.text = (r.partId ?? "0").toString();
    datJob.text = r.datJob ?? "";
    name.text = r.name ?? "";
    cardId.text = r.cardId ?? "";
    nationId.text = (r.nationId ?? "0").toString();
    birthPlace.text = r.birthPlace ?? "";
    datBirth.text = r.datBirth ?? "";
    datWork.text = r.datWork ?? "";
    education.text = r.education ?? "";
    educationName.text = r.educationName ?? "";
    datEducation.text = r.datEducation ?? "";
    address.text = r.address ?? "";
    phone.text = r.phone ?? "";
    workJob.text = r.workJob ?? "";
    cardNo.text = (r.cardNo ?? "0").toString();
    cardStart.text = r.cardStart ?? "";
    datAkdBegin.text = r.datAkdBegin ?? "";
    datAkdEnd.text = r.datAkdEnd ?? "";
    qardMony.text = (r.qardMony ?? "0").toString();
    qardQest.text = (r.qardQest ?? "0").toString();
    taka3odM.text = (r.taka3odM ?? "0").toString();
    dissent.text = (r.dissent ?? "0").toString();
    akdNoTasleef.text = r.akdNoTasleef ?? "";
    datBok.text = r.datBok ?? "";
    bokPlace.text = r.bokPlace ?? "";
    bok.text = r.bok ?? "";

    degreeId.text = (r.degreeId ?? "0").toString();
    takenHolidays.text = (r.takenHolidays ?? "0").toString();
    sandok.text = (r.sandok ?? "0").toString();
    hasm1.text = (r.hasm1 ?? "0").toString();
    hasm2.text = (r.hasm2 ?? "0").toString();
    badal2.text = (r.badal2 ?? "0").toString();
    badal4.text = (r.badal4 ?? "0").toString();
    zeraee.text = (r.zeraee ?? "0").toString();
    isHasm3.value = r.isHasm3 == 1;

    empType(r.empType ?? "موظف");
    jobState(r.jobState ?? "مشغولة");
  }
}
