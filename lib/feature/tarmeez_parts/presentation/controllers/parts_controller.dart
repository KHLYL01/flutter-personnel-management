import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../data/model/parts_model.dart';
import '../../data/repository/parts_repository.dart';

class PartsController extends GetxController {
  final PartsRepository _repository;

  PartsController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<PartsModel> parts = <PartsModel>[].obs;

  get length => parts.length;

  final TextEditingController id = TextEditingController();
  final TextEditingController name = TextEditingController();

  Future<void> findAll() async {
    isLoading(true);
    messageError("");
    final data = await _repository.findAll();
    data.fold((l) => messageError(l.eerMessage), (r) => parts(r));
    isLoading(false);
  }

  Future<void> findParts() async {
    isLoading(true);
    messageError("");
    final data = await _repository.findParts(
      id: id.text == "" ? null : int.parse(id.text),
      name: name.text,
    );
    data.fold((l) => messageError(l.eerMessage), (r) => parts(r));
    isLoading(false);
  }

  Future<void> save() async {
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      PartsModel(
        id: int.parse(id.text),
        name: name.text,
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
    name.clear();
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
      middleText: "هل تريد حذف القسم بالفعل",
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
    for (PartsModel m in parts) {
      if (m.id! > max) {
        max = m.id!;
      }
    }
    return max + 1;
  }

  void fillControllers(Map<String, PlutoCell> cells) {
    id.text = cells['id']!.value.toString();
    name.text = cells['name']!.value.toString();
  }

  clearControllersForSearch() {
    id.text = getId().toString();
    name.clear();
  }
}
