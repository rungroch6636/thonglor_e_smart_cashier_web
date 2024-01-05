import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../models/paymentDetail_model.dart';

class TextFormFieldActual extends StatefulWidget {
  List<PaymentDetailModel> lPaymentDetail;
  String paymentDetailId;
  String actual;
  String paid_go;
  double dTotalPaid;
  String isStatusScreen;

  Function callbackDiff;
  Function callbackDTotalActual;
  Function callbackDTotalBalance;
  Function callbackLPaymentDetail;

  TextFormFieldActual(
      {required this.lPaymentDetail,
      required this.paymentDetailId,
      required this.actual,
      required this.paid_go,
      required this.dTotalPaid,
      required this.isStatusScreen,
      required this.callbackDiff,
      required this.callbackDTotalActual,
      required this.callbackDTotalBalance,
      required this.callbackLPaymentDetail,
      super.key});

  @override
  State<TextFormFieldActual> createState() => _TextFormFieldActualState();
}

class _TextFormFieldActualState extends State<TextFormFieldActual> {
  double dTotalActual = 0.0;
  TextEditingController tActualController = TextEditingController();
  final oCcy = NumberFormat(
    "#,##0.00",
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tActualController.text = widget.actual;
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
        textAlign: TextAlign.end,
        controller: tActualController,
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            RegExp(r'^-?\d*\.?\d{0,2}$'),
          ),
        ],
        onChanged: (value) {
          if (value.isEmpty) {
            value = '0';
            tActualController.text = '0';
          }
          double diff = double.parse(tActualController.text) -
              double.parse(widget.paid_go);
          if (oCcy.format(diff) == '-0.00') {
            widget.callbackDiff('0');
          } else {
            widget.callbackDiff(diff.toStringAsFixed(2));
          }

          widget.lPaymentDetail
              .where((ee) => ee.tlpayment_detail_id == widget.paymentDetailId)
              .first
              .tlpayment_detail_actual_paid = tActualController.text;

          dTotalActual = 0;
          for (var e in widget.lPaymentDetail) {
            dTotalActual += double.parse(e.tlpayment_detail_actual_paid);
          }

          widget.callbackDTotalActual(dTotalActual);
          widget.callbackDTotalBalance(dTotalActual - widget.dTotalPaid);
          widget.callbackLPaymentDetail(widget.lPaymentDetail);
          setState(() {});
        },
      ),
    );
  }
}
