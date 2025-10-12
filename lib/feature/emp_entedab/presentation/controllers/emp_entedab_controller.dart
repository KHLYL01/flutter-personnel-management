import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/int_extension.dart';
import 'package:personnel_management/feature/actions/presentation/controllers/actions_controller.dart';
import 'package:personnel_management/feature/actions/presentation/controllers/actions_controller.dart';
import 'package:personnel_management/feature/emp_end/presentation/controllers/emp_end_search_controller.dart';
import 'package:personnel_management/feature/emp_entedab/presentation/controllers/emp_entedab_det_controller.dart';
import 'package:personnel_management/feature/emp_entedab/presentation/controllers/emp_entedab_search_controller.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../../../core/utils/helper_method.dart';
import '../../data/model/emp_entedab_model.dart';
import '../../data/repository/emp_entedab_repository.dart';

class EmpEntedabController extends GetxController {
  final EmpEntedabRepository _repository;

  EmpEntedabController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  final TextEditingController id = TextEditingController();
  final TextEditingController qrarId = TextEditingController();
  final TextEditingController place = TextEditingController();
  final TextEditingController task = TextEditingController();
  final TextEditingController datQrar = TextEditingController();
  final TextEditingController datQrarGo = TextEditingController();
  final TextEditingController period =
      TextEditingController(text: 0.toString());
  final TextEditingController khetabId = TextEditingController();
  final TextEditingController datKhrtab = TextEditingController();
  final TextEditingController datKhetabGo = TextEditingController();
  final TextEditingController datBegin = TextEditingController();
  final TextEditingController datBeginGo = TextEditingController();
  final TextEditingController datEnd = TextEditingController();
  final TextEditingController datEndGo = TextEditingController();
  final TextEditingController taskRaValue =
      TextEditingController(text: 0.toString());
  final TextEditingController distance =
      TextEditingController(text: 0.toString());
  final TextEditingController fiaMony =
      TextEditingController(text: 0.toString());
  RxString day = 'الأحد'.obs;
  RxString type = 'داخلي'.obs;
  RxString fia = 'أ'.obs;
  RxString waselTsafar = 'الطائرة'.obs;
  var isPicture = false.obs;
  var travelVehicleTameen = false.obs;
  var usingCar = false.obs;
  var workOutDawam = false.obs;
  var housingOrFood = false.obs;
  var solfahNaqdeah = false.obs;
  void toggleCheckBoxValue(var variable) {
    variable.value = !variable.value;
  }

  onChangeHousingOrFood() {
    toggleCheckBoxValue(housingOrFood);
  }

  onChangerTavelVehicleTameen() {
    toggleCheckBoxValue(travelVehicleTameen);
  }

  onChangeUsingCar() {
    toggleCheckBoxValue(usingCar);
  }

  onChangeWorkOutDawam() {
    toggleCheckBoxValue(workOutDawam);
  }

  onChangeSolfahNaqdeah() {
    toggleCheckBoxValue(solfahNaqdeah);
  }

  var sarf = ' يصرف له يوميا بدل نقل إضافي 1/ 30 من بدل نقله الشهري'.obs;
  var taskRa = ' لا يصرف للمذكور مبلغًا تعويضًا عن تذاكر إركابه'.obs;

  onChangedPicture() {
    isPicture.value = !isPicture.value;
  }

  void onChangeDay(value) {
    day(value);
  }

  void onChangeType(value) {
    type(value);
  }

  void onChangeCategory(value) {
    fia(value);
  }

  void onChangeVehicle(value) {
    waselTsafar(value);
  }

  final List<String> days = [
    'السبت',
    'الأحد',
    'الأثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
  ];
  final List<String> types = ['داخلي', 'خارجي'];
  final List<String> categories = ['أ', 'ب', 'ج'];
  final List<String> vehicles = [
    'الطائرة',
    'القطار',
    'سيارة حكومية',
    'وسيلة أخرى'
  ];

  updateBadalNaqel(value) {
    sarf.value = value;
  }

  updateMablaghTaweedy(value) {
    taskRa.value = value;
  }

  Future<void> save() async {
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      EmpEntedabModel(
        id: id.text != ""
            ? int.parse(id.text)
            : await Get.find<EmpEntedabSearchController>().getId(),
        qrarId: qrarId.text,
        day: day.value,
        datBegin: datBegin.text,
        datBeginGo: DateTime.parse(datBeginGo.text.replaceAll("/", '-'))
            .toIso8601String(),
        datEnd: datEnd.text,
        datEndGo: DateTime.parse(datEndGo.text.replaceAll("/", '-'))
            .toIso8601String(),
        datKhetab: datKhrtab.text,
        datKhetabGo: DateTime.parse(datKhetabGo.text.replaceAll("/", '-'))
            .toIso8601String(),
        datQrar: datQrar.text,
        datQrarGo: DateTime.parse(datQrarGo.text.replaceAll("/", '-'))
            .toIso8601String(),
        fia: fia.value,
        fiaMony: double.parse(fiaMony.text),
        type: type.value,
        waselTsafar: waselTsafar.value,
        task: task.text,
        place: place.text,
        khetabId: khetabId.text,
        period: int.parse(period.text),
        distance: double.parse(distance.text),
        taskRaValue: double.parse(taskRaValue.text),
        question1: travelVehicleTameen.value ? 1 : 0,
        question2: usingCar.value ? 1 : 0,
        question3: workOutDawam.value ? 1 : 0,
        question4: housingOrFood.value ? 1 : 0,
        question5: solfahNaqdeah.value ? 1 : 0,
        sarf: sarf.value ==
                ' يصرف له يوميا بدل نقل إضافي 1/ 30 من بدل نقله الشهري'
            ? 1
            : 0,
        taskRa:
            taskRa.value == ' لا يصرف للمذكور مبلغًا تعويضًا عن تذاكر إركابه'
                ? 0
                : 1,
      ),
    );
    data.fold((l) => messageError(l.eerMessage), (r) {
      if (id.text.isEmpty) {
        Get.find<ActionsController>().save(
            "حفظ انتداب باسم ${task.text} جهة الانتداب ${place.text} المدة ${period.text} تاريخ بداية الانتداب ${datBegin.text}");
      } else {
        Get.find<ActionsController>().save(
            "تعديل انتداب باسم ${task.text} جهة الانتداب ${place.text} المدة ${period.text} تاريخ بداية الانتداب ${datBegin.text}");
      }
      fillControllers(r);
    });
    isLoading(false);
    if (messageError.isEmpty) {
      Get.find<EmpEndSearchController>().findAll();
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
      Get.find<EmpEndSearchController>().findAll();
      customSnackBar(title: 'تم', message: 'تم الحذف بنجاح');
      Get.find<ActionsController>().save(
          "حذف انتداب باسم ${task.text} جهة الانتداب ${place.text} المدة ${period.text} تاريخ بداية الانتداب ${datBegin.text}");
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

  void fillControllers(EmpEntedabModel r) {
    id.text = r.id.getValue();
    qrarId.text = r.qrarId.getValue();
    datBegin.text = r.datBegin.getValue();
    datBeginGo.text =
        r.datBeginGo.getValue().substring(0, 10).replaceAll('-', '/');
    datEnd.text = r.datEnd.getValue();
    datEndGo.text = r.datEndGo.getValue().substring(0, 10).replaceAll('-', '/');
    datKhrtab.text = r.datKhetab.getValue();
    datKhetabGo.text =
        r.datKhetabGo.getValue().substring(0, 10).replaceAll('-', '/');
    datQrar.text = r.datQrar.getValue();
    datQrarGo.text =
        r.datQrarGo.getValue().substring(0, 10).replaceAll('-', '/');
    fiaMony.text = r.fiaMony.getValue();
    task.text = r.task.getValue();
    place.text = r.place.getValue();
    khetabId.text = r.khetabId.getValue();
    period.text = r.period.getValue();
    distance.text = r.distance.getValue();
    taskRaValue.text = r.taskRaValue.getValue();
    travelVehicleTameen.value = r.question1 == 1;
    usingCar.value = r.question2 == 1;
    workOutDawam.value = r.question3 == 1;
    housingOrFood.value = r.question4 == 1;
    solfahNaqdeah.value = r.question5 == 1;
    sarf.value = r.sarf == 1
        ? ' يصرف له يوميا بدل نقل إضافي 1/ 30 من بدل نقله الشهري'
        : " لا يصرف له يوميا بدل نقل إضافي 1/ 30 من بدل نقله الشهري";
    taskRa.value = r.taskRa == 0
        ? ' لا يصرف للمذكور مبلغًا تعويضًا عن تذاكر إركابه'
        : 'يصرف للمذكور مبلغًا تعويضًا عن تذاكر إركابه';
    day(r.day);
    waselTsafar(r.waselTsafar);
    type(r.type);
    fia(r.fia);
  }

  clearControllers() async {
    qrarId.clear();
    day.value = 'الأحد';
    datBegin.text = nowHijriDate();
    datBeginGo.text = nowDate();
    datEnd.text = nowHijriDate();
    datEndGo.text = nowDate();
    datKhrtab.text = nowHijriDate();
    datKhetabGo.text = nowDate();
    datQrar.text = nowHijriDate();
    datQrarGo.text = nowDate();
    fia.value = "أ";
    fiaMony.text = 0.toString();
    type.value = "داخلي";
    waselTsafar.value = "الطائرة";
    task.clear();
    place.clear();
    khetabId.clear();
    period.text = "0";
    distance.text = 0.toString();
    taskRaValue.text = 0.toString();
    travelVehicleTameen(false);
    usingCar(false);
    workOutDawam(false);
    housingOrFood(false);
    solfahNaqdeah(false);
    sarf(' يصرف له يوميا بدل نقل إضافي 1/ 30 من بدل نقله الشهري');
    taskRa(' لا يصرف للمذكور مبلغًا تعويضًا عن تذاكر إركابه');

    Get.find<EmpEntedabDetController>().clearAllData();
    id.text = (await Get.find<EmpEntedabSearchController>().getId()).toString();
    Get.find<EmpEntedabDetController>().entedabId.text = id.text;
  }
}
