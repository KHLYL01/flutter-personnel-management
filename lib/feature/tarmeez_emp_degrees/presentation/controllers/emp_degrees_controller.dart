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

  final TextEditingController id = TextEditingController();
  final TextEditingController martaba = TextEditingController();
  final TextEditingController type = TextEditingController();
  final TextEditingController salary = TextEditingController();
  final TextEditingController elawa = TextEditingController();
  final TextEditingController naqlBadal = TextEditingController();

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
        elawa: double.parse(elawa.text),
        naqlBadal: double.parse(naqlBadal.text),
        salary: double.parse(salary.text),
      ),
    );
    data.fold((l) => messageError(l.eerMessage), (r) => r);
    isLoading(false);
    if (messageError.isEmpty) {
      findAll();
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
      return;
    }
    customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  }

  void clearControllers() {
    id.text = getId().toString();
    // name.clear();
  }

  @override
  void onInit() {
    findAll();
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
  }
}
