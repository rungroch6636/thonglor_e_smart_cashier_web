// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thonglor_e_smart_cashier_web/models/paymentDetailImage_model.dart';

import '../models/paymentDetailImageTemp_model.dart';

class PaymentImageScreen extends StatefulWidget {
  List<PaymentDetailImageTempModel> lPaymentImageByType;
  List<PaymentDetailImageModel> lPaymentImageDBByType;
  String paymentDetailId;
  String paymentId;
  String isStatusScreen;
  Function callbackFunctions;
  Function callbackComment;
  Function callbackRemove;

  PaymentImageScreen(
      {required this.lPaymentImageByType,
      required this.lPaymentImageDBByType,
      required this.paymentDetailId,
      required this.paymentId,
      required this.isStatusScreen,
      required this.callbackFunctions,
      required this.callbackComment,
      required this.callbackRemove,
      super.key});

  @override
  State<PaymentImageScreen> createState() => _PaymentImageScreenState();
}

class _PaymentImageScreenState extends State<PaymentImageScreen> {
  List<PaymentDetailImageTempModel> lPaymentImage = [];
  List<PaymentDetailImageModel> lPaymentImageDB = [];

  List<TextEditingController> lImageControllers = [];
  List<String> lImageOverSize = [];
  bool isHover = false;
  bool isCheckRun = false;

  var _paths;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.lPaymentImageByType.isNotEmpty) {
      lPaymentImage = widget.lPaymentImageByType;

      for (var i = 0; i < lPaymentImage.length; i++) {
        lImageControllers.add(TextEditingController());
        lImageControllers[i].text =
            lPaymentImage[i].tlpayment_image_description;
      }
      if (widget.lPaymentImageDBByType.isNotEmpty) {
        lPaymentImageDB = widget.lPaymentImageDBByType;
      }
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
                      child: lPaymentImage.isEmpty
                          ? const Center(
                              child: Text('Select Image'),
                            )
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: lPaymentImage.length,
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
                                                                      TextFormField(
                                                                    readOnly:
                                                                        false,
                                                                    autofocus:
                                                                        true,
                                                                    decoration: const InputDecoration(
                                                                        labelText:
                                                                            "Comment"),
                                                                    controller:
                                                                        lImageControllers[
                                                                            index],
                                                                    onChanged:
                                                                        (value) {
                                                                      lPaymentImage[
                                                                              index]
                                                                          .tlpayment_image_description = lImageControllers[
                                                                              index]
                                                                          .text;
                                                                      widget
                                                                          .callbackComment(  lPaymentImage[
                                                                              index]);
                                                                    },
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
                                                                      child: lPaymentImage[index]
                                                                              .tlpayment_image_base64
                                                                              .isEmpty
                                                                          ? Container(
                                                                              width: MediaQuery.of(context).size.width / 1.5,
                                                                              child: Image.network(
                                                                                lPaymentImageDB.where((e) => e.tlpayment_detail_image_id == lPaymentImage[index].tlpayment_detail_image_id).first.tlpayment_image_path,
                                                                                fit: BoxFit.contain,
                                                                              ),
                                                                            )
                                                                          : Container(
                                                                              width: MediaQuery.of(context).size.width / 1.5,
                                                                              child: Image.memory(
                                                                                base64.decode(lPaymentImage[index].tlpayment_image_base64),
                                                                                fit: BoxFit.contain, // ปรับขนาดรูปภาพให้พอดีกับ widget
                                                                              ),
                                                                            ),
                                                                    ),
                                                                  ),
                                                                ),
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
                                                                      color: widget.isStatusScreen == 'waiting' ||
                                                                              widget.isStatusScreen ==
                                                                                  'confirm'
                                                                          ? Colors
                                                                              .grey
                                                                          : Colors
                                                                              .red[200],
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      if (widget.isStatusScreen == 'New' ||
                                                                          widget.isStatusScreen ==
                                                                              'create' ||
                                                                          widget.isStatusScreen ==
                                                                              'reject') {
                                                                        widget.callbackRemove(
                                                                            lPaymentImage[index].tlpayment_detail_image_id);

                                                                        lPaymentImage
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
                                              child: lPaymentImage[index]
                                                      .tlpayment_image_base64
                                                      .isEmpty
                                                  ? Image.network(
                                                      lPaymentImageDB
                                                          .where((e) =>
                                                              e.tlpayment_detail_image_id ==
                                                              lPaymentImage[
                                                                      index]
                                                                  .tlpayment_detail_image_id)
                                                          .first
                                                          .tlpayment_image_path,
                                                      fit: BoxFit.fitHeight)
                                                  : Image.memory(
                                                      base64.decode(lPaymentImage[
                                                              index]
                                                          .tlpayment_image_base64),
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
                                        child: TextFormField(
                                          readOnly:
                                              false, // 'New'  'create' 'reject'
                                          decoration: const InputDecoration(
                                              labelText: "Comment"),
                                          controller: lImageControllers[index],
                                          onChanged: (value) {
                                            lPaymentImage[index]
                                                    .tlpayment_image_description =
                                                lImageControllers[index].text;

                                            widget.callbackComment(lPaymentImage[
                                                                              index]);
                                          },
                                        ),
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
                            : const Center(child: Text(' Upload ')),
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
        String runNum = DateTime.now().millisecondsSinceEpoch.toString();
        for (var i = 0; i < _paths!.length; i++) {
          String id = '$runNum${i.toString().padLeft(3, '0')}';
          String base64string = base64.encode(_paths![i].bytes!);

          PaymentDetailImageTempModel newImage = PaymentDetailImageTempModel(
              tlpayment_detail_image_id: id,
              tlpayment_detail_id: widget.paymentDetailId,
              tlpayment_image_base64: base64string,
              tlpayment_image_last_Name: imgLastName,
              tlpayment_image_description: '',
              tlpayment_id: widget.paymentId);

          lPaymentImage.add(newImage);
          lImageControllers.add(TextEditingController());
          lImageControllers[i].text =
              lPaymentImage[i].tlpayment_image_description;
        }

        widget.callbackFunctions(lPaymentImage);
        setState(() {});
      }
    }
  }
}
