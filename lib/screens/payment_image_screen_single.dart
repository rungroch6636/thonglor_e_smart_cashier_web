// // ignore_for_file: use_build_context_synchronously, must_be_immutable

// import 'dart:convert';

// //import 'package:dio/dio.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:thonglor_e_smart_cashier_web/models/paymentDetailImage_model.dart';

// class PaymentImageSingleScreen extends StatefulWidget {
//   List<PaymentDetailImageModel> lPaymentImageByType = [];

//   PaymentImageSingleScreen({required this.lPaymentImageByType, super.key});

//   @override
//   State<PaymentImageSingleScreen> createState() =>
//       _PaymentImageSingleScreenState();
// }

// class _PaymentImageSingleScreenState extends State<PaymentImageSingleScreen> {
//   List<PaymentDetailImageModel> lPaymentImage = [];
//   bool isHover = false;

//   bool isCheckRun = false;

//   var _paths;

//   @override
//   void setState(VoidCallback fn) {
//     lPaymentImage = widget.lPaymentImageByType;
//     // TODO: implement setState
//     super.setState(fn);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//         borderRadius: BorderRadius.circular(16),
//         child: SizedBox(
//             height: 400,
//             width: 600,
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const SizedBox(
//                       width: 40,
//                     ),
//                     Text('IMAGE'),
//                     Align(
//                       alignment: Alignment.topCenter,
//                       child: SizedBox(
//                         width: 40,
//                         child: IconButton(
//                           icon: const Icon(
//                             Icons.cancel,
//                             color: Colors.red,
//                           ),
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Container(
//                     height: 200,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       //color: Color.fromARGB(255, 183, 191, 219),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Color.fromARGB(255, 162, 162, 167),
//                           //offset: Offset(-2, -2),
//                         ),
//                         BoxShadow(
//                           color: Color.fromARGB(238, 211, 213, 218),
//                           spreadRadius: -1.0,
//                           offset: Offset(1, 1),
//                           blurRadius: 1.0,
//                         ),
//                       ],
//                     ),
//                     child: lPaymentImage.isEmpty
//                         ? const Center(
//                             child: Text('Select Image'),
//                           )
//                         : ListView(
//                             scrollDirection: Axis.horizontal,
//                             children: const [
//                                 Padding(
//                                   padding: EdgeInsets.all(4.0),
//                                   child: Icon(Icons.picture_as_pdf_rounded),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.all(4.0),
//                                   child: Icon(Icons.picture_as_pdf_rounded),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.all(4.0),
//                                   child: Icon(Icons.picture_as_pdf_rounded),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.all(4.0),
//                                   child: Icon(Icons.picture_as_pdf_rounded),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.all(4.0),
//                                   child: Icon(Icons.picture_as_pdf_rounded),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.all(4.0),
//                                   child: Icon(Icons.picture_as_pdf_rounded),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.all(4.0),
//                                   child: Icon(Icons.picture_as_pdf_rounded),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.all(4.0),
//                                   child: Icon(Icons.picture_as_pdf_rounded),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.all(4.0),
//                                   child: Icon(Icons.picture_as_pdf_rounded),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.all(4.0),
//                                   child: Icon(Icons.picture_as_pdf_rounded),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.all(4.0),
//                                   child: Icon(Icons.picture_as_pdf_rounded),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.all(4.0),
//                                   child: Icon(Icons.picture_as_pdf_rounded),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.all(4.0),
//                                   child: Icon(Icons.picture_as_pdf_rounded),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.all(4.0),
//                                   child: Icon(Icons.picture_as_pdf_rounded),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.all(4.0),
//                                   child: Icon(Icons.picture_as_pdf_rounded),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.all(4.0),
//                                   child: Icon(Icons.picture_as_pdf_rounded),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.all(4.0),
//                                   child: Icon(Icons.picture_as_pdf_rounded),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.all(4.0),
//                                   child: Icon(Icons.picture_as_pdf_rounded),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.all(4.0),
//                                   child: Icon(Icons.picture_as_pdf_rounded),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.all(4.0),
//                                   child: Icon(Icons.picture_as_pdf_rounded),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.all(4.0),
//                                   child: Icon(Icons.picture_as_pdf_rounded),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.all(4.0),
//                                   child: Icon(Icons.picture_as_pdf_rounded),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.all(4.0),
//                                   child: Icon(Icons.picture_as_pdf_rounded),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.all(4.0),
//                                   child: Icon(Icons.picture_as_pdf_rounded),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.all(4.0),
//                                   child: Icon(Icons.picture_as_pdf_rounded),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.all(4.0),
//                                   child: Icon(Icons.picture_as_pdf_rounded),
//                                 ),
//                               ]),
//                   ),
//                 ),
//                 Expanded(child: Text('data')),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 16.0),
//                   child: SizedBox(
//                     width: 200,
//                     child: ElevatedButton(
//                       onHover: (value) {
//                         setState(() => isHover = value);
//                       },
//                       style: ElevatedButton.styleFrom(
//                           foregroundColor: isCheckRun
//                               ? null
//                               : isHover
//                                   ? Colors.green[900]
//                                   : Colors.green,
//                           backgroundColor: isCheckRun
//                               ? Colors.grey[600]
//                               : isHover
//                                   ? Colors.green[100]
//                                   : Colors.white,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(50))),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: isCheckRun
//                             ? const Center(child: Text(' Loading... '))
//                             : const Center(child: Text(' Upload ')),
//                       ),
//                       onPressed: () async {
//                         if (isCheckRun == false) {
//                           upload_pdf();
//                           setState(() {
//                             isCheckRun = true;
//                           });

//                           setState(() {
//                             isCheckRun = false;
//                           });
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             )));
//   }

//   void upload_pdf() async {
//     try {
//       _paths = (await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: [
//           'png',
//           'jpg',
//           'jpeg'
//         ], //['pdf', 'png', 'jpg', 'jpeg'],
//         allowMultiple: false,
//         onFileLoading: (FilePickerStatus status) => print(status),
//       ))
//           ?.files;
//     } on PlatformException {
//       //print('PlatformEx  ${e.toString()}');
//     } catch (e) {
//       print("Error ${e.toString()}");
//     }
//     String base64string = '';
//     String imgLastName = _paths!.first.name!.split('.').last;

//     if (_paths != null) {
//       if (_paths != null) {
//         print(_paths!.first.name!);
//         print(imgLastName);
//         base64string = base64
//             .encode(_paths!.first.bytes!); //convert bytes to base64 string
//         //print(base64string);
//       }
//     }
//     showDialog(
//         barrierDismissible: false,
//         context: context,
//         builder: (context) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 200, horizontal: 300),
//             child: Card(
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Image.memory(
//                       base64.decode(base64string),
//                       fit: BoxFit.contain, // ปรับขนาดรูปภาพให้พอดีกับ widget
//                     ),
//                   ),
//                   Expanded(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         TextFormField(
//                           autofocus: true,
//                           decoration: InputDecoration(labelText: "Comment"),
//                         ),
//                         ElevatedButton(
//                           child: Text('Confirm'),
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                         )
//                       ],
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.topCenter,
//                     child: SizedBox(
//                       width: 40,
//                       child: IconButton(
//                         icon: const Icon(
//                           Icons.cancel,
//                           color: Colors.red,
//                         ),
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//     // FormData formData =
//     //     FormData.fromMap({"base64data": base64string, "lastname": imgLastName});
//     // var response = await Dio()
//     //     .post("http://localhost/apiTLDeposit/uploadfile.php", data: formData);

//     // print(response.statusCode);
//   }
// }
