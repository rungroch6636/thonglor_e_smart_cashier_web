// ignore_for_file: must_be_immutable, unused_field, use_build_context_synchronously

import 'dart:convert';

import 'package:action_slider/action_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:badges/badges.dart' as badges;
import 'package:thonglor_e_smart_cashier_web/models/choiceEmployee_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/choicePayment_model.dart';

import 'package:thonglor_e_smart_cashier_web/models/paymentApproval_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/paymentDetailRemark_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/paymentDetail_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/payment_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/receipt_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/site_model.dart';

import 'package:thonglor_e_smart_cashier_web/screens/payment_image_screen.dart';
import 'package:thonglor_e_smart_cashier_web/screens/review_rec_popup.dart';
import 'package:thonglor_e_smart_cashier_web/util/constant.dart';
import 'package:collection/collection.dart';
import 'package:thonglor_e_smart_cashier_web/widgets/remarkPopup.dart';

import 'package:thonglor_e_smart_cashier_web/widgets/textFormFieldPDComment.dart';

import '../models/employee_model.dart';
import '../models/paymentDetailImageTemp_model.dart';
import '../models/paymentDetailImage_model.dart';
import '../models/payment_empFullName_model.dart';

class CheckPaymentScreen extends StatefulWidget {
  List<EmployeeModel> lEmp;

  Function callbackUpdate;
  CheckPaymentScreen(
      {required this.lEmp, required this.callbackUpdate, super.key});

  @override
  State<CheckPaymentScreen> createState() => _CheckPaymentScreenState();
}

//emp nipaporn  0635644228 2023-11-15  two Site (หลี)
//emp arunrat_b 2023-06-01 one Site
class _CheckPaymentScreenState extends State<CheckPaymentScreen> {
  List<PaymentDetailImageTempModel> lPaymentImage = [];
  List<PaymentDetailImageModel> lPaymentImageDB = [];
  List<PaymentDetailRemarkModel> lPaymentRemark = [];

  List<String> lPaymentRemarkId = [];

  List<SiteModel> lSite = [];
  List<String> lSiteId = []; //['All Site'];
  String siteDDValue = 'R9';
  String siteToAddPaymentType = '';

  List<String> lHour = <String>[
    '00',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23'
  ];
  List<String> lMinute = <String>[
    '00',
    '05',
    '10',
    '15',
    '20',
    '25',
    '30',
    '35',
    '40',
    '45',
    '50',
    '55',
    '59'
  ];

  String startTimeHourDDValue = '00';
  String startTimeMinuteDDValue = '00';
  String endTimeHourDDValue = '23';
  String endTimeMinuteDDValue = '59';

  String dateRec = '';
  String startTime = '';
  String endTime = '';

  String paymentId = '';
  String approvalId = '';

  String selectDateFrom = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String selectDateTo = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  //  '2023-11-07'; //DateFormat('yyyy-MM-dd').format(DateTime.now());

  bool isCheckRun = false;
  bool isCheckClickOii = false;
  bool isHover = false;
  bool isRejectHover = false;
  bool isApproveHover = false;

  String isStatusScreen =
      'waiting'; //!  isStatusScreen New Create Waiting Reject Confirm

  String checkTypeDate = '';

  List<ReceiptModel> lReceiptImed = [];

  List<double> lBalance = [];
  List<bool> lAddImage = [];
  String runProcess = 'start';
  final oCcy = NumberFormat(
    "#,##0.00",
  );
  double dTotalIncome = 0;
  double dTotalPaid = 0;
  double dTotalActual = 0;
  double dTotalBalance = 0;
  List<PaymentEmpFullNameModel> lPaymentMaster = [];
  List<EmployeeModel> lEmployeeProfile = [];
  List<PaymentDetailModel> lPaymentDetail = [];
  List<PaymentDetailModel> lPaymentDetailShow = [];
  String isSelectCardEmp = 'ALL';

  var groupPaymentType;

  bool isLoopRun = false;
  bool isIconSelect = false;

  TextEditingController paymentControllers = TextEditingController();

  List<String> lStatusApproverShow = [
    '-- เลือกสถานะการตรวจสอบ --',
    'อนุมัติ : Confirm',
    'ส่งกลับไปแก้ไข : Reject'
  ];

  String statusApproveValue = '';

  String empReq = '';

  @override
  void initState() {
    super.initState();
    // TODO: implement initState

    Future.delayed(Duration(microseconds: 10000), () async {
      await loadSite();
      lSite.forEach((element) {
        lSiteId.add(element.site_id);
      });
    });
    siteDDValue = widget.lEmp.first.site_id;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(36)),
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Row(children: [
          Expanded(
              flex: 5,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      child: Text(
                          '${widget.lEmp.first.emp_fullname}  สาขาหลัก : ${widget.lEmp.first.site_id}'),
                    ),
                  ),
                  Expanded(
                    child: runProcess == 'start'
                        ? Container(
                            child: const Center(
                              child: Text(' เลือก วันที่ และ สาขา '),
                            ),
                          )
                        : SizedBox(
                            child: isCheckRun
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Column(
                                    children: [
                                      lPaymentMaster.isEmpty
                                          ? Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: 50,
                                                  ),
                                                  Text('ไม่มีข้อมูลการปิดผลัด'),
                                                  SizedBox(
                                                    width: 50,
                                                    child: Center(
                                                      child: IconButton(
                                                        icon: const Tooltip(
                                                          message:
                                                              "Review รายได้แต่ละผลัดบน iMed",
                                                          child: Icon(
                                                              Icons
                                                                  .error_rounded,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        onPressed: () {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return Column(
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 4,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            16.0),
                                                                        child: ReviewRecPopup(
                                                                            site:
                                                                                siteToAddPaymentType,
                                                                            date:
                                                                                dateRec),
                                                                      ),
                                                                    ),
                                                                    const Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            SizedBox())
                                                                  ],
                                                                );
                                                              });
                                                        },
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: SizedBox(
                                                height: 66,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 2.0,
                                                                horizontal: 20),
                                                        child: ListView.builder(
                                                          itemCount:
                                                              lPaymentMaster
                                                                  .length,
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return Card(
                                                              color: isSelectCardEmp ==
                                                                      'ALL'
                                                                  ? Colors.green[
                                                                      100]
                                                                  : isSelectCardEmp ==
                                                                          lPaymentMaster[index]
                                                                              .emp_fullname
                                                                      ? Colors
                                                                          .green[100]
                                                                      : null,
                                                              child: SizedBox(
                                                                //width: 180,
                                                                child: InkWell(
                                                                  hoverColor:
                                                                      Colors.green[
                                                                          200],
                                                                  onTap:
                                                                      () async {
                                                                    paymentId =
                                                                        '';
                                                                    approvalId =
                                                                        '';
                                                                    isSelectCardEmp =
                                                                        lPaymentMaster[index]
                                                                            .emp_fullname;

                                                                    if (lPaymentMaster[index]
                                                                            .emp_fullname ==
                                                                        'ALL') {
                                                                      setState(
                                                                          () {
                                                                        isStatusScreen =
                                                                            'waiting';
                                                                        groupPaymentType =
                                                                            '';
                                                                        lPaymentDetailShow
                                                                            .clear();
                                                                      });
                                                                      showDialog(
                                                                          barrierDismissible:
                                                                              false,
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (context) {
                                                                            return Dialog(
                                                                              backgroundColor: Colors.transparent,
                                                                              child: Container(
                                                                                width: 80,
                                                                                height: 80,
                                                                                decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(8))),
                                                                                child: const Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    CircularProgressIndicator(),
                                                                                    SizedBox(
                                                                                      width: 32,
                                                                                    ),
                                                                                    Text('Loading...')
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            );
                                                                          });
                                                                      await sumPaymentMasterAll();
                                                                      await loadPaymentDetailAll();
                                                                      await sumPaymentDetailAll();
                                                                      // await loadPaymentDetailImageAll();
                                                                      // await loadPaymentDetailRemarkAll();
                                                                    } else {
                                                                      setState(
                                                                          () {
                                                                        isStatusScreen =
                                                                            lPaymentMaster[index].tlpayment_status;
                                                                        groupPaymentType =
                                                                            '';
                                                                        lPaymentDetailShow
                                                                            .clear();
                                                                      });
                                                                      showDialog(
                                                                          barrierDismissible:
                                                                              false,
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (context) {
                                                                            return Dialog(
                                                                              backgroundColor: Colors.transparent,
                                                                              child: Container(
                                                                                width: 80,
                                                                                height: 80,
                                                                                decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(8))),
                                                                                child: const Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    CircularProgressIndicator(),
                                                                                    SizedBox(
                                                                                      width: 32,
                                                                                    ),
                                                                                    Text('Loading...')
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            );
                                                                          });
                                                                      print(
                                                                          'object');
                                                                      print(lPaymentMaster[
                                                                              index]
                                                                          .tlpayment_id);
                                                                      paymentId =
                                                                          lPaymentMaster[index]
                                                                              .tlpayment_id;
                                                                      approvalId =
                                                                          lPaymentMaster[index]
                                                                              .tlpayment_approval_id;
                                                                      paymentControllers
                                                                          .text = lPaymentMaster[
                                                                              index]
                                                                          .tlpayment_comment;

                                                                      await sumPaymentMasterByPaymentId(
                                                                          paymentId);

                                                                      await loadPaymentDetailByPayment(
                                                                          paymentId);

                                                                      await loadPaymentDetailImageByPayment(
                                                                          paymentId);

                                                                      await loadPaymentDetailRemarkByPayment(
                                                                          paymentId);

                                                                      lPaymentDetailShow =
                                                                          lPaymentDetail;

                                                                      //        lPaymentDetailShow = lPaymentDetail.where((element) => element.)
                                                                    }
                                                                    setState(
                                                                        () {
                                                                      groupPaymentType =
                                                                          groupPaymentDeposit(
                                                                              lPaymentDetailShow);
                                                                      Navigator.pop(
                                                                          context);
                                                                    });
                                                                  },
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            4.0,
                                                                        horizontal:
                                                                            8.0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                            lPaymentMaster[index]
                                                                                .emp_fullname,
                                                                            style:
                                                                                TextStyle(
                                                                              color: isSelectCardEmp == 'ALL'
                                                                                  ? Colors.green[900]
                                                                                  : isSelectCardEmp == lPaymentMaster[index].emp_fullname
                                                                                      ? Colors.green[900]
                                                                                      : null,
                                                                            )),
                                                                        SizedBox(
                                                                          child: lPaymentMaster[index].emp_fullname == 'ALL'
                                                                              ? null
                                                                              : Text(
                                                                                  '(${lPaymentMaster[index].tlpayment_status})',
                                                                                  style: const TextStyle(color: Colors.blue, fontSize: 12),
                                                                                ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 50,
                                                      child: Center(
                                                        child: IconButton(
                                                          icon: const Tooltip(
                                                            message:
                                                                "Review รายได้แต่ละผลัดบน iMed",
                                                            child: Icon(
                                                                Icons
                                                                    .error_rounded,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                          onPressed: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Column(
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 4,
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              16.0),
                                                                          child: ReviewRecPopup(
                                                                              site: siteToAddPaymentType,
                                                                              date: dateRec),
                                                                        ),
                                                                      ),
                                                                      const Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              SizedBox())
                                                                    ],
                                                                  );
                                                                });
                                                          },
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.green[50],
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 24),
                                                  child: lPaymentDetail.isEmpty
                                                      ? const SizedBox(
                                                          height: 40,
                                                          child: Center(
                                                            child:
                                                                Text('No Data'),
                                                          ),
                                                        )
                                                      : SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              1.8,
                                                          child:
                                                              ListView.builder(
                                                                  itemCount:
                                                                      groupPaymentType
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    String
                                                                        fullName =
                                                                        groupPaymentType
                                                                            .keys
                                                                            .elementAt(index);
                                                                    List<PaymentDetailModel>
                                                                        data =
                                                                        groupPaymentType
                                                                            .values
                                                                            .elementAt(index);

                                                                    return Column(
                                                                      children: [
                                                                        Card(
                                                                            color:
                                                                                Colors.green[100],
                                                                            child: Align(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8.0),
                                                                                child: Text(
                                                                                  fullName,
                                                                                  style: const TextStyle(fontSize: 16),
                                                                                ),
                                                                              ),
                                                                            )),
                                                                        ListView.builder(
                                                                            shrinkWrap: true,
                                                                            physics: ClampingScrollPhysics(),
                                                                            itemCount: data.length,
                                                                            itemBuilder: (BuildContext context, int indexDetail) {
                                                                              PaymentDetailModel mPaymentDetail = data[indexDetail];

                                                                              //mTextController.text = mPaymentDetail.tlpayment_detail_actual_paid;
                                                                              // Return a widget representing the item
                                                                              return SizedBox(
                                                                                height: 32,
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      height: 32,
                                                                                      width: 60,
                                                                                      child: Align(
                                                                                        alignment: Alignment.center,
                                                                                        child: Text(
                                                                                          mPaymentDetail.tlpayment_detail_site_id,
                                                                                          style: TextStyle(fontSize: 14),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      child: SizedBox(
                                                                                        child: Align(
                                                                                          alignment: Alignment.center,
                                                                                          child: Text(
                                                                                            mPaymentDetail.tlpayment_type_detail,
                                                                                            style: TextStyle(fontSize: 14),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 32,
                                                                                      width: 150,
                                                                                      child: Align(
                                                                                        alignment: Alignment.centerRight,
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.only(right: 20.0),
                                                                                          child: Tooltip(
                                                                                            message: 'ยอดขายจาก Imed',
                                                                                            child: Text(
                                                                                              oCcy.format(double.parse(mPaymentDetail.paid)),
                                                                                              style: TextStyle(fontSize: 14),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 32,
                                                                                      width: 150,
                                                                                      child: Align(
                                                                                        alignment: Alignment.centerRight,
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.only(right: 20.0),
                                                                                          child: Tooltip(
                                                                                            message: 'ยอดนำส่งจาก Imed',
                                                                                            child: Text(
                                                                                              oCcy.format(double.parse(mPaymentDetail.paid_go)),
                                                                                              style: TextStyle(fontSize: 14),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                        height: 32,
                                                                                        width: 160,
                                                                                        child: Align(
                                                                                          alignment: Alignment.centerRight,
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.only(right: 20.0),
                                                                                            child: Tooltip(
                                                                                              message: 'นำส่งจริง',
                                                                                              child: Card(
                                                                                                color: Colors.green[50],
                                                                                                child: InkWell(
                                                                                                  hoverColor: isSelectCardEmp == 'ALL' ? Colors.green[50] : Colors.green[100],
                                                                                                  onTap: () {
                                                                                                    if (isSelectCardEmp == 'ALL' || isStatusScreen == 'confirm') {
                                                                                                    } else {
                                                                                                      TextEditingController actualController = TextEditingController();
                                                                                                      showDialog(
                                                                                                          context: context,
                                                                                                          builder: (context) {
                                                                                                            return Dialog(
                                                                                                                child: SizedBox(
                                                                                                              height: 120,
                                                                                                              width: MediaQuery.sizeOf(context).width / 2,
                                                                                                              child: Column(
                                                                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                                                children: [
                                                                                                                  const Text('แก้ไข รายการนำส่ง'),
                                                                                                                  Row(
                                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                                                    children: [
                                                                                                                      Text('จำนวนปัจจุบัน :'),
                                                                                                                      Text(mPaymentDetail.tlpayment_detail_actual_paid),
                                                                                                                      Text('จำนวนที่แก้ไข'),
                                                                                                                      SizedBox(
                                                                                                                        width: 200,
                                                                                                                        child: TextFormField(
                                                                                                                            textAlign: TextAlign.end,
                                                                                                                            inputFormatters: [
                                                                                                                              FilteringTextInputFormatter.allow(
                                                                                                                                RegExp(r'^-?\d*\.?\d{0,2}$'),
                                                                                                                              ),
                                                                                                                            ],
                                                                                                                            controller: actualController,
                                                                                                                            onChanged: (value) {
                                                                                                                              if (value.isEmpty) {
                                                                                                                                value = '0';
                                                                                                                                actualController.text = '0';
                                                                                                                              }
                                                                                                                            }),
                                                                                                                      )
                                                                                                                    ],
                                                                                                                  ),
                                                                                                                  ElevatedButton(
                                                                                                                    child: const Text('Confirm'),
                                                                                                                    onPressed: () async {
                                                                                                                      String historyId = '${TlConstant.runID()}';
                                                                                                                      String table = 'tlpayment_detail';
                                                                                                                      String pkIdInTable = mPaymentDetail.tlpayment_detail_id;
                                                                                                                      String editDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
                                                                                                                      String editTime = DateFormat('HH:mm:ss').format(DateTime.now());
                                                                                                                      String editBy = widget.lEmp.first.employee_id;
                                                                                                                      String editColumn = 'tlpayment_detail_actual_paid';
                                                                                                                      String oldValue = mPaymentDetail.tlpayment_detail_actual_paid;
                                                                                                                      String newVale = actualController.text;
                                                                                                                      String detailComment = mPaymentDetail.tlpayment_detail_comment;
                                                                                                                      double dEditBalance = double.parse(actualController.text) - double.parse(mPaymentDetail.paid_go);

                                                                                                                      double dEditTotalActual = 0.0;
                                                                                                                      double dEditTotalBalance = 0.0;
                                                                                                                      setState(() {
                                                                                                                        Navigator.pop(context);
                                                                                                                      });
                                                                                                                      showDialog(
                                                                                                                          barrierDismissible: false,
                                                                                                                          context: context,
                                                                                                                          builder: (context) {
                                                                                                                            return Dialog(
                                                                                                                              backgroundColor: Colors.transparent,
                                                                                                                              child: Container(
                                                                                                                                width: 80,
                                                                                                                                height: 80,
                                                                                                                                decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(8))),
                                                                                                                                child: const Row(
                                                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                  children: [
                                                                                                                                    CircularProgressIndicator(),
                                                                                                                                    SizedBox(
                                                                                                                                      width: 32,
                                                                                                                                    ),
                                                                                                                                    Text('Loading...')
                                                                                                                                  ],
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            );
                                                                                                                          });
                                                                                                                      final lPaymentEdit = lPaymentDetailShow.where((element) => element.tlpayment_id == mPaymentDetail.tlpayment_id).toList();

                                                                                                                      for (var ee in lPaymentEdit) {
                                                                                                                        if (ee.tlpayment_detail_id == mPaymentDetail.tlpayment_detail_id) {
                                                                                                                          dEditTotalActual += double.parse(newVale);
                                                                                                                          dEditTotalBalance += dEditBalance;
                                                                                                                        } else {
                                                                                                                          dEditTotalActual += double.parse(ee.tlpayment_detail_actual_paid);
                                                                                                                          dEditTotalBalance += double.parse(ee.tlpayment_detail_diff_paid);
                                                                                                                        }
                                                                                                                      }

                                                                                                                      // Create to History
                                                                                                                      await createHistory(historyId, table, pkIdInTable, editDate, editTime, editBy, editColumn, oldValue, newVale);
                                                                                                                      //Update To Detail
                                                                                                                      await updatePaymentDetail(mPaymentDetail.tlpayment_detail_id, double.parse(newVale), dEditBalance, detailComment);
                                                                                                                      //Update to Master
                                                                                                                      await updatePayment(paymentId, dEditTotalActual, dEditTotalBalance);

                                                                                                                      // loadMasterById

                                                                                                                      // loadDetailById

                                                                                                                      // loadRemarkById

                                                                                                                      // loadImageById
                                                                                                                      await loadPaymentMasterCheck(siteDDValue, dateRec);
                                                                                                                      await sumPaymentMasterByPaymentId(paymentId);
                                                                                                                      await loadPaymentDetailByPayment(paymentId);
                                                                                                                      await loadPaymentDetailImageByPayment(paymentId);
                                                                                                                      await loadPaymentDetailRemarkByPayment(paymentId);

                                                                                                                      lPaymentDetailShow = lPaymentDetail;
                                                                                                                      groupPaymentType = groupPaymentDeposit(lPaymentDetailShow);
                                                                                                                      await pop();
                                                                                                                    },
                                                                                                                  )
                                                                                                                ],
                                                                                                              ),
                                                                                                            ));
                                                                                                          });
                                                                                                    }
                                                                                                  },
                                                                                                  child: Padding(
                                                                                                    padding: const EdgeInsets.all(2.0),
                                                                                                    child: Text(
                                                                                                      oCcy.format(double.parse(mPaymentDetail.tlpayment_detail_actual_paid)),
                                                                                                      style: TextStyle(fontSize: 14),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        )),
                                                                                    SizedBox(
                                                                                        height: 32,
                                                                                        width: 150,
                                                                                        child: Align(
                                                                                          alignment: Alignment.centerRight,
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.only(right: 20.0),
                                                                                            child: Tooltip(
                                                                                              message: 'ส่วนต่าง',
                                                                                              child: Text(
                                                                                                oCcy.format(double.parse(mPaymentDetail.tlpayment_detail_diff_paid)),
                                                                                                style: const TextStyle(fontSize: 14),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        )),
                                                                                    SizedBox(
                                                                                        height: 32,
                                                                                        width: 160,
                                                                                        child: Tooltip(
                                                                                          message: 'หมายเหตุ',
                                                                                          child: TextFormFieldPDComment(
                                                                                              isStatusScreen: isStatusScreen,
                                                                                              paymentDetailId: mPaymentDetail.tlpayment_detail_id,
                                                                                              paymentDetailComment: mPaymentDetail.tlpayment_detail_comment,
                                                                                              callbackComment: (commentController) {
                                                                                                mPaymentDetail.tlpayment_detail_comment = commentController;
                                                                                              }),
                                                                                        )),
                                                                                    SizedBox(
                                                                                      child: isSelectCardEmp == 'ALL'
                                                                                          ? null
                                                                                          : IconButton(
                                                                                              tooltip: 'Add Images',
                                                                                              color: Colors.grey,
                                                                                              //hoverColor: Colors.green,
                                                                                              onPressed: () {
                                                                                                showDialog(
                                                                                                    barrierDismissible: false,
                                                                                                    context: context,
                                                                                                    builder: (context) {
                                                                                                      return Dialog(
                                                                                                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                                                                                                          child: PaymentImageScreen(
                                                                                                            isStatusScreen: isStatusScreen,
                                                                                                            lPaymentImageByType: lPaymentImage.where((e) => e.tlpayment_detail_id == mPaymentDetail.tlpayment_detail_id).toList(),
                                                                                                            lPaymentImageDBByType: lPaymentImageDB.where((e) => e.tlpayment_detail_id == mPaymentDetail.tlpayment_detail_id).toList(),
                                                                                                            paymentDetailId: mPaymentDetail.tlpayment_detail_id,
                                                                                                            paymentId: paymentId,
                                                                                                            callbackFunctions: (p0) {},
                                                                                                            callbackRemove: (ImageReId) {},
                                                                                                          ));
                                                                                                    });
                                                                                              },
                                                                                              icon: lPaymentImage.where((e) => e.tlpayment_detail_id == mPaymentDetail.tlpayment_detail_id).toList().isNotEmpty
                                                                                                  ? badges.Badge(
                                                                                                      badgeContent: Text(
                                                                                                        '${lPaymentImage.where((e) => e.tlpayment_detail_id == mPaymentDetail.tlpayment_detail_id).toList().length}',
                                                                                                        style: const TextStyle(color: Colors.white),
                                                                                                      ),
                                                                                                      showBadge: lPaymentImage.where((e) => e.tlpayment_detail_id == mPaymentDetail.tlpayment_detail_id).toList().isNotEmpty,
                                                                                                      badgeAnimation: const badges.BadgeAnimation.scale(),
                                                                                                      child: const Icon(
                                                                                                        Icons.add_photo_alternate_rounded,
                                                                                                      ),
                                                                                                    )
                                                                                                  : const Icon(
                                                                                                      Icons.add_photo_alternate_rounded,
                                                                                                    )),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      child: isSelectCardEmp == 'ALL'
                                                                                          ? null
                                                                                          : IconButton(
                                                                                              color: Colors.grey,
                                                                                              icon: lPaymentRemark.where((e) => e.tlpayment_detail_id == mPaymentDetail.tlpayment_detail_id).toList().isNotEmpty
                                                                                                  ? badges.Badge(
                                                                                                      badgeContent: Text(
                                                                                                        '${lPaymentRemark.where((e) => e.tlpayment_detail_id == mPaymentDetail.tlpayment_detail_id).toList().length}',
                                                                                                        style: const TextStyle(color: Colors.white),
                                                                                                      ),
                                                                                                      showBadge: lPaymentRemark.where((e) => e.tlpayment_detail_id == mPaymentDetail.tlpayment_detail_id).toList().isNotEmpty,
                                                                                                      badgeAnimation: const badges.BadgeAnimation.scale(),
                                                                                                      child: const Icon(
                                                                                                        Icons.edit_document,
                                                                                                      ),
                                                                                                    )
                                                                                                  : const Icon(
                                                                                                      Icons.edit_document,
                                                                                                      size: 20,
                                                                                                    ),
                                                                                              onPressed: () {
                                                                                                showDialog(
                                                                                                    barrierDismissible: false,
                                                                                                    context: context,
                                                                                                    builder: (context) {
                                                                                                      return Dialog(
                                                                                                        backgroundColor: Colors.transparent,
                                                                                                        child: RemarkPopUp(
                                                                                                          isStatusScreen: isStatusScreen,
                                                                                                          lPaymentRemarkByType: lPaymentRemark.where((e) => e.tlpayment_detail_id == mPaymentDetail.tlpayment_detail_id).toList(),
                                                                                                          paymentId: paymentId,
                                                                                                          paymentDetailId: mPaymentDetail.tlpayment_detail_id,
                                                                                                          callbackAdd: (lRemark) {},
                                                                                                          callbackRemove: (remarkReId) {},
                                                                                                        ),
                                                                                                      );
                                                                                                    });
                                                                                              },
                                                                                            ),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              );
                                                                            }),
                                                                      ],
                                                                    );
                                                                  })),
                                                ),
                                                Container(
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Colors.green[100],
                                                        borderRadius:
                                                            const BorderRadius
                                                                .vertical(
                                                                bottom: Radius
                                                                    .circular(
                                                                        16))),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        //isSelectCardEmp == 'ALL'
                                                        children: [
                                                          const SizedBox(
                                                            width: 60,
                                                          ),
                                                          //isSelectCardEmp =='ALL'?
                                                          const SizedBox(
                                                              child: Text(
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  'สรุปรายการนำส่ง : ')),
                                                          Card(
                                                            color: Colors
                                                                .green[100],
                                                            child: SizedBox(
                                                              width: 200,
                                                              child: InkWell(
                                                                hoverColor:
                                                                    Colors.green[
                                                                        200],
                                                                onTap: () {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return Dialog(
                                                                            backgroundColor: Colors
                                                                                .transparent,
                                                                            child: ChartIncome(
                                                                                selectCardEmp: isSelectCardEmp,
                                                                                oCcy: oCcy,
                                                                                dTotalIncome: dTotalIncome,
                                                                                lPaymentDetailShow: lPaymentDetailShow));
                                                                      });
                                                                },
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          4.0),
                                                                  child: Text(
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              16),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      'ยอดขาย : ${oCcy.format(dTotalIncome)}'),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Card(
                                                            color: Colors
                                                                .green[100],
                                                            child: SizedBox(
                                                              width: 200,
                                                              child: InkWell(
                                                                hoverColor:
                                                                    Colors.green[
                                                                        200],
                                                                onTap: () {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return Dialog(
                                                                            backgroundColor: Colors
                                                                                .transparent,
                                                                            child: ChartPaid(
                                                                                selectCardEmp: isSelectCardEmp,
                                                                                oCcy: oCcy,
                                                                                dTotalPaid: dTotalPaid,
                                                                                lPaymentDetailShow: lPaymentDetailShow));
                                                                      });
                                                                },
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          4),
                                                                  child: Text(
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              16),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      'ยอดนำส่ง : ${oCcy.format(dTotalPaid)}'),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Card(
                                                            color: Colors
                                                                .green[100],
                                                            child: SizedBox(
                                                              width: 250,
                                                              child: InkWell(
                                                                hoverColor:
                                                                    Colors.green[
                                                                        200],
                                                                onTap: () {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return Dialog(
                                                                            backgroundColor:
                                                                                Colors.transparent,
                                                                            child: ChartActual(
                                                                              selectCardEmp: isSelectCardEmp,
                                                                              oCcy: oCcy,
                                                                              dTotalActual: dTotalActual,
                                                                              lPaymentDetailShow: lPaymentDetailShow,
                                                                            ));
                                                                      });
                                                                },
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          4.0),
                                                                  child: Text(
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              16),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      'ยอดนำส่งจริง : ${oCcy.format(dTotalActual)}'),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Card(
                                                            color: Colors
                                                                .green[100],
                                                            child: SizedBox(
                                                              width: 200,
                                                              child: InkWell(
                                                                hoverColor:
                                                                    Colors.green[
                                                                        200],
                                                                onTap: () {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return Dialog(
                                                                            backgroundColor: Colors
                                                                                .transparent,
                                                                            child: ChartBalance(
                                                                                selectCardEmp: isSelectCardEmp,
                                                                                oCcy: oCcy,
                                                                                dTotalBalance: dTotalBalance,
                                                                                lPaymentDetailShow: lPaymentDetailShow));
                                                                      });
                                                                },
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          4.0),
                                                                  child: Text(
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              16),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      'ยอดส่วนต่าง : ${oCcy.format(dTotalBalance)}'),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                              ],
                                            )),
                                      ),
                                      const Expanded(
                                        child: SizedBox(),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: SizedBox(
                                          child:
                                              isSelectCardEmp == 'ALL' ||
                                                      isStatusScreen ==
                                                          'confirm' ||
                                                      lPaymentDetail.isEmpty
                                                  ? null
                                                  : Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        ElevatedButton(
                                                          onHover: (hover) {
                                                            isApproveHover =
                                                                hover;
                                                            setState(() {});
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                              foregroundColor:
                                                                  isApproveHover
                                                                      ? Colors
                                                                          .white
                                                                      : Colors.green[
                                                                          900],
                                                              backgroundColor:
                                                                  isApproveHover
                                                                      ? Colors.green[
                                                                          900]
                                                                      : Colors.green[
                                                                          200],
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50))),
                                                          child: const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Text(
                                                                '    อนุมัติ    '),
                                                          ),
                                                          onPressed: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Dialog(
                                                                    backgroundColor:
                                                                        Colors.grey[
                                                                            200],
                                                                    child:
                                                                        SizedBox(
                                                                      height:
                                                                          200,
                                                                      width:
                                                                          400,
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceAround,
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                30,
                                                                            child:
                                                                                Text(
                                                                              ' อนุมัติ การปิดผลัด ',
                                                                              style: TextStyle(color: Colors.green[900], fontSize: 18),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                ActionSlider.standard(
                                                                              height: 50,
                                                                              child: const Text('เลื่อน Silder เพื่อยืนยัน การอนุมัติ'),
                                                                              action: (controller) async {
                                                                                if (statusApproveValue == '-- เลือกสถานะการตรวจสอบ --') {
                                                                                } else {
                                                                                  controller.loading(); //starts loading animation
                                                                                  await Future.delayed(const Duration(milliseconds: 1200), () async {
                                                                                    isStatusScreen = 'confirm';

                                                                                    await updateStatusPaymentApproval(approvalId);
                                                                                    await updateStatusPayment(paymentId);
                                                                                  }); //starts success animation
                                                                                  controller.success();
                                                                                  await Future.delayed(const Duration(milliseconds: 1200), () async {
                                                                                    //! load Payment Status Waiting
                                                                                    await loadPaymentMasterCheck(siteDDValue, dateRec);
                                                                                    //!total
                                                                                    await sumPaymentMasterAll();

                                                                                    //! PaymentDetail
                                                                                    await loadPaymentDetailAll();
                                                                                    //!PaymentDetailShowAll
                                                                                    await sumPaymentDetailAll();
                                                                                    //! PaymentDetailImage
                                                                                    //! PaymentDetailRemark

                                                                                    // await loadPaymentDetailImageAll();
                                                                                    // await loadPaymentDetailRemarkAll();

                                                                                    Navigator.pop(context);
                                                                                    setState(() {});
                                                                                  });
                                                                                }
                                                                                //starts success animation
                                                                              },
                                                                              backgroundColor: Colors.green[100],
                                                                              toggleColor: Colors.green,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                });
                                                          },
                                                        ),
                                                        ElevatedButton(
                                                          onHover: (hover) {
                                                            isRejectHover =
                                                                hover;
                                                            setState(() {});
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                              foregroundColor:
                                                                  isRejectHover
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .red,
                                                              backgroundColor:
                                                                  isRejectHover
                                                                      ? Colors
                                                                          .red
                                                                      : Colors
                                                                          .white,
                                                              shape: RoundedRectangleBorder(
                                                                  side: const BorderSide(
                                                                      width: 2,
                                                                      color: Colors
                                                                          .red),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50))),
                                                          child: const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Text(
                                                                'ส่งกลับไปแก้ไข'),
                                                          ),
                                                          onPressed: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Dialog(
                                                                    backgroundColor:
                                                                        Colors.grey[
                                                                            200],
                                                                    child:
                                                                        SizedBox(
                                                                      height:
                                                                          200,
                                                                      width:
                                                                          400,
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceAround,
                                                                        children: [
                                                                          const SizedBox(
                                                                            height:
                                                                                30,
                                                                            child:
                                                                                Text(
                                                                              ' ส่งกลับไปแก้ไข ',
                                                                              style: TextStyle(color: Colors.red, fontSize: 18),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                ActionSlider.standard(
                                                                              height: 50,
                                                                              child: const Text('เลื่อน Silder เพื่อยืนยัน การส่งกลับไปแก้ไข'),
                                                                              action: (controller) async {
                                                                                if (statusApproveValue == '-- เลือกสถานะการตรวจสอบ --') {
                                                                                } else {
                                                                                  controller.loading(); //starts loading animation
                                                                                  await Future.delayed(const Duration(milliseconds: 1200), () async {
                                                                                    //สีแดง
                                                                                    isStatusScreen = 'reject';

                                                                                    await updateStatusPaymentApproval(approvalId);
                                                                                    await updateStatusPayment(paymentId);
                                                                                  }); //starts success animation
                                                                                  controller.success();
                                                                                  await Future.delayed(const Duration(milliseconds: 1200), () async {
                                                                                    //! load Payment Status Waiting
                                                                                    await loadPaymentMasterCheck(siteDDValue, dateRec);
                                                                                    //!total
                                                                                    await sumPaymentMasterAll();
                                                                                    //! PaymentDetail
                                                                                    await loadPaymentDetailAll();
                                                                                    //!PaymentDetailShowAll
                                                                                    await sumPaymentDetailAll();
                                                                                    //! PaymentDetailImage
                                                                                    //! PaymentDetailRemark

                                                                                    // await loadPaymentDetailImageAll();
                                                                                    // await loadPaymentDetailRemarkAll();

                                                                                    Navigator.pop(context);
                                                                                    setState(() {});
                                                                                  });
                                                                                }
                                                                                //starts success animation
                                                                              },
                                                                              backgroundColor: Colors.red[100],
                                                                              toggleColor: Colors.red,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                });
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                        ),
                                      )
                                    ],
                                  )),
                  ),
                ],
              )),
          Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(36))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SfDateRangePicker(
                        onSelectionChanged: _onSelectionChanged,
                        selectionMode: DateRangePickerSelectionMode.single,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: SizedBox(
                            child: Center(
                                child: Text(
                          '${selectedDate}',
                          style: const TextStyle(color: Colors.blueGrey),
                        ))),
                      ),
                      Center(
                        child:
                            SizedBox(width: 120, child: _buildDropdownSite()),
                      ),
                      const Expanded(child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                                : const Center(child: Text(' Load ')),
                          ),
                          onPressed: () async {
                            if (isCheckRun == false) {
                              dateRec = selectedDate;
                              print('Event Btn Run');
                              print(widget.lEmp.first.employee_id);
                              print(selectedDate);
                              print(siteDDValue);

                              setState(() {
                                runProcess = 'loadData';
                                isCheckRun = true;
                              });
                              //! load Payment Status Waiting
                              await loadPaymentMasterCheck(
                                  siteDDValue, dateRec);
//!total
                              await sumPaymentMasterAll();
                              //! PaymentDetail
                              await loadPaymentDetailAll();
                              //!PaymentDetailShowAll
                              await sumPaymentDetailAll();
                              //! PaymentDetailImage
                              //! PaymentDetailRemark
                              // await loadPaymentDetailImageAll();
                              // await loadPaymentDetailRemarkAll();
                              setState(() {
                                isCheckRun = false;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ]),
      ),
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        selectDateFrom = DateFormat('yyyy-MM-dd').format(args.value.startDate);
        selectDateTo = DateFormat('yyyy-MM-dd')
            .format(args.value.endDate ?? args.value.startDate);
      } else if (args.value is DateTime) {
        selectedDate = DateFormat('yyyy-MM-dd').format(args.value);
      }
    });
  }

  DropdownButton _buildDropdownSite() {
    return DropdownButton<String>(
      isExpanded: true,
      value: siteDDValue,
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
          siteDDValue = value!;
          print('siteDDValue :: $siteDDValue');
        });
      },
      items: lSiteId.map<DropdownMenuItem<String>>((String value) {
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

  _buildDropdownStatusApprove() {
    return StatefulBuilder(builder: (context, setState) {
      return DropdownButton<String>(
        isExpanded: true,
        value: statusApproveValue,
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
            statusApproveValue = value!;
          });
        },
        items:
            lStatusApproverShow.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(value),
            ),
          );
        }).toList(),
      );
    });
  }

  void clear() {
    lPaymentMaster.clear();
    lPaymentDetail.clear();
    lPaymentImage.clear();
    lPaymentImageDB.clear();

    lPaymentRemark.clear();
    lPaymentRemarkId.clear();

    dTotalIncome = 0.00;
    dTotalActual = 0.00;
    dTotalPaid = 0.00;
    dTotalBalance = 0.00;
    paymentControllers.clear();
    empReq = '';

    isStatusScreen = 'New';

    setState(() {});
  }

  Future loadSite() async {
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
    });
    String api = '${TlConstant.syncApi}baseSiteBranch.php?id=imed';
    lSite = [];
    await Dio().post(api, data: formData).then((value) {
      if (value.data == null) {
        print('Site Null !');
      } else {
        for (var site in value.data) {
          SiteModel newSite = SiteModel.fromMap(site);
          lSite.add(newSite);
        }
      }
    });
    setState(() {});
  }

  Future<String> employeeFullName(String emp_id) async {
    lEmployeeProfile = [];
    String emp_fullname = '';
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "employee_id": emp_id,
    });
    String api = '${TlConstant.syncApi}employee.php?id=imedfullname';

    await Dio().post(api, data: formData).then((value) {
      if (value.data == null) {
        emp_fullname = 'NoData';
      } else {
        for (var emp in value.data) {
          EmployeeModel newEmp = EmployeeModel.fromMap(emp);
          lEmployeeProfile.add(newEmp);
        }
        emp_fullname = lEmployeeProfile.first.emp_fullname;
      }
    });

    return emp_fullname;
  }

  Future loadPaymentMasterCheck(String siteDDValue, String dateRec) async {
    lPaymentMaster = [];

    dTotalPaid = 0.0;
    dTotalActual = 0.0;
    dTotalBalance = 0.0;
    siteToAddPaymentType = siteDDValue;

    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "site_id": siteDDValue,
      "date_receipt": dateRec
    });
    String api = '${TlConstant.syncApi}tlPayment.php?id=checkPayment';
//! จะไม่มี fullname

    await Dio().post(api, data: formData).then((value) async {
      if (value.data == null) {
        print('NoData');
      } else {
        for (var payment in value.data) {
          ChoicePaymentModel ee = ChoicePaymentModel.fromMap(payment);

          PaymentEmpFullNameModel newPaymentFullName = PaymentEmpFullNameModel(
              tlpayment_id: ee.tlpayment_id,
              tlpayment_imed_total: ee.tlpayment_imed_total,
              tlpayment_actual_total: ee.tlpayment_actual_total,
              tlpayment_diff_abs: ee.tlpayment_diff_abs,
              tlpayment_rec_date: ee.tlpayment_rec_date,
              tlpayment_rec_time_from: ee.tlpayment_rec_time_from,
              tlpayment_rec_time_to: ee.tlpayment_rec_time_to,
              tlpayment_rec_site: ee.tlpayment_rec_site,
              tlpayment_rec_by: ee.tlpayment_rec_by,
              tlpayment_create_date: ee.tlpayment_create_date,
              tlpayment_create_time: ee.tlpayment_create_time,
              tlpayment_modify_date: ee.tlpayment_modify_date,
              tlpayment_modify_time: ee.tlpayment_modify_time,
              tlpayment_status: ee.tlpayment_status,
              tlpayment_merge_id: ee.tlpayment_merge_id,
              tlpayment_comment: ee.tlpayment_comment,
              tlpayment_imed_total_income: ee.tlpayment_imed_total_income,
              tlpayment_print_number: ee.tlpayment_print_number,
              emp_fullname: await employeeFullName(ee.tlpayment_rec_by),
              tlpayment_approval_id: ee.tlpayment_approval_id);

          lPaymentMaster.add(newPaymentFullName);
        }

        PaymentEmpFullNameModel newPaymentALL = PaymentEmpFullNameModel(
            tlpayment_id: '',
            tlpayment_imed_total: '',
            tlpayment_actual_total: '',
            tlpayment_diff_abs: '',
            tlpayment_rec_date: '',
            tlpayment_rec_time_from: '',
            tlpayment_rec_time_to: '',
            tlpayment_rec_site: '',
            tlpayment_rec_by: '',
            tlpayment_create_date: '',
            tlpayment_create_time: '',
            tlpayment_modify_date: '',
            tlpayment_modify_time: '',
            tlpayment_status: '',
            tlpayment_merge_id: '',
            tlpayment_comment: '',
            tlpayment_imed_total_income: '',
            tlpayment_print_number: '',
            emp_fullname: 'ALL',
            tlpayment_approval_id: '');
        lPaymentMaster.add(newPaymentALL);

//?

        //paymentControllers.text = lPaymentMaster.first.tlpayment_comment;
      }
    });
  }

  Future sumPaymentMasterByPaymentId(String paymentId) async {
    dTotalIncome = 0;
    dTotalPaid = 0;
    dTotalActual = 0;
    dTotalBalance = 0;

    lPaymentMaster
        .where((element) => element.tlpayment_id == paymentId)
        .toList()
        .forEach((e) {
      if (e.emp_fullname != 'ALL') {
        dTotalIncome += double.parse(e.tlpayment_imed_total_income);
        dTotalPaid += double.parse(e.tlpayment_imed_total);
        dTotalActual += double.parse(e.tlpayment_actual_total);
        dTotalBalance += double.parse(e.tlpayment_diff_abs);
      }
    });
  }

  Future sumPaymentMasterAll() async {
    dTotalIncome = 0;
    dTotalPaid = 0;
    dTotalActual = 0;
    dTotalBalance = 0;

    for (var e in lPaymentMaster) {
      if (e.emp_fullname != 'ALL') {
        dTotalIncome += double.parse(e.tlpayment_imed_total_income);
        dTotalPaid += double.parse(e.tlpayment_imed_total);
        dTotalActual += double.parse(e.tlpayment_actual_total);
        dTotalBalance += double.parse(e.tlpayment_diff_abs);
      }
    }
  }

  Future loadPaymentDetailAll() async {
    lPaymentDetail = [];

    for (var e in lPaymentMaster) {
      if (e.emp_fullname != 'ALL') {
        FormData formData = FormData.fromMap({
          "token": TlConstant.token,
          "tlpayment_id": e.tlpayment_id,
        });
        String api = '${TlConstant.syncApi}tlPaymentDetail.php?id=payment';

        await Dio().post(api, data: formData).then((value) {
          if (value.data == null) {
            print('PaymentDetail Null !');
          } else {
            for (var pDetail in value.data) {
              PaymentDetailModel newPD = PaymentDetailModel.fromMap(pDetail);
              lPaymentDetail.add(newPD);
            }
            lPaymentDetail.sort((a, b) => int.parse(a.tlpayment_type_id)
                .compareTo(int.parse(b.tlpayment_type_id)));
            // groupPaymentType = groupPaymentDeposit(lPaymentDetail);
          }
        });
      }
    }
  }

  Future loadPaymentDetailByPayment(String paymentId) async {
    lPaymentDetail = [];

    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "tlpayment_id": paymentId,
    });
    String api = '${TlConstant.syncApi}tlPaymentDetail.php?id=payment';

    await Dio().post(api, data: formData).then((value) {
      if (value.data == null) {
        print('PaymentDetail Null !');
      } else {
        for (var pDetail in value.data) {
          PaymentDetailModel newPD = PaymentDetailModel.fromMap(pDetail);
          lPaymentDetail.add(newPD);
        }
        lPaymentDetail.sort((a, b) => int.parse(a.tlpayment_type_id)
            .compareTo(int.parse(b.tlpayment_type_id)));
      }
    });
  }

  Future sumPaymentDetailAll() async {
    lPaymentDetailShow = [];

    for (var e in lPaymentDetail) {
      var isChecklPaymentDetail = lPaymentDetailShow
          .where((ee) => ee.tlpayment_type == e.tlpayment_type)
          .where((eee) => eee.tlpayment_type_detail == e.tlpayment_type_detail)
          .toList();
      if (isChecklPaymentDetail.isEmpty) {
        lPaymentDetailShow.add(e);
      } else {
        var sumPaid = double.parse(isChecklPaymentDetail.first.paid) +
            double.parse(e.paid);
        lPaymentDetailShow
            .where((ee) => ee.tlpayment_type == e.tlpayment_type)
            .where(
                (eee) => eee.tlpayment_type_detail == e.tlpayment_type_detail)
            .first
            .paid = sumPaid.toString();
        var sumPaidGo = double.parse(isChecklPaymentDetail.first.paid_go) +
            double.parse(e.paid_go);
        lPaymentDetailShow
            .where((ee) => ee.tlpayment_type == e.tlpayment_type)
            .where(
                (eee) => eee.tlpayment_type_detail == e.tlpayment_type_detail)
            .first
            .paid_go = sumPaidGo.toString();

        var sumActualPaid = double.parse(
                isChecklPaymentDetail.first.tlpayment_detail_actual_paid) +
            double.parse(e.tlpayment_detail_actual_paid);
        lPaymentDetailShow
            .where((ee) => ee.tlpayment_type == e.tlpayment_type)
            .where(
                (eee) => eee.tlpayment_type_detail == e.tlpayment_type_detail)
            .first
            .tlpayment_detail_actual_paid = sumActualPaid.toString();

        var sumDiffPaid = double.parse(
                isChecklPaymentDetail.first.tlpayment_detail_diff_paid) +
            double.parse(e.tlpayment_detail_diff_paid);
        lPaymentDetailShow
            .where((ee) => ee.tlpayment_type == e.tlpayment_type)
            .where(
                (eee) => eee.tlpayment_type_detail == e.tlpayment_type_detail)
            .first
            .tlpayment_detail_diff_paid = sumDiffPaid.toString();
      }
    }
    groupPaymentType = groupPaymentDeposit(lPaymentDetailShow);
  }

  Future loadPaymentDetailImageAll() async {
    lPaymentImage = [];
    lPaymentImageDB = [];

    for (var e in lPaymentMaster) {
      if (e.emp_fullname != 'ALL') {
        FormData formData = FormData.fromMap(
            {"token": TlConstant.token, "tlpayment_id": e.tlpayment_id});
        String api = '${TlConstant.syncApi}tlPaymentDetailImage.php?id=payment';

        await Dio().post(api, data: formData).then((value) {
          if (value.data == null) {
            print('PaymentDetailImage Null !');
          } else {
            for (var pdImage in value.data) {
              PaymentDetailImageModel newPDImage =
                  PaymentDetailImageModel.fromMap(pdImage);
              lPaymentImageDB.add(newPDImage);
            }
            for (var img in lPaymentImageDB) {
              PaymentDetailImageTempModel imgTemp = PaymentDetailImageTempModel(
                  tlpayment_detail_image_id: img.tlpayment_detail_image_id,
                  tlpayment_detail_id: img.tlpayment_detail_id,
                  tlpayment_image_base64: '',
                  tlpayment_image_last_Name: '',
                  tlpayment_image_description: img.tlpayment_image_description,
                  tlpayment_id: img.tlpayment_id);
              lPaymentImage.add(imgTemp);
            }
          }
        });
      }
    }
  }

  Future loadPaymentDetailImageByPayment(String paymentId) async {
    lPaymentImage = [];
    lPaymentImageDB = [];

    FormData formData = FormData.fromMap(
        {"token": TlConstant.token, "tlpayment_id": paymentId});
    String api = '${TlConstant.syncApi}tlPaymentDetailImage.php?id=payment';

    await Dio().post(api, data: formData).then((value) {
      if (value.data == null) {
        print('PaymentDetailImage Null !');
      } else {
        for (var pdImage in value.data) {
          PaymentDetailImageModel newPDImage =
              PaymentDetailImageModel.fromMap(pdImage);
          lPaymentImageDB.add(newPDImage);
        }
        for (var img in lPaymentImageDB) {
          PaymentDetailImageTempModel imgTemp = PaymentDetailImageTempModel(
              tlpayment_detail_image_id: img.tlpayment_detail_image_id,
              tlpayment_detail_id: img.tlpayment_detail_id,
              tlpayment_image_base64: '',
              tlpayment_image_last_Name: '',
              tlpayment_image_description: img.tlpayment_image_description,
              tlpayment_id: img.tlpayment_id);
          lPaymentImage.add(imgTemp);
        }
      }
    });
  }

  Future loadPaymentDetailRemarkAll() async {
    lPaymentRemark = [];
    lPaymentRemarkId = [];
    for (var e in lPaymentMaster) {
      if (e.emp_fullname != 'ALL') {
        FormData formData = FormData.fromMap(
            {"token": TlConstant.token, "tlpayment_id": e.tlpayment_id});
        String api =
            '${TlConstant.syncApi}tlPaymentDetailRemark.php?id=payment';
        await Dio().post(api, data: formData).then((value) {
          if (value.data == null) {
            print('PaymentDetailRemark Null !');
          } else {
            for (var pdRemark in value.data) {
              PaymentDetailRemarkModel newPDRemark =
                  PaymentDetailRemarkModel.fromMap(pdRemark);
              lPaymentRemark.add(newPDRemark);
            }
            for (var id in lPaymentRemark) {
              lPaymentRemarkId.add(id.tlpayment_d_remark_id);
            }
          }
        });
      }
    }
  }

  Future loadPaymentDetailRemarkByPayment(String paymentId) async {
    lPaymentRemark = [];
    lPaymentRemarkId = [];

    FormData formData = FormData.fromMap(
        {"token": TlConstant.token, "tlpayment_id": paymentId});
    String api = '${TlConstant.syncApi}tlPaymentDetailRemark.php?id=payment';
    await Dio().post(api, data: formData).then((value) {
      if (value.data == null) {
        print('PaymentDetailRemark Null !');
      } else {
        for (var pdRemark in value.data) {
          PaymentDetailRemarkModel newPDRemark =
              PaymentDetailRemarkModel.fromMap(pdRemark);
          lPaymentRemark.add(newPDRemark);
        }
        for (var id in lPaymentRemark) {
          lPaymentRemarkId.add(id.tlpayment_d_remark_id);
        }
      }
    });
  }
  //!---Create---

  Future createHistory(
      String historyId,
      String table,
      String pkIdInTable,
      String editDate,
      String editTime,
      String editBy,
      String editColumn,
      String oldValue,
      String newVale) async {
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "1": historyId,
      "2": table,
      "3": pkIdInTable,
      "4": editDate,
      "5": editTime,
      "6": editBy,
      "7": editColumn,
      "8": oldValue,
      "9": newVale
    });
    String api = '${TlConstant.syncApi}tlHistory.php?id=create';
    await Dio().post(api, data: formData);
  }

  //! ถ้ามีการ Reject ระบบ จะตัดคนนั้นออกไป
  //! ------------------Update------------------
  Future updatePayment(
      String id, double dEditTotalActual, double dEditTotalBalance) async {
    String tAct = dEditTotalActual.toStringAsFixed(2);
    String tBal = dEditTotalBalance.toStringAsFixed(2);
    String moDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String moTime = DateFormat('HH:mm:ss').format(DateTime.now());
    String comment = paymentControllers.text;

    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "id": id,
      "tAct": tAct,
      "tBal": tBal,
      "moDate": moDate,
      "moTime": moTime,
      "comment": comment,
    });
    String api = '${TlConstant.syncApi}tlPayment.php?id=updateByEdit';
    await Dio().post(api, data: formData);
  }

  Future updatePaymentDetail(
      String id, double dActual, double dBalance, String eComment) async {
    String Act = dActual.toStringAsFixed(2);
    String Bal = dBalance.toStringAsFixed(2);

    String comment = eComment;

    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "id": id,
      "act": Act,
      "balance": Bal,
      "comment": comment,
    });
    String api = '${TlConstant.syncApi}tlPaymentDetail.php?id=update';
    await Dio().post(api, data: formData);
  }

  Future updateStatusPayment(String id) async {
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "id": id,
      "status": isStatusScreen,
    });
    String api = '${TlConstant.syncApi}tlPayment.php?id=send';
    await Dio().post(api, data: formData);
  }

  Future updateStatusPaymentApproval(String approvalId) async {
    String appDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String appTime = DateFormat('HH:mm:ss').format(DateTime.now());
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "id": approvalId,
      "status": isStatusScreen,
      "date": appDate,
      "time": appTime,
      "approveBy": widget.lEmp.first.employee_id,
    });
    String api = '${TlConstant.syncApi}tlPaymentApproval.php?id=send';
    await Dio().post(api, data: formData);
  }

  //! ------------ group ------------

  groupPaymentDeposit(List<PaymentDetailModel> lPaymentDetail) {
    double dDetailTotalIncome = 0.00;
    lPaymentDetail.sort((a, b) => int.parse(a.tlpayment_type_id)
        .compareTo(int.parse(b.tlpayment_type_id)));

    return groupBy(lPaymentDetail, (gKey) {
      dDetailTotalIncome = 0.00;
      lPaymentDetail
          .where((element) => element.tlpayment_type == gKey.tlpayment_type)
          .forEach((e) {
        dDetailTotalIncome += double.parse(e.paid);
      });

      var nameAndDate =
          '${gKey.tlpayment_type} (${oCcy.format(dDetailTotalIncome)}) ';
      return nameAndDate;
    });
    //=> gKey.emp_fullname);
  }

  pop() {
    setState(() {
      Navigator.pop(context);
    });
  }
}

class ChartIncome extends StatelessWidget {
  const ChartIncome({
    super.key,
    required this.selectCardEmp,
    required this.oCcy,
    required this.dTotalIncome,
    required this.lPaymentDetailShow,
  });
  final String selectCardEmp;
  final NumberFormat oCcy;
  final double dTotalIncome;
  final List<PaymentDetailModel> lPaymentDetailShow;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 600,
        width: 600,
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                  child: Text('ยอดรายได้รวม : ${oCcy.format(dTotalIncome)}')),
            ),
            SizedBox(child: Text('ปิดผลัดโดย : $selectCardEmp')),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: SfCircularChart(
                tooltipBehavior: TooltipBehavior(enable: true),
                //backgroundColor: Colors.grey[300],
                margin: const EdgeInsets.all(20),
                series: [
                  PieSeries<PaymentDetailModel, String>(
                    dataSource: lPaymentDetailShow,
                    xValueMapper: (PaymentDetailModel data, _) =>
                        '${data.tlpayment_type}\n(${data.tlpayment_type_detail})',
                    yValueMapper: (PaymentDetailModel data, _) =>
                        double.parse(data.paid),
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      labelPosition: ChartDataLabelPosition.inside,
                    ),
                    dataLabelMapper: (PaymentDetailModel data, _) =>
                        '${data.tlpayment_type_detail}\n${data.paid}',
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(),
            )
          ],
        ));
  }
}

class ChartPaid extends StatelessWidget {
  const ChartPaid({
    super.key,
    required this.selectCardEmp,
    required this.oCcy,
    required this.dTotalPaid,
    required this.lPaymentDetailShow,
  });
  final String selectCardEmp;
  final NumberFormat oCcy;
  final double dTotalPaid;
  final List<PaymentDetailModel> lPaymentDetailShow;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 600,
        width: 600,
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                  child:
                      Text('คำนวนยอดเงินนำส่ง : ${oCcy.format(dTotalPaid)}')),
            ),
            SizedBox(child: Text('ปิดผลัดโดย : $selectCardEmp')),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: SfCircularChart(
                tooltipBehavior: TooltipBehavior(enable: true),
                //backgroundColor: Colors.grey[300],
                margin: const EdgeInsets.all(20),
                series: [
                  PieSeries<PaymentDetailModel, String>(
                    dataSource: lPaymentDetailShow,
                    xValueMapper: (PaymentDetailModel data, _) =>
                        '${data.tlpayment_type}\n(${data.tlpayment_type_detail})',
                    yValueMapper: (PaymentDetailModel data, _) =>
                        double.parse(data.paid_go),
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      labelPosition: ChartDataLabelPosition.inside,
                    ),
                    dataLabelMapper: (PaymentDetailModel data, _) =>
                        '${data.tlpayment_type_detail}\n${data.paid_go}',
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(),
            )
          ],
        ));
  }
}

class ChartActual extends StatelessWidget {
  const ChartActual({
    super.key,
    required this.selectCardEmp,
    required this.oCcy,
    required this.dTotalActual,
    required this.lPaymentDetailShow,
  });
  final String selectCardEmp;
  final NumberFormat oCcy;
  final double dTotalActual;
  final List<PaymentDetailModel> lPaymentDetailShow;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 600,
        width: 600,
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                  child:
                      Text('ยอดเงินนำส่งจริง : ${oCcy.format(dTotalActual)}')),
            ),
            SizedBox(child: Text('ปิดผลัดโดย : $selectCardEmp')),
            const SizedBox(
              height: 8,
            ),
            //
            Expanded(
              child: SfCircularChart(
                tooltipBehavior: TooltipBehavior(enable: true),
                //backgroundColor: Colors.grey[300],
                margin: const EdgeInsets.all(20),
                series: [
                  PieSeries<PaymentDetailModel, String>(
                    dataSource: lPaymentDetailShow,
                    xValueMapper: (PaymentDetailModel data, _) =>
                        '${data.tlpayment_type}\n(${data.tlpayment_type_detail})',
                    yValueMapper: (PaymentDetailModel data, _) =>
                        double.parse(data.tlpayment_detail_actual_paid),
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      labelPosition: ChartDataLabelPosition.inside,
                    ),
                    dataLabelMapper: (PaymentDetailModel data, _) =>
                        '${data.tlpayment_type_detail}\n${data.tlpayment_detail_actual_paid}',
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(),
            )
          ],
        ));
  }
}

class ChartBalance extends StatelessWidget {
  const ChartBalance({
    super.key,
    required this.selectCardEmp,
    required this.oCcy,
    required this.dTotalBalance,
    required this.lPaymentDetailShow,
  });
  final String selectCardEmp;
  final NumberFormat oCcy;
  final double dTotalBalance;
  final List<PaymentDetailModel> lPaymentDetailShow;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 600,
        width: 600,
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                  child:
                      Text('รวมยอดส่วนต่าง : ${oCcy.format(dTotalBalance)}')),
            ),
            SizedBox(child: Text('ปิดผลัดโดย : $selectCardEmp')),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: SfCircularChart(
                tooltipBehavior: TooltipBehavior(enable: true),
                //backgroundColor: Colors.grey[300],
                margin: const EdgeInsets.all(20),
                series: [
                  PieSeries<PaymentDetailModel, String>(
                    dataSource: lPaymentDetailShow,
                    xValueMapper: (PaymentDetailModel data, _) =>
                        '${data.tlpayment_type}\n(${data.tlpayment_type_detail})',
                    yValueMapper: (PaymentDetailModel data, _) =>
                        double.parse(data.tlpayment_detail_diff_paid),
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      labelPosition: ChartDataLabelPosition.inside,
                    ),
                    dataLabelMapper: (PaymentDetailModel data, _) =>
                        '${data.tlpayment_type_detail}\n${data.tlpayment_detail_diff_paid}',
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(),
            )
          ],
        ));
  }
}
