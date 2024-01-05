import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TextFormFieldPDComment extends StatefulWidget {
  String isStatusScreen;
  //List<PaymentDetailModel> lPaymentDetail;
  String paymentDetailId;
  String paymentDetailComment;

  Function callbackComment;

  TextFormFieldPDComment(
      {required this.isStatusScreen,
      //required this.lPaymentDetail,
      required this.paymentDetailId,
      required this.paymentDetailComment,
      required this.callbackComment,
      super.key});

  @override
  State<TextFormFieldPDComment> createState() => _TextFormFieldPDCommentState();
}

class _TextFormFieldPDCommentState extends State<TextFormFieldPDComment> {
  double dTotalActual = 0.0;
  TextEditingController tCommentController = TextEditingController();
  final oCcy = NumberFormat(
    "#,##0.00",
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tCommentController.text = widget.paymentDetailComment;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.isStatusScreen == 'waiting' ||
              widget.isStatusScreen == 'confirm'
          ? Colors.grey[300]
          : Colors.transparent,
      child: TextFormField(
        readOnly: widget.isStatusScreen == 'waiting' ||
                widget.isStatusScreen == 'confirm'
            ? true
            : false, // 'New'  'create' 'reject'
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 8),
        ),
        controller: tCommentController,
        onChanged: (value) {
          widget.callbackComment(tCommentController.text);
          setState(() {});
        },
      ),
    );
  }
}
