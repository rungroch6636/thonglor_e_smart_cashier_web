// ignore_for_file: must_be_immutable

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:thonglor_e_smart_cashier_web/models/paymentDetail_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/paymentType_model.dart';

import '../models/paymentTypeDetail_model.dart';
import '../util/constant.dart';

class AddPaymentTypeScreen extends StatefulWidget {
  String paymentId;
  String site;
  List<String> lPaymentDetailTypeIdNotShow;
  Function callbackAddPD;
  Function callbacklPaymentDetailTypeId;
  AddPaymentTypeScreen(
      {required this.paymentId,
      required this.site,
      required this.lPaymentDetailTypeIdNotShow,
      required this.callbackAddPD,
      required this.callbacklPaymentDetailTypeId,
      super.key});

  @override
  State<AddPaymentTypeScreen> createState() => _AddPaymentTypeScreenState();
}

class _AddPaymentTypeScreenState extends State<AddPaymentTypeScreen> {
  List<PaymentTypeModel> lPaymentType = [];
  List<String> lPaymentTypeShow = [];

  List<PaymentTypeDetailModel> lPaymentTypeDetail = [];
  List<String> lPaymentTypeDetailShow = [];
  List<String> lPaymentTypeNameCallBack = [];

  String paymentTypeValue = 'เงินสด';
  String paymentTypeId = '1001';

  String paymentTypeDetailValue = 'เงินสด';
  String paymentTypeDetailId = '10001';

  bool isCheckRepeat = false;
  bool isLoad = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(microseconds: 500), () async {
      await loadPaymentType();
      await loadPaymentTypeDetail();

      lPaymentType.forEach((e) {
        lPaymentTypeShow.add(e.tlpayment_type);
      });

      lPaymentTypeDetail
          .where((ee) => ee.tlpayment_type_id == paymentTypeId)
          .forEach((eef) {
        lPaymentTypeDetailShow.add(eef.tlpayment_type_detail);
      });

      paymentTypeDetailId = lPaymentTypeDetail
          .where((eee) =>
              eee.tlpayment_type_detail == lPaymentTypeDetailShow.first)
          .first
          .tlpayment_type_detail_id;

      paymentTypeDetailValue = lPaymentTypeDetail
          .where((eee) => eee.tlpayment_type_detail_id == paymentTypeDetailId)
          .first
          .tlpayment_type_detail;
      isLoad = false;
      if (widget.lPaymentDetailTypeIdNotShow
          .where((element) => element == '10001')
          .isNotEmpty) {
        isCheckRepeat = true;
      }
    });
    lPaymentTypeNameCallBack = widget.lPaymentDetailTypeIdNotShow;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          height: 200,
          width: 600,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Payment Type',
                style: TextStyle(fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Center(
                    child: isLoad
                        ? Center(child: CircularProgressIndicator())
                        : lPaymentTypeShow.isEmpty
                            ? Text('ได้ทำการเพิ่ม Payment Type ไปหมดแล้ว')
                            : Row(
                                children: [
                                  Expanded(child: _buildDropdownPaymentType()),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                      child: lPaymentTypeDetailShow.isEmpty
                                          ? Text(
                                              'ได้ทำการเพิ่ม Payment Type ไปหมดแล้ว')
                                          : _buildDropdownPaymentTypeDetail()),
                                ],
                              )),
              ),
              SizedBox(
                  child: isCheckRepeat == true
                      ? const Center(
                          child: Text(
                          'ไม่สามารถเพิ่มได้ เนื่องจาก เพิ่มรายการนี้ไปแล้ว',
                          style: TextStyle(color: Colors.red),
                        ))
                      : null),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: lPaymentTypeDetailShow.isEmpty ||
                                isCheckRepeat == true
                            ? Colors.red[400]
                            : null),
                    onPressed: () {
                      if (lPaymentTypeDetailShow.isEmpty ||
                          isCheckRepeat == true) {
                        Navigator.pop(context);
                      } else {
                        //! EditColumnInPaymentDetail
                        PaymentDetailModel newPaymentDetail = PaymentDetailModel(
                            tlpayment_detail_id:
                                '${TlConstant.runID()}${TlConstant.random()}900',
                            tlpayment_id: widget.paymentId,
                            tlpayment_type_id: paymentTypeId,
                            tlpayment_type: paymentTypeValue,
                            tlpayment_type_detail_id: paymentTypeDetailId,
                            tlpayment_type_detail: paymentTypeDetailValue,
                            opd_paid: '0.00',
                            ipd_paid: '0.00',
                            paid: '0.00',
                            paid_go: '0.00',
                            prpdsp: '1',
                            tlpayment_detail_site_id: widget.site,
                            tlpayment_detail_actual_paid: '0.00',
                            tlpayment_detail_diff_paid: '0.00',
                            tlpayment_detail_comment: '');

                        widget.callbackAddPD(newPaymentDetail);
                        // print(newPaymentDetail);
                        lPaymentTypeNameCallBack.add(paymentTypeDetailId);
                        widget.callbacklPaymentDetailTypeId(
                            lPaymentTypeNameCallBack);

                        Navigator.pop(context);
                      }
                    },
                    child:
                        lPaymentTypeDetailShow.isEmpty || isCheckRepeat == true
                            ? const Text(' Close ')
                            : const Text('Add Payment Type')),
              )
            ],
          ),
        ));
  }

  DropdownButton _buildDropdownPaymentType() {
    return DropdownButton<String>(
      isExpanded: true,
      value: paymentTypeValue,
      icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.blueGrey),
      elevation: 16,
      style: const TextStyle(color: Colors.blueGrey),
      underline: Container(
        height: 2,
        color: Colors.blueGrey,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          paymentTypeValue = value!;
          paymentTypeId = lPaymentType
              .where((e) => e.tlpayment_type == paymentTypeValue)
              .first
              .tlpayment_type_id;
          lPaymentTypeDetailShow = [];

          lPaymentTypeDetail
              .where((ee) => ee.tlpayment_type_id == paymentTypeId)
              .forEach((eef) {
            lPaymentTypeDetailShow.add(eef.tlpayment_type_detail);
          });

          paymentTypeDetailId = lPaymentTypeDetail
              .where((eee) =>
                  eee.tlpayment_type_detail == lPaymentTypeDetailShow.first &&
                  eee.tlpayment_type_id == paymentTypeId)
              .first
              .tlpayment_type_detail_id;

          paymentTypeDetailValue = lPaymentTypeDetail
              .where(
                  (eee) => eee.tlpayment_type_detail_id == paymentTypeDetailId)
              .first
              .tlpayment_type_detail;

          if (widget.lPaymentDetailTypeIdNotShow
              .contains(paymentTypeDetailId)) {
            isCheckRepeat = true;
          } else {
            isCheckRepeat = false;
          }
          print('paymentTypeDetailId =  ${paymentTypeDetailId}');
        });
      },
      items: lPaymentTypeShow.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(value),
          ),
        );
      }).toList(),
    );
  }

  DropdownButton _buildDropdownPaymentTypeDetail() {
    return DropdownButton<String>(
      isExpanded: true,
      value: paymentTypeDetailValue,
      icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.blueGrey),
      elevation: 16,
      style: const TextStyle(color: Colors.blueGrey),
      underline: Container(
        height: 2,
        color: Colors.blueGrey,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          paymentTypeDetailValue = value!;
          paymentTypeDetailId = lPaymentTypeDetail
              .where((e) =>
                  e.tlpayment_type_detail == paymentTypeDetailValue &&
                  e.tlpayment_type_id == paymentTypeId)
              .first
              .tlpayment_type_detail_id;
          print('paymentTypeDetailId =  ${paymentTypeDetailId}');

          if (widget.lPaymentDetailTypeIdNotShow
              .contains(paymentTypeDetailId)) {
            isCheckRepeat = true;
          } else {
            isCheckRepeat = false;
          }
        });
      },
      items:
          lPaymentTypeDetailShow.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(value),
          ),
        );
      }).toList(),
    );
  }

  Future loadPaymentType() async {
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
    });
    String api = '${TlConstant.syncApi}tlPaymentType.php?id=1';
    lPaymentType = [];
    await Dio().post(api, data: formData).then((value) {
      if (value.data == null) {
        print('Api Error !');
      } else {
        for (var type in value.data) {
          PaymentTypeModel newPaymentType = PaymentTypeModel.fromMap(type);
          lPaymentType.add(newPaymentType);
        }
      }
    });
    setState(() {});
  }

  Future loadPaymentTypeDetail() async {
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
    });
    String api = '${TlConstant.syncApi}tlPaymentTypeDetail.php?id=1';
    lPaymentTypeDetail = [];
    await Dio().post(api, data: formData).then((value) {
      if (value.data == null) {
        print('Api Error !');
      } else {
        for (var typeD in value.data) {
          PaymentTypeDetailModel newPTD = PaymentTypeDetailModel.fromMap(typeD);
          lPaymentTypeDetail.add(newPTD);
        }
      }
    });
    setState(() {});
  }
}
