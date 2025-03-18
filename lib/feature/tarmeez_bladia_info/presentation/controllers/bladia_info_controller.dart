import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:personnel_management/feature/tarmeez_bladia_info/data/model/bladia_info_model.dart';
import 'package:personnel_management/feature/tarmeez_bladia_info/data/repository/bladia_info_repository.dart';
import '../../../../../core/functions/image_picker.dart';

class BladiaInfoController extends GetxController {
  final BladiaInfoRepository _repository;

  BladiaInfoController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  Rx<BladiaInfoModel> bladia = Rx(BladiaInfoModel());

  final TextEditingController datBegin = TextEditingController();
  final TextEditingController datEnd = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController boss = TextEditingController();
  final TextEditingController deputyMayor = TextEditingController();
  final TextEditingController modeerIdaraShoonMaliaIdarea =
      TextEditingController();
  final TextEditingController partBoss = TextEditingController();
  final TextEditingController part2Boss = TextEditingController();
  final TextEditingController maliaBoss = TextEditingController();
  final TextEditingController modeerShoonMalia = TextEditingController();
  final TextEditingController emp = TextEditingController();
  final TextEditingController empHelp = TextEditingController();
  final TextEditingController ma3esha = TextEditingController();
  final TextEditingController workStationBoss = TextEditingController();
  final TextEditingController ipan = TextEditingController();

  var municipalitySymbol = ''.obs;

  Future<void> findAll() async {
    isLoading(true);
    messageError("");
    final data = await _repository.findAll();
    data.fold((l) => messageError(l.eerMessage), (r) => bladia(r));
    fillController();
    isLoading(false);
  }

  void pickImage() async {
    final picker = WebImagePicker();
    final image = await picker.pickImage();

    if (image != null) {
      municipalitySymbol.value = image;
    }
  }

  void fillController() {
    name.text = bladia.value.bladiaInfo?.nameAr ?? '';
    boss.text = bladia.value.bladiaInfo?.boss ?? '';

    // deputyMayor.text = bladia.value.empPartInfo?.partBoss ?? '';
    // modeerIdaraShoonMaliaIdarea.text = bladia.value.empPartInfo?.maliaBoss ?? '';

    partBoss.text = bladia.value.empPartInfo?.partBoss ?? '';
    part2Boss.text = bladia.value.empPartInfo?.part2Boss ?? '';
    maliaBoss.text = bladia.value.empPartInfo?.maliaBoss ?? '';
    emp.text = bladia.value.empPartInfo?.emp ?? '';
    empHelp.text = bladia.value.empPartInfo?.empHelp ?? '';
    ma3esha.text = bladia.value.empPartInfo?.ma3esha.toString() ?? '';
    workStationBoss.text = bladia.value.empPartInfo?.workStationBoss ?? '';
    ipan.text = bladia.value.bladiaInfo?.ipan ?? '';

    datBegin.text = bladia.value.bladiaInfo?.datBegin ?? '';
    datEnd.text = bladia.value.bladiaInfo?.datEnd ?? '';
  }

  @override
  void onInit() {
    findAll();
    super.onInit();
  }
}
