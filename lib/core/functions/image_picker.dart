import 'dart:async';

import 'dart:html' as html;

class WebImagePicker {
  Future<String?> pickImage() async {
    final completer = Completer<String?>();

    final uploadInput = html.FileUploadInputElement();

    uploadInput.accept = 'image/*';

    uploadInput.click();

    uploadInput.onChange.listen((e) async {
      final files = uploadInput.files;

      if (files!.isEmpty) {
        completer.complete(null);

        return;
      }

      final reader = html.FileReader();

      reader.readAsDataUrl(files[0]);

      reader.onLoadEnd.listen((e) {
        completer.complete(reader.result as String);
      });
    });

    return completer.future;
  }
}
