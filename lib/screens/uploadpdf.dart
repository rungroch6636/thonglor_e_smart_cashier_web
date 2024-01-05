// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:convert';


import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UploadPDF extends StatefulWidget {
  const UploadPDF({super.key});

  @override
  State<UploadPDF> createState() => _UploadPDFState();
}

class _UploadPDFState extends State<UploadPDF> {
  var _paths;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: ElevatedButton(
            child: const Text('Upload PDF'),
            onPressed: () async {
              upload_pdf();
            },
          ),
        ),
      ),
    );
  }

  void upload_pdf() async {
    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => print(status),
      ))
          ?.files;
    } on PlatformException {
      //print('PlatformEx  ${e.toString()}');
    } catch (e) {
      print("Error ${e.toString()}");
    }
    String base64string = '';
    String imgLastName = _paths!.first.name!.split('.').last;

    if (_paths != null) {
      if (_paths != null) {
        print(_paths!.first.name!);
        print(imgLastName);
        base64string = base64
            .encode(_paths!.first.bytes!); //convert bytes to base64 string
        //print(base64string);
      }
    }
    FormData formData =
        FormData.fromMap({"base64data": base64string, "lastname": imgLastName});
    var response = await Dio()
        .post("http://localhost/apiTLDeposit/uploadfile.php", data: formData);

    print(response.statusCode);
  }
}
