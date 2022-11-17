import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void openModalBottomSheet(BuildContext context, Widget content) {
  var size = MediaQuery.of(context).size;

  int current = 0;

  showModalBottomSheet(
      context: context,
      elevation: 3,
      constraints:
          BoxConstraints(maxHeight: size.height * .25, minWidth: size.width),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24))),
      builder: (context) {
        return content;
      });
}

Future<void> pickFileFromOs() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    print(result.files);
  } else {
    print("Cant");
  }
}
