import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:thonglor_e_smart_cashier_web/models/payment_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/receiptReview_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/sumRecReview_model.dart';

import '../models/employee_model.dart';
import '../util/constant.dart';

class ReviewRecPopup extends StatefulWidget {
  final String site;
  final String date;

  const ReviewRecPopup({required this.site, required this.date, super.key});

  @override
  State<ReviewRecPopup> createState() => _ReviewRecPopupState();
}

class _ReviewRecPopupState extends State<ReviewRecPopup> {
  List<ReceiptReviewModel> lRecReview = [];
  List<PaymentModel> lPaymentMaster = [];
  bool isLoad = true;

  double dTotalPaid = 0.0;
  double dTotalPaidGo = 0.0;
  final oCcy = NumberFormat(
    "#,##0.00",
  );

  List<SumRecReview> lSumRecReview = [];

  List<EmployeeModel> lEmployeeProfile = [];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1000), () async {
      await loadiMedRecReview(widget.site, widget.date);
      await loadPaymentMaster(widget.site, widget.date);
      await caliMedRec();
      await employeeFullName();
      setState(() {
        isLoad = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.green[50],
      borderRadius: BorderRadius.all(Radius.circular(8)),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                child: Text(
                  'รายได้แต่ละผลัดบน iMed',
                  style: TextStyle(color: Colors.green[900], fontSize: 18),
                ),
              ),
              SizedBox(
                child: IconButton(
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Card(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0),
              child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: Text(
                          'ชื่อ',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                        width: 200,
                        child: Text('ยอดเงินสด', textAlign: TextAlign.center)),
                    SizedBox(
                        width: 200,
                        child: Text('ยอด OPD', textAlign: TextAlign.center)),
                    SizedBox(
                        width: 200,
                        child: Text('ยอด IPD', textAlign: TextAlign.center)),
                    SizedBox(
                        width: 200,
                        child: Text('ยอดขาย', textAlign: TextAlign.center)),
                    SizedBox(
                        width: 200,
                        child: Text('ยอดนำส่ง', textAlign: TextAlign.center)),
                  ]),
            ),
          ),
        ), //text
        Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4)),
                child: isLoad
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : lSumRecReview.isEmpty
                        ? Center(
                            child: Text(' ไม่พบข้อมูลจาก iMed '),
                          )
                        : ListView.builder(
                            itemCount: lSumRecReview.length,
                            itemBuilder: (context, index) {
                              return Card(
                                color: index % 2 == 0 ? Colors.green[50] : null,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              child: Text(
                                                  lEmployeeProfile
                                                      .where((ee) =>
                                                          ee.employee_id ==
                                                          lSumRecReview[index]
                                                              .emp)
                                                      .first
                                                      .emp_fullname,
                                                  textAlign: TextAlign.left),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 200,
                                            child: Tooltip(
                                              message:
                                                  'เงินสด - คืนเงินสด \n ${lSumRecReview[index].detailSumCash}',
                                              child: Text(
                                                  lSumRecReview[index].sumCash,
                                                  textAlign: TextAlign.end),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                                lSumRecReview[index].sumOpd,
                                                textAlign: TextAlign.end),
                                          ),
                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                                lSumRecReview[index].sumIpd,
                                                textAlign: TextAlign.end),
                                          ),
                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                                lSumRecReview[index].sumPaid,
                                                textAlign: TextAlign.end),
                                          ),
                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                                lSumRecReview[index].sumPaidGo,
                                                textAlign: TextAlign.end),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                                lSumRecReview[index].emp,
                                                textAlign: TextAlign.left),
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          SizedBox(
                                              child: int.parse(lSumRecReview[
                                                              index]
                                                          .countStatusCreate) >
                                                      0
                                                  ? Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 2),
                                                      child: Chip(
                                                        label: Text(
                                                          'สร้าง : ${lSumRecReview[index].countStatusCreate}',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                        backgroundColor:
                                                            Colors.red[100],
                                                      ),
                                                    )
                                                  : null),
                                          SizedBox(
                                              child: int.parse(lSumRecReview[
                                                              index]
                                                          .countStatusConfirm) >
                                                      0
                                                  ? Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 2),
                                                      child: Chip(
                                                        label: Text(
                                                          'อนุมัติแล้ว : ${lSumRecReview[index].countStatusConfirm}',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .blue[900]),
                                                        ),
                                                        backgroundColor:
                                                            Colors.blue[100],
                                                      ),
                                                    )
                                                  : null),
                                          SizedBox(
                                              child: int.parse(lSumRecReview[
                                                              index]
                                                          .countStatusReject) >
                                                      0
                                                  ? Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 2),
                                                      child: Chip(
                                                        label: Text(
                                                          'ส่งกลับไปแก้ไข : ${lSumRecReview[index].countStatusReject}',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                        ),
                                                        backgroundColor:
                                                            Colors.red[100],
                                                      ),
                                                    )
                                                  : null),
                                          SizedBox(
                                              child: int.parse(lSumRecReview[
                                                              index]
                                                          .countStatusCancel) >
                                                      0
                                                  ? Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 2),
                                                      child: Chip(
                                                        label: Text(
                                                          'ส่งกลับไปแก้ไข : ${lSumRecReview[index].countStatusCancel}',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        backgroundColor:
                                                            Colors.red[900],
                                                      ),
                                                    )
                                                  : null),
                                          SizedBox(
                                              child: int.parse(lSumRecReview[
                                                              index]
                                                          .countStatusWaiting) >
                                                      0
                                                  ? Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 2),
                                                      child: Chip(
                                                        label: Text(
                                                          'รอการอนุมัติ : ${lSumRecReview[index].countStatusWaiting}',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .yellow[900]),
                                                        ),
                                                        backgroundColor:
                                                            Colors.yellow[100],
                                                      ),
                                                    )
                                                  : null),
                                          SizedBox(
                                              child: int.parse(lSumRecReview[
                                                              index]
                                                          .countStatusNoData) >
                                                      0
                                                  ? Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 2),
                                                      child: Chip(
                                                        label: Text(
                                                          'ยังไม่ทำในระบบ : ${lSumRecReview[index].countStatusNoData}',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[800]),
                                                        ),
                                                        backgroundColor:
                                                            Colors.grey[300],
                                                      ),
                                                    )
                                                  : null),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('ยอดขาย : ${oCcy.format(dTotalPaid)}',
                      style: TextStyle(fontSize: 18)),
                  SizedBox(
                    width: 100,
                  ),
                  Text('ยอดนำส่ง : ${oCcy.format(dTotalPaidGo)}',
                      style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
        ) //ListView
      ]),
    );
  }

  loadiMedRecReview(String site, String date) async {
    lRecReview = [];
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "site_id": site,
      "date_": date,
    });
    String api = '${TlConstant.syncApi}receipt.php?id=imedRecReview';

    await Dio().post(api, data: formData).then((value) {
      if (value.data == null) {
        print('NoData');
      } else {
        for (var rec in value.data) {
          ReceiptReviewModel newRec = ReceiptReviewModel.fromMap(rec);
          lRecReview.add(newRec);
        }
      }
    });
  }

  loadPaymentMaster(String site, String date) async {
    lPaymentMaster = [];
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "site_id": site,
      "date_receipt": date,
    });
    String api = '${TlConstant.syncApi}tlPayment.php?id=checkPaymentReview';

    await Dio().post(api, data: formData).then((value) {
      if (value.data == null) {
        print('NoData');
      } else {
        for (var payment in value.data) {
          PaymentModel newPayment = PaymentModel.fromMap(payment);
          lPaymentMaster.add(newPayment);
        }
      }
    });
  }

  Future employeeFullName() async {
    lEmployeeProfile = [];

    for (var ee in lSumRecReview) {
      FormData formData = FormData.fromMap({
        "token": TlConstant.token,
        "employee_id": ee.emp,
      });
      String api = '${TlConstant.syncApi}employee.php?id=imedfullname';

      await Dio().post(api, data: formData).then((value) {
        if (value.data == null) {
        } else {
          for (var emp in value.data) {
            EmployeeModel newEmp = EmployeeModel.fromMap(emp);
            lEmployeeProfile.add(newEmp);
          }
        }
      });
    }
  }

  caliMedRec() async {
    lSumRecReview = [];
    var gRecReview = groupBy(lRecReview, (gKey) => gKey.rec_by);
    dTotalPaid = 0;
    dTotalPaidGo = 0;
    gRecReview.forEach((key, value) async {
      double dCash = 0.0;
      double dCashRec = 0.0;
      double dCashRePay = 0.0;
      double dOpd = 0.0;
      double dIpd = 0.0;
      double dPaid = 0.0;
      double dPaidGo = 0.0;
      String emp = key;
      int iCreate = 0;
      int iConfirm = 0;
      int iWaiting = 0;
      int iReject = 0;
      int iCancel = 0;
      int iNoData = 0;

      iCreate = lPaymentMaster
          .where((eee) =>
              eee.tlpayment_rec_by == emp && eee.tlpayment_status == 'create')
          .length;
      iConfirm = lPaymentMaster
          .where((eee) =>
              eee.tlpayment_rec_by == emp && eee.tlpayment_status == 'confirm')
          .length;
      iWaiting = lPaymentMaster
          .where((eee) =>
              eee.tlpayment_rec_by == emp && eee.tlpayment_status == 'waiting')
          .length;
      iReject = lPaymentMaster
          .where((eee) =>
              eee.tlpayment_rec_by == emp && eee.tlpayment_status == 'reject')
          .length;

      if (iCreate == 0 &&
          iConfirm == 0 &&
          iWaiting == 0 &&
          iReject == 0 &&
          iCancel == 0) {
        iNoData = 1;
      }

      for (var e in value) {
        dOpd += double.parse(e.opd_paid);
        dIpd += double.parse(e.ipd_paid);
        dPaid += double.parse(e.paid);
        dPaidGo += double.parse(e.paid_go);
        print(e.rec_by);
        print(e.paid_method_sub_th);
        if (e.paid_method_sub_th.contains('เงินสด')) {
          dCash += double.parse(e.paid_go);
          if (e.paid_method_sub_th.contains('คืนเงินสด')) {
            double dRepay = double.parse(e.paid_go) * -1;
            dCashRePay += dRepay;
          } else if (e.paid_method_sub_th.contains('เงินสด')) {
            dCashRec += double.parse(e.paid_go);
          }
        }
      }

      dTotalPaid += dPaid;
      dTotalPaidGo += dPaidGo;

      SumRecReview newSRR = SumRecReview(
        emp: emp,
        sumOpd: oCcy.format(dOpd),
        sumIpd: oCcy.format(dIpd),
        sumPaid: oCcy.format(dPaid),
        sumPaidGo: oCcy.format(dPaidGo),
        sumCash: oCcy.format(dCash),
        detailSumCash: '${oCcy.format(dCashRec)} - ${oCcy.format(dCashRePay)}',
        countStatusCreate: iCreate.toString(),
        countStatusWaiting: iWaiting.toString(),
        countStatusConfirm: iConfirm.toString(),
        countStatusReject: iReject.toString(),
        countStatusCancel: '0', //TodoCountStatusCancel
        countStatusNoData: iNoData.toString(),
      );
      lSumRecReview.add(newSRR);
    });
  }
}
