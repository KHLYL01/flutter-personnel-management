import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/src/model/pluto_cell.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../data/model/badal_model.dart';
import '../../data/repository/badal_repository.dart';

class BadalController extends GetxController {
  final BadalRepository _repository;

  BadalController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<BadalModel> badals = <BadalModel>[].obs;

  get length => badals.length;

  final TextEditingController id = TextEditingController();
  final TextEditingController martaba = TextEditingController();
  final TextEditingController internal = TextEditingController();
  final TextEditingController classA = TextEditingController();
  final TextEditingController classB = TextEditingController();
  final TextEditingController classC = TextEditingController();
  final TextEditingController highLiving = TextEditingController();

  Future<void> findAll() async {
    isLoading(true);
    messageError("");
    final data = await _repository.findAll();
    data.fold((l) => messageError(l.eerMessage), (r) => badals(r));
    isLoading(false);
  }

  Future<void> save() async {
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      BadalModel(
        id: int.parse(id.text),
        classA: int.parse(classA.text),
        classB: int.parse(classB.text),
        classC: int.parse(classC.text),
        highLiving: int.parse(highLiving.text),
        internal: int.parse(internal.text),
        martaba: int.parse(martaba.text),
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
    martaba.clear();
    internal.clear();
    classA.clear();
    classB.clear();
    classC.clear();
    highLiving.clear();
  }

  void fillControllers(Map<String, PlutoCell> cells) {
    id.text = cells['id']!.value.toString();
    martaba.text = cells['martaba']!.value.toString();
    internal.text = cells['internal']!.value.toString();
    classA.text = cells['classA']!.value.toString();
    classB.text = cells['classB']!.value.toString();
    classC.text = cells['classC']!.value.toString();
    highLiving.text = cells['highLiving']!.value.toString();
  }

  @override
  void onInit() {
    findAll();
    super.onInit();
  }

  void confirmDelete(int id, {bool withGoBack = true}) async {
    await alertDialog(
      title: 'تحذير',
      middleText: "هل تريد حذف البدل بالفعل",
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
    for (BadalModel m in badals) {
      if (m.id! > max) {
        max = m.id!;
      }
    }
    return max + 1;
  }
}
