import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/src/model/pluto_cell.dart';

import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../data/model/banks_model.dart';
import '../../data/repository/banks_repository.dart';

class BanksController extends GetxController {
  final BanksRepository _repository;

  BanksController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<BanksModel> banks = <BanksModel>[].obs;

  get length => banks.length;

  final TextEditingController id = TextEditingController();
  final TextEditingController name = TextEditingController();

  Future<void> findAll() async {
    isLoading(true);
    messageError("");
    final data = await _repository.findAll();
    data.fold((l) => messageError(l.eerMessage), (r) => banks(r));
    isLoading(false);
  }

  Future<void> findBanks() async {
    isLoading(true);
    messageError("");
    final data = await _repository.findBanks(
      id: id.text,
      name: name.text,
    );
    data.fold((l) => messageError(l.eerMessage), (r) => banks(r));
    isLoading(false);
  }

  Future<void> save() async {
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      BanksModel(
        id: id.text,
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

  Future<void> delete(String id) async {
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
    id.clear();
    name.clear();
  }

  @override
  void onInit() async {
    await findAll();
    super.onInit();
  }

  void confirmDelete(String id, {bool withGoBack = true}) async {
    await alertDialog(
      title: 'تحذير',
      middleText: "هل تريد حذف البنك بالفعل",
      onPressedConfirm: () {
        if (withGoBack) {
          Get.back();
        }
        delete(id);
      },
    );
  }

  void fillControllers(Map<String, PlutoCell> cells) {
    id.text = cells['id']!.value.toString();
    name.text = cells['name']!.value.toString();
  }

  void clearControllersForSearch() {
    id.clear();
    name.clear();
    findBanks();
  }
}
