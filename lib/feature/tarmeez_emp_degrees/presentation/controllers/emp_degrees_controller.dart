import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../data/model/emp_degrees_model.dart';
import '../../data/repository/emp_degrees_repository.dart';

class EmpDegreesController extends GetxController {
  final EmpDegreesRepository _repository;

  EmpDegreesController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<EmpDegreesModel> empDegrees = <EmpDegreesModel>[].obs;

  get length => empDegrees.length;

  final TextEditingController id = TextEditingController();
  final TextEditingController type = TextEditingController();
  final TextEditingController martaba = TextEditingController();
  final TextEditingController draga = TextEditingController();
  final TextEditingController salary = TextEditingController();
  final TextEditingController elawa = TextEditingController();
  final TextEditingController naqlBadal = TextEditingController();
  final TextEditingController inEntedabBadal = TextEditingController();
  final TextEditingController outEntedabBadal = TextEditingController();

  Future<void> findAll() async {
    isLoading(true);
    messageError("");
    final data = await _repository.findAll();
    data.fold((l) => messageError(l.eerMessage), (r) => empDegrees(r));
    isLoading(false);
  }

  Future<void> save() async {
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      EmpDegreesModel(
        id: int.parse(id.text),
        type: double.parse(type.text),
        martaba: double.parse(martaba.text),
        draga: double.parse(draga.text),
        elawa: double.parse(elawa.text),
        naqlBadal: double.parse(naqlBadal.text),
        salary: double.parse(salary.text),
        inEntedabBadal: double.parse(inEntedabBadal.text),
        outEntedabadal: double.parse(outEntedabBadal.text),
      ),
    );
    data.fold((l) => messageError(l.eerMessage), (r) => r);
    isLoading(false);
    if (messageError.isEmpty) {
      findAll();
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
      findAll();
      customSnackBar(title: 'تم', message: 'تم الحذف بنجاح');
      return;
    }
    customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  }

  void clearControllers() {
    id.text = getId().toString();
    type.clear();
    martaba.clear();
    draga.clear();
    salary.clear();
    elawa.clear();
    naqlBadal.clear();
    inEntedabBadal.clear();
    outEntedabBadal.clear();
  }

  @override
  void onInit() async {
    await findAll();
    id.text = getId().toString();
    super.onInit();
  }

  void confirmDelete(int id, {bool withGoBack = true}) async {
    await alertDialog(
      title: 'تحذير',
      middleText: "هل تريد حذف درجة العمال بالفعل",
      onPressedConfirm: () {
        if (withGoBack) {
          Get.back();
        }
        delete(id);
      },
    );
  }

  // حل مبدأي
  int getId() {
    int max = 0;
    for (EmpDegreesModel m in empDegrees) {
      if (m.id! > max) {
        max = m.id!;
      }
    }
    return max + 1;
  }

  void fillControllers(Map<String, PlutoCell> cells) {
    id.text = cells['id']!.value.toString();
    type.text = cells['type']!.value.toString();
    martaba.text = cells['martaba']!.value.toString();
    draga.text = cells['draga']!.value.toString();
    salary.text = cells['salary']!.value.toString();
    elawa.text = cells['elawa']!.value.toString();
    naqlBadal.text = cells['naqlBadal']!.value.toString();
    inEntedabBadal.text = cells['inEntedabBadal']!.value.toString();
    outEntedabBadal.text = cells['outEntedabBadal']!.value.toString();
  }
}
