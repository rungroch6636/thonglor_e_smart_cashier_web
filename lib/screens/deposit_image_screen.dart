// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:thonglor_e_smart_cashier_web/models/depositImageTemp_model.dart';

import '../models/depositImage_model.dart';
import '../util/constant.dart';

class DepositImageScreen extends StatefulWidget {
  List<DepositImageTempModel> lDepositImage;
  List<DepositImageModel> lDepositImageDB;
  String isStatusScreen;

  String depositId;
  Function callbackFunctions;
  Function callbackChangeComment;
  Function callbackRemove;

  DepositImageScreen(
      {required this.lDepositImage,
      required this.lDepositImageDB,
      required this.isStatusScreen,
      required this.depositId,
      required this.callbackFunctions,
      required this.callbackChangeComment,
      required this.callbackRemove,
      super.key});

  @override
  State<DepositImageScreen> createState() => _DepositImageScreenState();
}

class _DepositImageScreenState extends State<DepositImageScreen> {
  List<DepositImageTempModel> lDepositImage = [];
  List<DepositImageModel> lDepositImageDB = [];
  List<TextEditingController> lImageControllers = [];
  List<String> lImageOverSize = [];
  bool isHover = false;
  bool isCheckRun = false;

  var _paths;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.lDepositImage.isNotEmpty) {
      lDepositImage.addAll(widget.lDepositImage);

      for (var i = 0; i < lDepositImage.length; i++) {
        lImageControllers.add(TextEditingController());
        lImageControllers[i].text =
            lDepositImage[i].tldeposit_image_description;
      }
    }
    if (widget.lDepositImageDB.isNotEmpty) {
      lDepositImageDB = widget.lDepositImageDB;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
            height: 400,
            width: 600,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 40,
                    ),
                    const Text('IMAGE'),
                    Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: 40,
                        child: IconButton(
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: 240,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        //color: Color.fromARGB(255, 183, 191, 219),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 162, 162, 167),
                            //offset: Offset(-2, -2),
                          ),
                          BoxShadow(
                            color: Color.fromARGB(238, 211, 213, 218),
                            spreadRadius: -1.0,
                            offset: Offset(1, 1),
                            blurRadius: 1.0,
                          ),
                        ],
                      ),
                      child: lDepositImage.isEmpty
                          ? const Center(
                              child: Text('Select Image'),
                            )
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: lDepositImage.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  width: 140,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 4),
                                        child: InkWell(
                                          onTap: () {
                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 20,
                                                        horizontal: 200),
                                                    child: Card(
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Column(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          16.0),
                                                                  child:
                                                                      Container(
                                                                    child:
                                                                        TextFormField(
                                                                      autofocus:
                                                                          true,
                                                                      decoration:
                                                                          const InputDecoration(
                                                                              labelText: "Comment"),
                                                                      controller:
                                                                          lImageControllers[
                                                                              index],
                                                                      onChanged:
                                                                          (value) {
                                                                        lDepositImage[index]
                                                                            .tldeposit_image_description = lImageControllers[
                                                                                index]
                                                                            .text;
                                                                        if (widget.isStatusScreen !=
                                                                            'New') {
                                                                          widget
                                                                              .callbackChangeComment(lDepositImage[index]
                                                                            );
                                                                        }
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child:
                                                                        InteractiveViewer(
                                                                      boundaryMargin: const EdgeInsets
                                                                          .all(
                                                                          20.0), // ระยะขอบเพื่อให้ไม่ซ่อนโค้ดส่วนอื่น
                                                                      minScale:
                                                                          0.1,
                                                                      maxScale:
                                                                          3.0,
                                                                      child: lDepositImage[index]
                                                                              .tldeposit_image_base64
                                                                              .isEmpty

                                                                          //! todoหมุนรูปreqByFIN
                                                                          ? Transform
                                                                              .rotate(
                                                                              angle: 0 * pi / 180,
                                                                              child: Container(
                                                                                width: MediaQuery.of(context).size.width / 1.5,
                                                                                child: Image.network(
                                                                                  lDepositImageDB.where((e) => e.tldeposit_image_id == lDepositImage[index].tldeposit_image_id).first.tldeposit_image_path,
                                                                                  fit: BoxFit.contain,
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : Container(
                                                                              width: MediaQuery.of(context).size.width / 1.5,
                                                                              child: Image.memory(
                                                                                base64.decode(lDepositImage[index].tldeposit_image_base64),
                                                                                fit: BoxFit.contain, // ปรับขนาดรูปภาพให้พอดีกับ widget
                                                                              ),
                                                                            ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 50,
                                                                  height: 50,
                                                                  // child: Card(
                                                                  //   child: Icon(
                                                                  //       Icons
                                                                  //           .rotate_right_outlined,
                                                                  //       size:
                                                                  //           50),
                                                                  // )
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 60,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                IconButton(
                                                                  icon:
                                                                      const Icon(
                                                                    Icons
                                                                        .cancel,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child:
                                                                      IconButton(
                                                                    icon: Icon(
                                                                      Icons
                                                                          .delete_forever_rounded,
                                                                      size: 32,
                                                                      color: widget.isStatusScreen != 'New' &&
                                                                              lDepositImage[index].tldeposit_image_base64.isNotEmpty
                                                                          ? Colors.red[200]
                                                                          : widget.isStatusScreen != 'New'
                                                                              ? Colors.grey
                                                                              : Colors.red[200],
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      if (widget
                                                                              .isStatusScreen !=
                                                                          'New') {
                                                                        if (lDepositImage[index]
                                                                            .tldeposit_image_base64
                                                                            .isNotEmpty) {
                                                                          widget
                                                                              .callbackRemove(lDepositImage[index].tldeposit_image_id);

                                                                          lDepositImage
                                                                              .removeAt(index);
                                                                          lImageControllers
                                                                              .removeAt(index);

                                                                          setState(
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          });
                                                                        }
                                                                      } else {
                                                                        widget.callbackRemove(
                                                                            lDepositImage[index].tldeposit_image_id);

                                                                        lDepositImage
                                                                            .removeAt(index);
                                                                        lImageControllers
                                                                            .removeAt(index);

                                                                        setState(
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        });
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          child: SizedBox(
                                            height: 160,
                                            child: Align(
                                              alignment: Alignment.topCenter,
                                              child: lDepositImage[index]
                                                      .tldeposit_image_base64
                                                      .isEmpty
                                                  ? Image.network(
                                                      lDepositImageDB
                                                          .where((e) =>
                                                              e.tldeposit_image_id ==
                                                              lDepositImage[
                                                                      index]
                                                                  .tldeposit_image_id)
                                                          .first
                                                          .tldeposit_image_path,
                                                      fit: BoxFit.contain,
                                                    )
                                                  : Image.memory(
                                                      base64.decode(lDepositImage[
                                                              index]
                                                          .tldeposit_image_base64),
                                                      fit: BoxFit
                                                          .fitHeight // ปรับขนาดรูปภาพให้พอดีกับ widget
                                                      ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 2),
                                        child: Container(
                                            child: TextFormField(
                                          decoration: const InputDecoration(
                                              labelText: "Comment"),
                                          controller: lImageControllers[index],
                                          onChanged: (value) {
                                            lDepositImage[index]
                                                    .tldeposit_image_description =
                                                lImageControllers[index].text;
                                            if (widget.isStatusScreen !=
                                                'New') {
                                              widget.callbackChangeComment(lDepositImage[index]);
                                            }
                                          },
                                        )),
                                      )
                                    ],
                                  ),
                                );
                              })),
                ),
                const Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onHover: (value) {
                        setState(() => isHover = value);
                      },
                      style: ElevatedButton.styleFrom(
                          foregroundColor: isCheckRun
                              ? null
                              : isHover
                                  ? Colors.green[900]
                                  : Colors.green,
                          backgroundColor: isCheckRun
                              ? Colors.grey[600]
                              : isHover
                                  ? Colors.green[100]
                                  : Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: isCheckRun
                            ? const Center(child: Text(' Loading... '))
                            : const Center(
                                child: SizedBox(child: Text(' Upload '))),
                      ),
                      onPressed: () async {
                        if (isCheckRun == false) {
                          upload_pdf();
                          setState(() {
                            isCheckRun = true;
                          });

                          setState(() {
                            isCheckRun = false;
                          });
                        }
                      },
                    ),
                  ),
                ),
              ],
            )));
  }

  void upload_pdf() async {
    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'png',
          'jpg',
          'jpeg'
        ], //['pdf', 'png', 'jpg', 'jpeg'],
        allowMultiple: true,
        onFileLoading: (FilePickerStatus status) => print(status),
      ))
          ?.files;
    } on PlatformException {
      //print('PlatformEx  ${e.toString()}');
    } catch (e) {
      print("Error ${e.toString()}");
    }
    String imgLastName = _paths!.first.name!.split('.').last;

    if (_paths != null) {
      if (_paths != null) {
        for (var i = 0; i < _paths!.length; i++) {
          String id = '${TlConstant.runID()}${i.toString().padLeft(3, '0')}';

          String base64string = base64.encode(_paths![i].bytes!);

          DepositImageTempModel newImage = DepositImageTempModel(
              tldeposit_image_id: id,
              tldeposit_image_base64: base64string,
              tldeposit_image_lastName: imgLastName,
              tldeposit_image_description: '',
              tldeposit_id: widget.depositId);

          lDepositImage.add(newImage);
          lImageControllers.add(TextEditingController());
          lImageControllers[i].text =
              lDepositImage[i].tldeposit_image_description;
        }

        widget.callbackFunctions(lDepositImage);
        setState(() {});
      }
    }
  }

  // 1. compress file and get Uint8List
  Future<Uint8List?> testCompressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 2300,
      minHeight: 1500,
      quality: 94,
      rotate: 90,
    );
    print(file.lengthSync());
    print(result?.length);
    return result;
  }
}
