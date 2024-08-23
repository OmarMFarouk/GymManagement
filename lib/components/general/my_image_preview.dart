import 'dart:io';

import 'package:flutter/material.dart';

class MyImagePreview {
  static previewImage({required String path, required BuildContext context}) {
    return showDialog(
        context: context,
        builder: (context) => Dialog(
              child: Container(
                height: 450,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      fit: BoxFit.fill, image: FileImage(File(path))),
                ),
              ),
            ));
  }
}
