import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../data/model/emp_mobashra_model.dart';
import '../../data/repository/emp_mobashra_repository.dart';

class EmpMobashraController extends GetxController {
  final EmpMobashraRepository _repository;

  EmpMobashraController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<EmpMobashraSearchModel> empMobashras = <EmpMobashraSearchModel>[].obs;

  final TextEditingController name = TextEditingController();
  final TextEditingController cardId = TextEditingController();
  final TextEditingController empType = TextEditingController();

  Future<void> findAll() async {
    isLoading(true);
    messageError("");
    final data = await _repository.search(
      name: name.text,
      cardId: cardId.text,
      empType: empType.text,
    );
    data.fold((l) => messageError(l.eerMessage), (r) => empMobashras(r));
    isLoading(false);
  }

  Future<void> save() async {
    isLoading(true);
    messageError("");
    // TODO add text field
    final data = await _repository.save(
      EmpMobashraModel(
          // id: int.parse(id.text),
          // name: name.text,
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
    name.clear();
    cardId.clear();
  }

  @override
  void onInit() {
    // findAll();
    super.onInit();
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

  // حل مبدأي
  // int getId() {
  //   int max = 0;
  //   for (EmpMobashraModel m in empMobashras) {
  //     if (m.id! > max) {
  //       max = m.id!;
  //     }
  //   }
  //   return max + 1;
  // }

  void fillControllers(Map<String, PlutoCell> cells) {
    // id.text = cells['id']!.value.toString();
    // name.text = cells['name']!.value.toString();
  }
}
