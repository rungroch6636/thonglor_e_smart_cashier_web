// ignore_for_file: must_be_immutable, unused_field, use_build_context_synchronously

import 'package:action_slider/action_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:badges/badges.dart' as badges;
import 'package:thonglor_e_smart_cashier_web/models/paymentApproval_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/paymentDetailRemark_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/paymentDetail_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/payment_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/receipt_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/site_model.dart';
import 'package:thonglor_e_smart_cashier_web/screens/add_payment_type_screen.dart';
import 'package:thonglor_e_smart_cashier_web/screens/select_approver_popup.dart';
import 'package:thonglor_e_smart_cashier_web/screens/payment_image_screen.dart';
import 'package:thonglor_e_smart_cashier_web/util/constant.dart';
import 'package:collection/collection.dart';
import 'package:thonglor_e_smart_cashier_web/widgets/remarkPopup.dart';
import 'package:thonglor_e_smart_cashier_web/widgets/textFormFieldActual.dart';
import 'package:thonglor_e_smart_cashier_web/widgets/textFormFieldPDComment.dart';

import '../models/employee_model.dart';
import '../models/paymentDetailImageTemp_model.dart';
import '../models/paymentDetailImage_model.dart';

class CheckPaymentSingleScreen extends StatefulWidget {
  List<EmployeeModel> lEmp;
  List<PaymentApprovalModel> lPaymentApproval;
  Function callbackUpdate;
  CheckPaymentSingleScreen(
      {required this.lEmp,
      required this.lPaymentApproval,
      required this.callbackUpdate,
      super.key});

  @override
  State<CheckPaymentSingleScreen> createState() => _CheckPaymentSingleScreenState();
}

//emp nipaporn  0635644228 2023-11-15  two Site (หลี)
//emp arunrat_b 2023-06-01 one Site
class _CheckPaymentSingleScreenState extends State<CheckPaymentSingleScreen> {
  List<PaymentDetailImageTempModel> lPaymentImage = [];
  List<PaymentDetailImageModel> lPaymentImageDB = [];
  List<PaymentDetailRemarkModel> lPaymentRemark = [];

  List<String> lPaymentDetailId = [];
  List<String> lPaymentRemarkId = [];
  List<String> lPaymentRemarkRemoveId = [];

  List<String> lPaymentImageRemoveId = [];

  List<SiteModel> lSite = [];
  List<String> lSiteId = []; //['All Site'];
  String siteDDValue = 'R9';
  String siteToAddPaymentType = '';
  List<String> lPaymentDetailTypeId = [];

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

  String selectDateFrom = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String selectDateTo = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  //  '2023-11-07'; //DateFormat('yyyy-MM-dd').format(DateTime.now());

  bool isCheckRun = false;
  bool isCheckClickOii = false;
  bool isHover = false;

  bool isNew = false;
  bool isApprove = false;
  String isStatusScreen =
      ''; //!  isStatusScreen New Create Waiting Reject Confirm

  String checkTypeDate = '';

  List<ReceiptModel> lReceiptImed = [];

  List<double> lBalance = [];
  List<bool> lAddImage = [];
  String runProcess = 'start';
  final oCcy = NumberFormat(
    "#,##0.00",
  );
  double dTotalPaid = 0;
  double dTotalActual = 0;
  double dTotalBalance = 0;
  List<PaymentDetailModel> lPaymentDetail = [];
  List<PaymentModel> lPaymentChoice = [];
  List<EmployeeModel> lEmpFullName = [];
  List<PaymentModel> lPaymentMaster = [];

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

    Future.delayed(Duration(milliseconds: 1000), () async {
      await loadPaymentChoice();
      await loadEmpFullName();
    });
    statusApproveValue = lStatusApproverShow.first;
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
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      child: Text(
                          '${widget.lEmp.first.emp_fullname}  สาขาหลัก : ${widget.lEmp.first.site_id}'),
                    ),
                  ),
                  Expanded(
                    child: runProcess == 'start'
                        ? const SizedBox(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : paymentId == ''
                            ? Dialog(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(16.0))),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(16)),
                                  height: 400,
                                  width: 500,
                                  child: Column(
                                    children: [
                                      const Center(
                                          child: SizedBox(
                                              height: 50,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'รายการที่ต้องอนุมัติ',
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                              ))),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[400],
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: ListView.builder(
                                                itemCount:
                                                    lPaymentChoice.length,
                                                itemBuilder: (context, index) {
                                                  return Card(
                                                    child: InkWell(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      onTap: () async {
                                                        paymentId =
                                                            lPaymentChoice[
                                                                    index]
                                                                .tlpayment_id;

                                                        empReq = lEmpFullName
                                                            .where((ee) =>
                                                                ee.employee_id ==
                                                                lPaymentChoice[
                                                                        index]
                                                                    .tlpayment_rec_by)
                                                            .first
                                                            .emp_fullname;
                                                        isStatusScreen =
                                                            lPaymentChoice[
                                                                    index]
                                                                .tlpayment_status;
                                                        //! loadPaymentMaster
                                                        await loadPaymentMaster(
                                                            paymentId);
                                                        //! loadPaymentDetail
                                                        await loadPaymentDetail(
                                                            paymentId);
                                                        //! loadPaymentDetail.Image
                                                        await loadPaymentDetailImage(
                                                            paymentId);
                                                        //! loadPaymentDetail.Remark
                                                        await loadPaymentDetailRemark(
                                                            paymentId);

                                                        isApprove = true;

                                                        setState(() {});
                                                      },
                                                      onHover: (select) {
                                                        // setState;
                                                      },
                                                      hoverColor:
                                                          Colors.green[50],
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 8),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          4.0),
                                                              child: Text(
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          16),
                                                                  'ผู้ขออนุมัติ : ${lEmpFullName.where((ee) => ee.employee_id == lPaymentChoice[index].tlpayment_rec_by).first.emp_fullname} '),
                                                            ),
                                                            Text(
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14),
                                                                'สาขา : ${lPaymentChoice[index].tlpayment_rec_site} วันที่ : ${lPaymentChoice[index].tlpayment_rec_date} [ ${lPaymentChoice[index].tlpayment_rec_time_from} - ${lPaymentChoice[index].tlpayment_rec_time_to} ]'),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          4.0),
                                                              child: Text(
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          14),
                                                                  'Paid : ${lPaymentChoice[index].tlpayment_imed_total}, Actual : ${lPaymentChoice[index].tlpayment_actual_total}, Balance : ${lPaymentChoice[index].tlpayment_diff_abs}'),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          4.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    lPaymentChoice[
                                                                            index]
                                                                        .tlpayment_status,
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .blue),
                                                                  ),
                                                                  Text(
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14),
                                                                      'วันที่สร้าง : ${lPaymentChoice[index].tlpayment_create_date} ${lPaymentChoice[index].tlpayment_create_time}'),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                            : SizedBox(
                                child: Row(children: [
                                  Expanded(
                                    flex: 8,
                                    child: SizedBox(
                                        child: isCheckRun
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 16,
                                                        vertical: 8),
                                                    child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          'ผู้ขออนุมัติ :: ${empReq}',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16),
                                                        )),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8.0),
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .green[50],
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .vertical(
                                                                    bottom: Radius
                                                                        .circular(
                                                                            16))),
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                          24),
                                                              child: lPaymentDetail
                                                                      .isEmpty
                                                                  ? const SizedBox(
                                                                      height:
                                                                          40,
                                                                      child:
                                                                          Center(
                                                                        child: Text(
                                                                            'No Data'),
                                                                      ),
                                                                    )
                                                                  : SizedBox(
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height /
                                                                          2.2,
                                                                      child: ListView.builder(
                                                                          itemCount: groupPaymentType.length,
                                                                          itemBuilder: (context, indexHeader) {
                                                                            String
                                                                                gPaymentType =
                                                                                groupPaymentType.keys.elementAt(indexHeader);
                                                                            List<PaymentDetailModel>
                                                                                data =
                                                                                groupPaymentType.values.elementAt(indexHeader);

                                                                            return Column(
                                                                              children: [
                                                                                Card(
                                                                                    color: Colors.green[100],
                                                                                    child: Align(
                                                                                      alignment: Alignment.centerLeft,
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                        child: Text(
                                                                                          gPaymentType,
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
                                                                                      return Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                        children: [
                                                                                          SizedBox(
                                                                                            height: 40,
                                                                                            width: 60,
                                                                                            child: Align(
                                                                                              alignment: Alignment.center,
                                                                                              child: Text(
                                                                                                mPaymentDetail.tlpayment_detail_site_id,
                                                                                                style: TextStyle(fontSize: 16),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: 40,
                                                                                            width: 240,
                                                                                            child: Align(
                                                                                              alignment: Alignment.center,
                                                                                              child: Text(
                                                                                                mPaymentDetail.tlpayment_type_detail,
                                                                                                style: TextStyle(fontSize: 16),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: 40,
                                                                                            width: 150,
                                                                                            child: Align(
                                                                                              alignment: Alignment.centerRight,
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsets.only(right: 20.0),
                                                                                                child: Tooltip(
                                                                                                  message: 'ยอดนำส่งจาก Imed',
                                                                                                  child: Text(
                                                                                                    oCcy.format(double.parse(mPaymentDetail.paid_go)),
                                                                                                    style: TextStyle(fontSize: 16),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(
                                                                                              height: 40,
                                                                                              width: 160,
                                                                                              child: Tooltip(
                                                                                                message: 'นำส่งจริง',
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.only(bottom: 8.0),
                                                                                                  child: TextFormFieldActual(
                                                                                                      isStatusScreen: isStatusScreen,
                                                                                                      lPaymentDetail: lPaymentDetail,
                                                                                                      paymentDetailId: mPaymentDetail.tlpayment_detail_id,
                                                                                                      actual: mPaymentDetail.tlpayment_detail_actual_paid,
                                                                                                      paid_go: mPaymentDetail.paid_go,
                                                                                                      dTotalPaid: dTotalPaid,
                                                                                                      callbackDiff: (diff) {
                                                                                                        mPaymentDetail.tlpayment_detail_diff_paid = diff;
                                                                                                      },
                                                                                                      callbackDTotalActual: (DTotalActual) {
                                                                                                        dTotalActual = DTotalActual;
                                                                                                      },
                                                                                                      callbackDTotalBalance: (DTotalBalance) {
                                                                                                        if (oCcy.format(DTotalBalance) == '-0.00') {
                                                                                                          dTotalBalance = 0.00;
                                                                                                        } else {
                                                                                                          dTotalBalance = DTotalBalance;
                                                                                                        }
                                                                                                      },
                                                                                                      callbackLPaymentDetail: (lPD) {
                                                                                                        lPaymentDetail = lPD;
                                                                                                        setState(() {});
                                                                                                      }),
                                                                                                ),
                                                                                              )),
                                                                                          SizedBox(
                                                                                              height: 40,
                                                                                              width: 150,
                                                                                              child: Align(
                                                                                                alignment: Alignment.centerRight,
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.only(right: 20.0),
                                                                                                  child: Tooltip(
                                                                                                    message: 'ส่วนต่าง',
                                                                                                    child: Text(
                                                                                                      oCcy.format(double.parse(mPaymentDetail.tlpayment_detail_diff_paid)),
                                                                                                      style: const TextStyle(fontSize: 16),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              )),
                                                                                          SizedBox(
                                                                                              height: 40,
                                                                                              width: 160,
                                                                                              child: Tooltip(
                                                                                                message: 'หมายเหตุ',
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.only(bottom: 8.0),
                                                                                                  child: TextFormFieldPDComment(
                                                                                                      isStatusScreen: isStatusScreen,
                                                                                                      paymentDetailId: mPaymentDetail.tlpayment_detail_id,
                                                                                                      paymentDetailComment: mPaymentDetail.tlpayment_detail_comment,
                                                                                                      callbackComment: (commentController) {
                                                                                                        mPaymentDetail.tlpayment_detail_comment = commentController;
                                                                                                        setState(() {});
                                                                                                      }),
                                                                                                ),
                                                                                              )),
                                                                                          SizedBox(
                                                                                            child: IconButton(
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
                                                                                                              callbackFunctions: (p0) {
                                                                                                                for (var ee in p0) {
                                                                                                                  var isCheckImage = lPaymentImage.where((e0) => e0.tlpayment_detail_image_id == ee.tlpayment_detail_image_id).toList();
                                                                                                                  if (isCheckImage.isEmpty) {
                                                                                                                    lPaymentImage.add(ee);
                                                                                                                  }
                                                                                                                }
                                                                                                                setState(() {});
                                                                                                              },
                                                                                                              callbackRemove: (ImageReId) {
                                                                                                                lPaymentImage.removeWhere((re) => re.tlpayment_detail_image_id == ImageReId);
                                                                                                                lPaymentImageRemoveId.add(ImageReId);

                                                                                                                setState(() {});
                                                                                                              },
                                                                                                              callbackComment: (p1){},
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
                                                                                            child: IconButton(
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
                                                                                                          callbackAdd: (lRemark) {
                                                                                                            for (var ee in lRemark) {
                                                                                                              var isCheckLRemark = lPaymentRemark.where((e0) => e0.tlpayment_d_remark_id == ee.tlpayment_d_remark_id).toList();
                                                                                                              if (isCheckLRemark.isEmpty) {
                                                                                                                lPaymentRemark.add(ee);
                                                                                                              }
                                                                                                            }
                                                                                                            setState(() {});
                                                                                                          },
                                                                                                          callbackRemove: (remarkReId) {
                                                                                                            lPaymentRemark.removeWhere((re) => re.tlpayment_d_remark_id == remarkReId);
                                                                                                            lPaymentRemarkRemoveId.add(remarkReId);
                                                                                                            setState(() {});
                                                                                                          },
                                                                                                        ),
                                                                                                      );
                                                                                                    });
                                                                                              },
                                                                                            ),
                                                                                          )
                                                                                        ],
                                                                                      );
                                                                                    }),
                                                                              ],
                                                                            );
                                                                          })),
                                                            ),
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                          .green[
                                                                      200],
                                                                  borderRadius: const BorderRadius
                                                                      .vertical(
                                                                      bottom: Radius
                                                                          .circular(
                                                                              16))),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top:
                                                                            8.0,
                                                                        bottom:
                                                                            8.0,
                                                                        right:
                                                                            22),
                                                                child: Row(
                                                                  children: [
                                                                    const Expanded(
                                                                        child:
                                                                            SizedBox()),
                                                                    const SizedBox(
                                                                      width:
                                                                          150,
                                                                      child:
                                                                          Text(
                                                                        'Total Paid ::',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          150,
                                                                      child:
                                                                          Text(
                                                                        oCcy.format(
                                                                            dTotalPaid),
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                16),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width:
                                                                          150,
                                                                      child:
                                                                          Text(
                                                                        'Total Actual ::',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          150,
                                                                      child:
                                                                          Text(
                                                                        oCcy.format(
                                                                            dTotalActual),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            color: oCcy.format(dTotalActual) != oCcy.format(dTotalPaid)
                                                                                ? Colors.red
                                                                                : null),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width:
                                                                          150,
                                                                      child:
                                                                          Text(
                                                                        'Total Balance ::',
                                                                        textAlign:
                                                                            TextAlign.end,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          150,
                                                                      child:
                                                                          Text(
                                                                        oCcy.format(
                                                                            dTotalBalance),
                                                                        textAlign:
                                                                            TextAlign.end,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            color: oCcy.format(dTotalBalance) != '0.00'
                                                                                ? Colors.red
                                                                                : null),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8),
                                                    child: Container(
                                                      color: isStatusScreen ==
                                                                  'waiting' ||
                                                              isStatusScreen ==
                                                                  'confirm'
                                                          ? Colors.grey[300]
                                                          : null, // 'New'  'create' 'reject'
                                                      height: 42,
                                                      child: TextFormField(
                                                        readOnly: isStatusScreen ==
                                                                    'waiting' ||
                                                                isStatusScreen ==
                                                                    'confirm'
                                                            ? true
                                                            : false, // 'New'  'create' 'reject'
                                                        decoration:
                                                            const InputDecoration(
                                                                hintText:
                                                                    "หมายเหตุ : "),
                                                        controller:
                                                            paymentControllers,
                                                      ),
                                                    ),
                                                  ),
                                                  const Expanded(
                                                      child: SizedBox()),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            isApprove
                                                                ? null
                                                                : Colors.grey,
                                                      ),
                                                      child: const Text(
                                                          ' สถานะการตรวจสอบ '),
                                                      onPressed: () async {
                                                        if (isApprove) {
                                                          if (lPaymentDetail
                                                              .isEmpty) {
                                                          } else {
                                                            showDialog(
                                                                barrierDismissible:
                                                                    false,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Center(
                                                                      child: SizedBox(
                                                                          height: 300,
                                                                          width: 600,
                                                                          child: Card(
                                                                            child:
                                                                                Column(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      const SizedBox(
                                                                                        width: 20,
                                                                                      ),
                                                                                      const Text(
                                                                                        'เลือกสถานะการตรวจสอบ',
                                                                                        style: TextStyle(fontSize: 18),
                                                                                      ),
                                                                                      Container(
                                                                                        alignment: Alignment.topCenter,
                                                                                        height: 60,
                                                                                        width: 20,
                                                                                        child: IconButton(
                                                                                          color: Colors.red,
                                                                                          icon: const Icon(Icons.cancel),
                                                                                          onPressed: () {
                                                                                            Navigator.pop(context);
                                                                                          },
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                                                  child: Center(
                                                                                      child: Row(
                                                                                    children: [
                                                                                      Expanded(
                                                                                          child: Padding(
                                                                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                                                                        child: _buildDropdownStatusApprove(),
                                                                                      )),
                                                                                    ],
                                                                                  )),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(20.0),
                                                                                  child: ActionSlider.standard(
                                                                                    height: 50,
                                                                                    child: statusApproveValue == '-- เลือกสถานะการตรวจสอบ --' ? const Text('เลือก สถานะการตรวจสอบ ก่อนทำการยืนยัน ') : const Text('เลื่อน Silder เพื่อยืนยัน สถานะ'),
                                                                                    action: (controller) async {
                                                                                      if (statusApproveValue == '-- เลือกสถานะการตรวจสอบ --') {
                                                                                      } else {
                                                                                        controller.loading(); //starts loading animation
                                                                                        await Future.delayed(const Duration(milliseconds: 1200), () async {
                                                                                          var splitStatus = statusApproveValue.split(' : ');

                                                                                          if (splitStatus[1] == 'Confirm') {
                                                                                            isStatusScreen = 'confirm';
                                                                                          } else if (splitStatus[1] == 'Reject') {
                                                                                            isStatusScreen = 'reject';
                                                                                          }

                                                                                          await updateStatusPaymentApproval(paymentId);

                                                                                          await updateStatusPayment(paymentId);
                                                                                        }); //starts success animation
                                                                                        controller.success();
                                                                                        await Future.delayed(const Duration(milliseconds: 1200), () {
                                                                                          widget.callbackUpdate();
                                                                                          clear();

                                                                                          Navigator.pop(context);
                                                                                        });
                                                                                      }
                                                                                      //starts success animation
                                                                                    },
                                                                                    backgroundColor: Colors.green[100],
                                                                                    toggleColor: Colors.green,
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          )));
                                                                });
                                                          }
                                                        }
                                                      },
                                                    ),
                                                  )
                                                ],
                                              )),
                                  ),
                                ]),
                              ),
                  ),
                ],
              )),
        ]),
      ),
    );
  }

  void clear() {
    lPaymentMaster.clear();
    lPaymentChoice.clear();
    lPaymentDetail.clear();
    lPaymentDetailId.clear();
    lPaymentDetailTypeId.clear();
    lPaymentImage.clear();
    lPaymentImageDB.clear();
    lPaymentImageRemoveId.clear();
    lPaymentRemark.clear();
    lPaymentRemarkId.clear();
    lPaymentRemarkRemoveId.clear();

    dTotalActual = 0.00;
    dTotalPaid = 0.00;
    dTotalBalance = 0.00;
    paymentControllers.clear();
    empReq = '';

    isApprove = false;
    isStatusScreen = 'New';

    setState(() {});
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

  Future loadPaymentChoice() async {
    lPaymentChoice = [];

    for (var e in widget.lPaymentApproval) {
      FormData formData = FormData.fromMap({
        "token": TlConstant.token,
        "id": e.tlpayment_id,
      });
      String api = '${TlConstant.syncApi}tlPayment.php?id=1';

      await Dio().post(api, data: formData).then((value) {
        if (value.data == null) {
          print('NoData');
        } else {
          for (var payment in value.data) {
            PaymentModel newPayment = PaymentModel.fromMap(payment);
            lPaymentChoice.add(newPayment);
          }
        }
      });
    }
  }

  Future loadEmpFullName() async {
    lEmpFullName = [];

    for (var e in lPaymentChoice) {
      FormData formData = FormData.fromMap({
        "token": TlConstant.token,
        "employee_id": e.tlpayment_rec_by,
      });
      String api = '${TlConstant.syncApi}employee.php?id=fullname';

      await Dio().post(api, data: formData).then((value) {
        if (value.data == null) {
          print('NoData');
        } else {
          for (var emp in value.data) {
            EmployeeModel newEmp = EmployeeModel.fromMap(emp);
            lEmpFullName.add(newEmp);
          }
        }
      });
    }
    runProcess = 'loadData';
    setState(() {});
  }

  Future loadPaymentMaster(String paymentId) async {
    dTotalPaid = 0.0;
    dTotalActual = 0.0;
    dTotalBalance = 0.0;
    siteToAddPaymentType = '';
    lPaymentMaster =
        lPaymentChoice.where((e) => e.tlpayment_id == paymentId).toList();

    siteToAddPaymentType = lPaymentMaster.first.tlpayment_rec_site;
    dTotalPaid = double.parse(lPaymentMaster.first.tlpayment_imed_total);
    dTotalActual = double.parse(lPaymentMaster.first.tlpayment_actual_total);
    dTotalBalance = double.parse(lPaymentMaster.first.tlpayment_diff_abs);
    paymentControllers.text = lPaymentMaster.first.tlpayment_comment;
  }

  Future loadPaymentDetail(String paymentId) async {
    lPaymentDetail = [];
    lPaymentDetailTypeId = [];

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
        for (var i = 0; i < lPaymentDetail.length; i++) {
          lPaymentDetailTypeId.add(lPaymentDetail[i].tlpayment_type_detail_id);
          lPaymentDetailId.add(lPaymentDetail[i].tlpayment_detail_id);
        }
        groupPaymentType = groupPaymentDeposit(lPaymentDetail);
      }
    });
  }

  Future loadPaymentDetailImage(String paymentId) async {
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

  Future loadPaymentDetailRemark(String paymentId) async {
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

  //! ------------------Update------------------

  Future updatePayment(String id) async {
    String tAct = dTotalActual.toStringAsFixed(2);
    String tBal = dTotalBalance.toStringAsFixed(2);
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
    String api = '${TlConstant.syncApi}tlPayment.php?id=update';
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

  Future updateStatusPaymentApproval(String id) async {
    var PAid = widget.lPaymentApproval
        .where((e) => e.tlpayment_id == id)
        .first
        .tlpayment_approval_id;

    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "id": PAid,
      "status": isStatusScreen,
    });
    String api = '${TlConstant.syncApi}tlPaymentApproval.php?id=send';
    await Dio().post(api, data: formData);
  }

  //! ------------------Create------------------

  //! Payment
  Future createPayment() async {
    String dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String timeNow = DateFormat('HH:mm:ss').format(DateTime.now());
    String status = 'create';

    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "tlpayment_id": paymentId,
      "tlpayment_imed_total": dTotalPaid.toStringAsFixed(2),
      "tlpayment_actual_total": dTotalActual.toStringAsFixed(2),
      "tlpayment_diff_abs": dTotalBalance.toStringAsFixed(2),
      "tlpayment_rec_date": dateRec,
      "tlpayment_rec_time_from": startTime,
      "tlpayment_rec_time_to": endTime,
      "tlpayment_rec_site": siteToAddPaymentType,
      "tlpayment_rec_by": widget.lEmp.first.employee_id,
      "tlpayment_create_date": dateNow,
      "tlpayment_create_time": timeNow,
      "tlpayment_modify_date": '',
      "tlpayment_modify_time": '',
      "tlpayment_status": status,
      "tlpayment_merge_id": '',
      "tlpayment_comment": paymentControllers.text
    });
    String api = '${TlConstant.syncApi}tlPayment.php?id=create';

    await Dio().post(api, data: formData);
    isStatusScreen = status;
  }

  //! PaymentDetail
  Future createPaymentDetail() async {
    for (var PD in lPaymentDetail) {
      FormData formData = FormData.fromMap({
        "token": TlConstant.token,
        "tlpayment_detail_id": PD.tlpayment_detail_id,
        "tlpayment_id": PD.tlpayment_id,
        "tlpayment_type_id": PD.tlpayment_type_id,
        "tlpayment_type": PD.tlpayment_type,
        "tlpayment_type_detail_id": PD.tlpayment_type_detail_id,
        "tlpayment_type_detail": PD.tlpayment_type_detail,
        "opd_paid": PD.opd_paid,
        "ipd_paid": PD.ipd_paid,
        "paid": PD.paid,
        "paid_go": PD.paid_go,
        "prpdsp": PD.prpdsp,
        "tlpayment_detail_site_id": PD.tlpayment_detail_site_id,
        "tlpayment_detail_actual_paid": PD.tlpayment_detail_actual_paid,
        "tlpayment_detail_diff_paid": PD.tlpayment_detail_diff_paid,
        "tlpayment_detail_comment": PD.tlpayment_detail_comment,
      });
      String api = '${TlConstant.syncApi}tlPaymentDetail.php?id=create';

      await Dio().post(api, data: formData);
    }
  }

  Future createPaymentDetailByModel(PaymentDetailModel PD) async {
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "tlpayment_detail_id": PD.tlpayment_detail_id,
      "tlpayment_id": PD.tlpayment_id,
      "tlpayment_type_id": PD.tlpayment_type_id,
      "tlpayment_type": PD.tlpayment_type,
      "tlpayment_type_detail_id": PD.tlpayment_type_detail_id,
      "tlpayment_type_detail": PD.tlpayment_type_detail,
      "opd_paid": PD.opd_paid,
      "ipd_paid": PD.ipd_paid,
      "paid": PD.paid,
      "paid_go": PD.paid_go,
      "prpdsp": PD.prpdsp,
      "tlpayment_detail_site_id": PD.tlpayment_detail_site_id,
      "tlpayment_detail_actual_paid": PD.tlpayment_detail_actual_paid,
      "tlpayment_detail_diff_paid": PD.tlpayment_detail_diff_paid,
      "tlpayment_detail_comment": PD.tlpayment_detail_comment,
    });
    String api = '${TlConstant.syncApi}tlPaymentDetail.php?id=create';

    await Dio().post(api, data: formData);
  }

  //! PaymentDetailRemark
  Future createPaymentDetailRemark() async {
    for (var remark in lPaymentRemark) {
      FormData formData = FormData.fromMap({
        "token": TlConstant.token,
        "tlpayment_d_remark_id": remark.tlpayment_d_remark_id,
        "tlpayment_detail_id": remark.tlpayment_detail_id,
        "tlpayment_id": remark.tlpayment_id,
        "tlpayment_d_remark_bank": remark.tlpayment_d_remark_bank,
        "tlpayment_d_remark_date": remark.tlpayment_d_remark_date,
        "tlpayment_d_remark_time": remark.tlpayment_d_remark_time,
        "tlpayment_d_remark_amount": remark.tlpayment_d_remark_amount,
        "tlpayment_d_remark_comment": remark.tlpayment_d_remark_comment,
      });

      String api = '${TlConstant.syncApi}tlPaymentDetailRemark.php?id=create';
      await Dio().post(api, data: formData);
    }
  }

  Future createPaymentDetailRemarkByModel(
      PaymentDetailRemarkModel remark) async {
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "tlpayment_d_remark_id": remark.tlpayment_d_remark_id,
      "tlpayment_detail_id": remark.tlpayment_detail_id,
      "tlpayment_id": remark.tlpayment_id,
      "tlpayment_d_remark_bank": remark.tlpayment_d_remark_bank,
      "tlpayment_d_remark_date": remark.tlpayment_d_remark_date,
      "tlpayment_d_remark_time": remark.tlpayment_d_remark_time,
      "tlpayment_d_remark_amount": remark.tlpayment_d_remark_amount,
      "tlpayment_d_remark_comment": remark.tlpayment_d_remark_comment,
    });

    String api = '${TlConstant.syncApi}tlPaymentDetailRemark.php?id=create';
    await Dio().post(api, data: formData);
  }

  //! PaymentDetailImageDB
  Future createPaymentDetailImageDB() async {
    for (var img in lPaymentImage) {
      if (img.tlpayment_image_base64.isNotEmpty) {
        var image_path =
            '${TlConstant.syncApi}UploadImages/PaymentType/${widget.lEmp.first.employee_id}/$dateRec/$siteToAddPaymentType/${img.tlpayment_detail_id}/${img.tlpayment_detail_image_id}.${img.tlpayment_image_last_Name}';
        //! ToDB
        FormData formData = FormData.fromMap({
          "token": TlConstant.token,
          "tlpayment_detail_image_id": img.tlpayment_detail_image_id,
          "tlpayment_detail_id": img.tlpayment_detail_id,
          "tlpayment_image_path": image_path,
          "tlpayment_image_description": img.tlpayment_image_description,
          "tlpayment_id": img.tlpayment_id,
        });

        String api = '${TlConstant.syncApi}tlPaymentDetailImage.php?id=create';
        await Dio().post(api, data: formData);
      }
    }
  }

  Future createPaymentDetailImageDBByModel(
      PaymentDetailImageTempModel img) async {
    if (img.tlpayment_image_base64.isNotEmpty) {
      var image_path =
          '${TlConstant.syncApi}UploadImages/PaymentType/${widget.lEmp.first.employee_id}/$dateRec/$siteToAddPaymentType/${img.tlpayment_detail_id}/${img.tlpayment_detail_image_id}.${img.tlpayment_image_last_Name}';
      //! ToDB
      FormData formData = FormData.fromMap({
        "token": TlConstant.token,
        "tlpayment_detail_image_id": img.tlpayment_detail_image_id,
        "tlpayment_detail_id": img.tlpayment_detail_id,
        "tlpayment_image_path": image_path,
        "tlpayment_image_description": img.tlpayment_image_description,
        "tlpayment_id": img.tlpayment_id,
      });

      String api = '${TlConstant.syncApi}tlPaymentDetailImage.php?id=create';
      await Dio().post(api, data: formData);
    }
  }

  //! PaymentDetailImageFolder
  Future createPaymentDetailImageFolder() async {
    for (var img in lPaymentImage) {
      //!upload/Name/Date/Site/type_id/iMageName= type_id_ImageId
      FormData formDataImg = FormData.fromMap({
        "base64data": img.tlpayment_image_base64,
        "typeFolder": 'PaymentType',
        "name": widget.lEmp.first.employee_id,
        "date": dateRec,
        "site": siteToAddPaymentType,
        "type_id": img.tlpayment_detail_id,
        "lastname": img.tlpayment_image_last_Name,
        "imageId": img.tlpayment_detail_image_id,
      });
      await Dio()
          .post('${TlConstant.syncApi}uploadFile.php', data: formDataImg);
    }
  }

  Future createPaymentDetailImageFolderByModel(
      PaymentDetailImageTempModel img) async {
    //!upload/Name/Date/Site/type_id/iMageName= type_id_ImageId
    FormData formDataImg = FormData.fromMap({
      "base64data": img.tlpayment_image_base64,
      "typeFolder": 'PaymentType',
      "name": widget.lEmp.first.employee_id,
      "date": dateRec,
      "site": siteToAddPaymentType,
      "type_id": img.tlpayment_detail_id,
      "lastname": img.tlpayment_image_last_Name,
      "imageId": img.tlpayment_detail_image_id,
    });
    await Dio().post('${TlConstant.syncApi}uploadFile.php', data: formDataImg);
  }

  groupPaymentDeposit(List<PaymentDetailModel> lPaymentDetail) {
    double dTotalPaid = 0.00;
    return groupBy(lPaymentDetail, (gKey) {
      dTotalPaid = 0.00;
      lPaymentDetail
          .where((element) => element.tlpayment_type == gKey.tlpayment_type)
          .forEach((e) {
        dTotalPaid += double.parse(e.paid);
      });

      var nameAndDate = '${gKey.tlpayment_type} (${oCcy.format(dTotalPaid)}) ';
      return nameAndDate;
    });
    //=> gKey.emp_fullname);
  }
}
