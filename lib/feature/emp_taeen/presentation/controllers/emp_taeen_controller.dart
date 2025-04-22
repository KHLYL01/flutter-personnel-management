import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../data/model/emp_taeen_model.dart';
import '../../data/repository/emp_taeen_repository.dart';
import 'emp_taeen_search_controller.dart';

class EmpTaeenController extends GetxController {
  final EmpTaeenRepository _repository;

  EmpTaeenController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  late final TextEditingController id = TextEditingController();
  late final TextEditingController qrarId = TextEditingController();
  late final TextEditingController qrarDate = TextEditingController();
  late final TextEditingController empId = TextEditingController();
  late final TextEditingController empName = TextEditingController();
  late final TextEditingController draga = TextEditingController();
  late final TextEditingController salary = TextEditingController();
  late final TextEditingController empPart = TextEditingController();
  late final TextEditingController empType = TextEditingController();
  late final TextEditingController mrtaba = TextEditingController();
  late final TextEditingController naqelBadal = TextEditingController();
  late final TextEditingController cardId = TextEditingController();
  late final TextEditingController socialNumber = TextEditingController();
  late final TextEditingController khetabId = TextEditingController();
  late final TextEditingController khetabDate = TextEditingController();
  late final TextEditingController khetabName = TextEditingController();
  late final TextEditingController mKhetabDate = TextEditingController();
  late final TextEditingController birthDate = TextEditingController();
  var isPicture = false.obs;
  RxString mDay = 'السبت'.obs;
  final List<String> mobasharahDays = [
    'السبت',
    'الأحد',
    'الأثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
  ];
  onChangePicture() {
    isPicture.value = !isPicture.value;
  }

  onChangeMobasharahDay(value) {
    mDay(value);
  }

  var state = 'متزوج'.obs;
  updateSocialStatues(value) {
    state.value = value;
  }

  var gender = 'ذكر'.obs;
  updateGender(value) {
    gender.value = value;
  }

  Future<void> save() async {
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      EmpTaeenModel(
        id: id.text != ''
            ? int.parse(id.text)
            : await Get.find<EmpTaeenSearchController>().getId(),
        qrarId: qrarId.text,
        qrarDate: qrarDate.text,
        khetabId: khetabId.text,
        khetabName: khetabName.text,
        khetabDate: khetabDate.text,
        mKhetabDate: mKhetabDate.text,
        empId: empId.text == '' ? null : int.parse(empId.text),
        birthDate: birthDate.text,
        socialNumber: socialNumber.text,
        mDay: mDay.value,
        state: state.value == "متزوج" ? 1 : 0,
        gender: gender.value == "ذكر" ? 1 : 0,
      ),
    );
    data.fold((l) => messageError(l.eerMessage), (r) => r);
    isLoading(false);
    if (messageError.isEmpty) {
      Get.find<EmpTaeenSearchController>().findAll();
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
      Get.find<EmpTaeenSearchController>().findAll();
      return;
    }
    customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  }

  void clearControllers() {
    id.clear();
    qrarId.clear();
    qrarDate.clear();
    empId.clear();
    empName.clear();
    draga.clear();
    salary.clear();
    empPart.clear();
    empType.clear();
    mrtaba.clear();
    naqelBadal.clear();
    cardId.clear();
    socialNumber.clear();
    khetabId.clear();
    khetabDate.clear();
    khetabName.clear();
    mKhetabDate.clear();
    birthDate.clear();
    mDay('السبت');
    state("متزوج");
    gender("ذكر");
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

  void fillControllers(EmpTaeenModel r) {
    id.text = r.id.toString();
    qrarId.text = r.qrarId.toString();
    qrarDate.text = r.qrarDate.toString();
    empId.text = r.empId.toString();
    socialNumber.text = r.socialNumber.toString();
    khetabId.text = r.khetabId.toString();
    khetabDate.text = r.khetabDate.toString();
    khetabName.text = r.khetabName.toString();
    mKhetabDate.text = r.mKhetabDate.toString();
    birthDate.text = r.birthDate.toString();
    mDay('السبت');
    state(r.state == 1 ? "متزوج" : 'أعزب');
    gender(r.gender == 1 ? "ذكر" : 'أنثى');
  }
}
