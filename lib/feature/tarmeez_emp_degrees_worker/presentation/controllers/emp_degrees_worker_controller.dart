import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../data/model/emp_degrees_worker_model.dart';
import '../../data/repository/emp_degrees_worker_repository.dart';

class EmpDegreesWorkerController extends GetxController {
  final EmpDegreesWorkerRepository _repository;

  EmpDegreesWorkerController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<EmpDegreesWorkerModel> empDegreesWorker =
      <EmpDegreesWorkerModel>[].obs;

  get length => empDegreesWorker.length;

  final TextEditingController id = TextEditingController();

  final TextEditingController fia = TextEditingController();
  final TextEditingController draga = TextEditingController();
  final TextEditingController salary = TextEditingController();
  final TextEditingController naqlBadal = TextEditingController();
  final TextEditingController elawa = TextEditingController();

  Future<void> findAll() async {
    isLoading(true);
    messageError("");
    final data = await _repository.findAll();
    data.fold((l) => messageError(l.eerMessage), (r) => empDegreesWorker(r));
    isLoading(false);
  }

  Future<void> save() async {
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      EmpDegreesWorkerModel(
        id: int.parse(id.text),
        fia: fia.text,
        draga: double.parse(draga.text),
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
    fia.clear();
    draga.clear();
    elawa.clear();
    naqlBadal.clear();
    salary.clear();
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
    for (EmpDegreesWorkerModel m in empDegreesWorker) {
      if (m.id! > max) {
        max = m.id!;
      }
    }
    return max + 1;
  }

  void fillControllers(Map<String, PlutoCell> cells) {
    id.text = cells['id']!.value.toString();
    fia.text = cells['fia']!.value.toString();
    draga.text = cells['draga']!.value.toString();
    salary.text = cells['salary']!.value.toString();
    elawa.text = cells['elawa']!.value.toString();
    naqlBadal.text = cells['naqlBadal']!.value.toString();
  }
}
