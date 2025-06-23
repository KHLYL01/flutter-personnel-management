import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/src/model/pluto_cell.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../data/model/nations_model.dart';
import '../../data/repository/nations_repository.dart';

class NationsController extends GetxController {
  final NationsRepository _repository;

  NationsController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<NationsModel> nations = <NationsModel>[].obs;

  get length => nations.length;

  final TextEditingController id = TextEditingController();
  final TextEditingController name = TextEditingController();

  Future<void> findAll() async {
    isLoading(true);
    messageError("");
    final data = await _repository.findAll();
    data.fold((l) => messageError(l.eerMessage), (r) => nations(r));
    isLoading(false);
  }

  Future<void> findNations() async {
    isLoading(true);
    messageError("");
    final data = await _repository.findNations(
      id: id.text == "" ? null : int.parse(id.text),
      name: name.text,
    );
    data.fold((l) => messageError(l.eerMessage), (r) => nations(r));
    isLoading(false);
  }

  Future<void> save() async {
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      NationsModel(
        id: int.parse(id.text),
        name: name.text,
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
      middleText: "هل تريد حذف الجنسية بالفعل",
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
    for (NationsModel m in nations) {
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

  void clearControllersForSearch() {
    id.clear();
    name.clear();
    findNations();
  }
}
