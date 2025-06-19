import 'package:get/get.dart';

class ScreenPermission {
  String group;
  String screenName;
  RxBool canEnter;
  RxBool canSave;
  RxBool canEdit;
  RxBool canDelete;

  ScreenPermission({
    required this.group,
    required this.screenName,
    bool enter = false,
    bool save = false,
    bool edit = false,
    bool delete = false,
  })  : canEnter = enter.obs,
        canSave = save.obs,
        canEdit = edit.obs,
        canDelete = delete.obs;
}
