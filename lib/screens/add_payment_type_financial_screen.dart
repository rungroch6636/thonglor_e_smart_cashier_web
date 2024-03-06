// ignore_for_file: must_be_immutable

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:thonglor_e_smart_cashier_web/models/financialDetail_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/financialTypeAndCom_model.dart';

import 'package:thonglor_e_smart_cashier_web/models/paymentDetail_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/paymentType_model.dart';

import '../models/employee_model.dart';
import '../models/paymentTypeDetail_model.dart';
import '../util/constant.dart';

class AddPaymentTypeFinancialScreen extends StatefulWidget {
  //!  ให้สามารถ เพิ่มได้ไม่สนว่าซ้ำมั้ย
  String financialId;
  String financialMenuId;
  String site;
  String empRec;
  List<EmployeeModel> lEmp;
  List<FinancialTypeAndComModel> lFinTypeAndCom;
  Function callbackAddFinDetail;

  AddPaymentTypeFinancialScreen(
      {required this.financialId,
      required this.financialMenuId,
      required this.site,
      required this.empRec,
      required this.lEmp,
      required this.lFinTypeAndCom,
      required this.callbackAddFinDetail,
      super.key});

  @override
  State<AddPaymentTypeFinancialScreen> createState() =>
      _AddPaymentTypeFinancialScreenState();
}

class _AddPaymentTypeFinancialScreenState
    extends State<AddPaymentTypeFinancialScreen> {
  List<PaymentTypeModel> lPaymentType = [];
  List<String> lPaymentTypeShow = [];

  List<PaymentTypeDetailModel> lPaymentTypeDetail = [];
  List<String> lPaymentTypeDetailShow = [];

  String paymentTypeValue = 'เงินสด';
  String paymentTypeId = '1001';

  String paymentTypeDetailValue = 'เงินสด';
  String paymentTypeDetailId = '10001';

  bool isCheckRepeat = false;
  bool isLoad = true;

  String tlfinancial_type_id = 'other';
  String tlfinancial_type_name = 'อื่นๆ';
  String tlfinancial_type_group = 'other';
  String tlfinancial_type_number = '63';

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

      final lFinTypeAndCom = widget.lFinTypeAndCom
          .where((element) =>
              element.tlpayment_type_id == paymentTypeId &&
              element.tlpayment_type == paymentTypeValue &&
              element.tlpayment_type_detail == paymentTypeDetailValue)
          .toList();

      if (lFinTypeAndCom.isNotEmpty) {
        lFinTypeAndCom.sort(
          (a, b) => a.tlfinancial_type_compare_id
              .compareTo(b.tlfinancial_type_compare_id),
        );
        tlfinancial_type_id = lFinTypeAndCom.first.tlfinancial_type_id;
        tlfinancial_type_name = lFinTypeAndCom.first.tlfinancial_type_name;
        tlfinancial_type_group = lFinTypeAndCom.first.tlfinancial_type_group;
        tlfinancial_type_number = lFinTypeAndCom.first.tlfinancial_type_number;
      } else {
        tlfinancial_type_id = 'other';
        tlfinancial_type_name = 'อื่นๆ';
        tlfinancial_type_group = 'other';
        tlfinancial_type_number = '63';
      }

      isLoad = false;
    });
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

                        FinancialDetailModel newFinDeModel =
                            FinancialDetailModel(
                                tlfinancial_detail_id:
                                    '${TlConstant.runID()}00',
                                tlpayment_detail_site_id: widget.site,
                                tlpayment_rec_by: widget.empRec,
                                tlpayment_rec_date: '',
                                tlpayment_type_id: paymentTypeId,
                                tlpayment_type: paymentTypeValue,
                                tlpayment_type_detail: paymentTypeDetailValue,
                                tlpayment_detail_actual_paid: '0.0',
                                tlpayment_detail_id: '',
                                tlpayment_id: '',
                                tlpayment_detail_paid: '0.0',
                                tlpayment_detail_paid_go: '0.0',
                                tlpayment_detail_diff_paid: '0.0',
                                tlpayment_detail_comment: 'CreateAtFinScreen',
                                tldeposit_id: '',
                                tldeposit_create_by: '',
                                deposit_fullname: '',
                                tldeposit_detail_id: '',
                                tldeposit_bank_account: '',
                                tldeposit_date: '',
                                tldeposit_total: '',
                                tldeposit_total_actual: '',
                                tldeposit_total_balance: '',
                                tldeposit_comment: '',
                                tlfinancial_type_id: tlfinancial_type_id,
                                tlfinancial_type_name: tlfinancial_type_name,
                                tlfinancial_type_group: tlfinancial_type_group,
                                tlfinancial_type_number:
                                    tlfinancial_type_number,
                                tlfinancial_detail_actual: '0.0',
                                tlfinancial_detail_comment: 'CreateAtFinScreen',
                                tlfinancial_detail_create_by:
                                    widget.lEmp.first.employee_id,
                                tlfinancial_detail_create_date: '',
                                tlfinancial_detail_create_time: '',
                                tlfinancial_detail_modify_by: '',
                                tlfinancial_detail_modify_date: '',
                                tlfinancial_detail_modify_time: '',
                                tlfinancial_id: widget.financialId,
                                tlfinancial_menu_id: widget.financialMenuId);
                        print('leftMenuIDPop : ${widget.financialMenuId}');
                        widget.callbackAddFinDetail(newFinDeModel);

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

          final lFinTypeAndCom = widget.lFinTypeAndCom
              .where((element) =>
                  element.tlpayment_type_id == paymentTypeId &&
                  element.tlpayment_type == paymentTypeValue &&
                  element.tlpayment_type_detail == paymentTypeDetailValue)
              .toList();

          if (lFinTypeAndCom.isNotEmpty) {
            lFinTypeAndCom.sort(
              (a, b) => a.tlfinancial_type_compare_id
                  .compareTo(b.tlfinancial_type_compare_id),
            );
            tlfinancial_type_id = lFinTypeAndCom.first.tlfinancial_type_id;
            tlfinancial_type_name = lFinTypeAndCom.first.tlfinancial_type_name;
            tlfinancial_type_group =
                lFinTypeAndCom.first.tlfinancial_type_group;
            tlfinancial_type_number =
                lFinTypeAndCom.first.tlfinancial_type_number;
          } else {
            tlfinancial_type_id = 'other';
            tlfinancial_type_name = 'อื่นๆ';
            tlfinancial_type_group = 'other';
            tlfinancial_type_number = '63';
          }
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

          final lFinTypeAndCom = widget.lFinTypeAndCom
              .where((element) =>
                  element.tlpayment_type_id == paymentTypeId &&
                  element.tlpayment_type == paymentTypeValue &&
                  element.tlpayment_type_detail == paymentTypeDetailValue)
              .toList();

          if (lFinTypeAndCom.isNotEmpty) {
            lFinTypeAndCom.sort(
              (a, b) => a.tlfinancial_type_compare_id
                  .compareTo(b.tlfinancial_type_compare_id),
            );
            tlfinancial_type_id = lFinTypeAndCom.first.tlfinancial_type_id;
            tlfinancial_type_name = lFinTypeAndCom.first.tlfinancial_type_name;
            tlfinancial_type_group =
                lFinTypeAndCom.first.tlfinancial_type_group;
            tlfinancial_type_number =
                lFinTypeAndCom.first.tlfinancial_type_number;
          } else {
            tlfinancial_type_id = 'other';
            tlfinancial_type_name = 'อื่นๆ';
            tlfinancial_type_group = 'other';
            tlfinancial_type_number = '63';
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
