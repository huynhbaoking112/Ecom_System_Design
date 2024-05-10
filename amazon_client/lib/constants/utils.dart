import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

Future<List<File>> pickImages() async {

  List<File> images = [];

  try {
  FilePickerResult? files = await FilePicker.platform.pickFiles(allowMultiple: true, type: FileType.image);
  
  if(files != null  && files.files.isNotEmpty){
    // for(int i =0; i<files.files.length; i++){
    //   images.add(File(files.files[i].path!));
    // }

    images = files.files.map((e) => File(e.path!)).toList();

  }

  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}