// ignore_for_file: must_be_immutable, unused_field, use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:badges/badges.dart' as badges;
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

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart ' as pw;
import 'package:printing/printing.dart';

import '../models/employee_model.dart';
import '../models/paymentDetailImageTemp_model.dart';
import '../models/paymentDetailImage_model.dart';

class PaymentTypeScreen extends StatefulWidget {
  List<EmployeeModel> lEmp;
  PaymentTypeScreen({required this.lEmp, super.key});

  @override
  State<PaymentTypeScreen> createState() => _PaymentTypeScreenState();
}

//emp nipaporn  0635644228 2023-11-15  two Site (หลี)
//emp arunrat_b 2023-06-01 one Site
class _PaymentTypeScreenState extends State<PaymentTypeScreen> {
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
  bool isSend = false;
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
  List<PaymentModel> lPaymentMaster = [];

  var groupName;

  bool isLoopRun = false;
  bool isIconSelect = false;

  TextEditingController paymentControllers = TextEditingController();

  double dTotalIncome = 0;
  String printNumber = '';

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
    startTime = '${startTimeHourDDValue}:${startTimeMinuteDDValue}:00';
    endTime = '${endTimeHourDDValue}:${endTimeMinuteDDValue}:59';
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
                        ? Container(
                            child: const Center(
                              child: Text(' เลือก วันที่ เวลา สาขา '),
                            ),
                          )
                        : SizedBox(
                            child: Row(children: [
                              Expanded(
                                flex: 8,
                                child: SizedBox(
                                    child: isCheckRun
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.green[50],
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
                                                                  bottom: 24),
                                                          child: lPaymentDetail
                                                                  .isEmpty
                                                              ? const SizedBox(
                                                                  height: 40,
                                                                  child: Center(
                                                                    child: Text(
                                                                        'No Data'),
                                                                  ),
                                                                )
                                                              : SizedBox(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height /
                                                                      2,
                                                                  child: ListView
                                                                      .builder(
                                                                          itemCount: groupName
                                                                              .length,
                                                                          itemBuilder:
                                                                              (context, indexHeader) {
                                                                            String
                                                                                fullName =
                                                                                groupName.keys.elementAt(indexHeader);
                                                                            List<PaymentDetailModel>
                                                                                data =
                                                                                groupName.values.elementAt(indexHeader);

                                                                            return Column(
                                                                              children: [
                                                                                Card(
                                                                                    color: Colors.green[100],
                                                                                    child: Align(
                                                                                      alignment: Alignment.centerLeft,
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.all(8.0),
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
                                                                                                        setState(() {
                                                                                                          isSend = false;
                                                                                                        });
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
                                                                                                        setState(() {
                                                                                                          isSend = false;
                                                                                                        });
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
                                                                                                                setState(() {
                                                                                                                  isSend = false;
                                                                                                                });
                                                                                                              },
                                                                                                              callbackRemove: (ImageReId) {
                                                                                                                lPaymentImage.removeWhere((re) => re.tlpayment_detail_image_id == ImageReId);
                                                                                                                lPaymentImageRemoveId.add(ImageReId);

                                                                                                                setState(() {
                                                                                                                  isSend = false;
                                                                                                                });
                                                                                                              },
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
                                                                                                            setState(() {
                                                                                                              isSend = false;
                                                                                                            });
                                                                                                          },
                                                                                                          callbackRemove: (remarkReId) {
                                                                                                            lPaymentRemark.removeWhere((re) => re.tlpayment_d_remark_id == remarkReId);
                                                                                                            lPaymentRemarkRemoveId.add(remarkReId);
                                                                                                            setState(() {
                                                                                                              isSend = false;
                                                                                                            });
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
                                                                          }),
                                                                ),
                                                        ),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .green[200],
                                                              borderRadius: const BorderRadius
                                                                  .vertical(
                                                                  bottom: Radius
                                                                      .circular(
                                                                          16))),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 8.0,
                                                                    bottom: 8.0,
                                                                    right: 22),
                                                            child: Row(
                                                              children: [
                                                                const Expanded(
                                                                    child:
                                                                        SizedBox()),
                                                                const SizedBox(
                                                                  width: 150,
                                                                  child: Text(
                                                                    'Total Paid ::',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 150,
                                                                  child: Text(
                                                                    oCcy.format(
                                                                        dTotalPaid),
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 150,
                                                                  child: Text(
                                                                    'Total Actual ::',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 150,
                                                                  child: Text(
                                                                    oCcy.format(
                                                                        dTotalActual),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        color: oCcy.format(dTotalActual) !=
                                                                                oCcy.format(dTotalPaid)
                                                                            ? Colors.red
                                                                            : null),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 150,
                                                                  child: Text(
                                                                    'Total Balance ::',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 150,
                                                                  child: Text(
                                                                    oCcy.format(
                                                                        dTotalBalance),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        color: oCcy.format(dTotalBalance) !=
                                                                                '0.00'
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
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ElevatedButton(
                                                    style: isStatusScreen ==
                                                                'New' ||
                                                            isStatusScreen ==
                                                                'create' ||
                                                            isStatusScreen ==
                                                                'reject'
                                                        ? ElevatedButton
                                                            .styleFrom(
                                                                foregroundColor:
                                                                    Colors.blue[
                                                                        900],
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                side:
                                                                    BorderSide(
                                                                  width: 1.0,
                                                                  color: Colors
                                                                      .blue
                                                                      .shade900,
                                                                ))
                                                        : ElevatedButton
                                                            .styleFrom(
                                                            foregroundColor:
                                                                Colors.white,
                                                            backgroundColor:
                                                                Colors.grey,
                                                          ),
                                                    child: const Text(
                                                        ' Add Payment Type '),
                                                    onPressed: () {
                                                      if (isStatusScreen ==
                                                              'New' ||
                                                          isStatusScreen ==
                                                              'create' ||
                                                          isStatusScreen ==
                                                              'reject') {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return Dialog(
                                                                  shape: const RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(Radius.circular(
                                                                              16.0))),
                                                                  child:
                                                                      AddPaymentTypeScreen(
                                                                    paymentId:
                                                                        paymentId,
                                                                    site:
                                                                        siteToAddPaymentType,
                                                                    lPaymentDetailTypeIdNotShow:
                                                                        lPaymentDetailTypeId,
                                                                    callbackAddPD:
                                                                        (addType) {
                                                                      lPaymentDetail
                                                                          .add(
                                                                              addType);
                                                                      groupName =
                                                                          groupPaymentDeposit(
                                                                              lPaymentDetail);
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                    callbacklPaymentDetailTypeId:
                                                                        (lPaymentTypeNameCallBack) {
                                                                      lPaymentDetailTypeId =
                                                                          lPaymentTypeNameCallBack;
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                  ));
                                                            });
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                                              const Expanded(child: SizedBox()),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor: lPaymentDetail
                                                                    .isEmpty ||
                                                                isStatusScreen ==
                                                                    'waiting' ||
                                                                isStatusScreen ==
                                                                    'confirm'
                                                            ? Colors.grey
                                                            : null,
                                                      ),
                                                      child: const Text(
                                                          ' Save And Print '),
                                                      onPressed: () async {
                                                        if (lPaymentDetail
                                                                .isEmpty ||
                                                            isStatusScreen ==
                                                                'waiting' ||
                                                            isStatusScreen ==
                                                                'confirm') {
                                                        } else {
                                                          showDialog(
                                                              barrierDismissible:
                                                                  false,
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return const Center(
                                                                  child:
                                                                      SizedBox(
                                                                    height: 100,
                                                                    width: 100,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          CircularProgressIndicator(),
                                                                    ),
                                                                  ),
                                                                );
                                                              });
                                                          printNumber =
                                                              '${widget.lEmp.first.employee_id}_${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}_${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}_${DateTime.now().millisecond}';
                                                          if (isStatusScreen ==
                                                              'New') {
                                                            Future.delayed(
                                                                Duration(
                                                                    seconds: 1),
                                                                () async {
                                                              //! Payment
                                                              await createPayment();
                                                              //! PaymentDetail
                                                              await createPaymentDetail();
                                                              if (lPaymentImage
                                                                  .isEmpty) {
                                                              } else {
                                                                //! PaymentDetailImageDB
                                                                await createPaymentDetailImageDB();
                                                                //! PaymentDetailImageFolder
                                                                await createPaymentDetailImageFolder();
                                                              }
                                                              if (lPaymentRemark
                                                                  .isEmpty) {
                                                              } else {
                                                                //! PaymentDetailRemark
                                                                await createPaymentDetailRemark();
                                                              }

                                                              //! loadPayment
                                                              await loadPaymentMasterById(
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

                                                              Navigator.pop(
                                                                  context);
                                                              showDialog(
                                                                barrierDismissible:
                                                                    false,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return const Center(
                                                                    child: Card(
                                                                      elevation:
                                                                          0,
                                                                      color: Color.fromARGB(
                                                                          0,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                      child:
                                                                          Text(
                                                                        'Save Success..',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.green,
                                                                            fontSize: 24),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                              await Future.delayed(
                                                                  const Duration(
                                                                      milliseconds:
                                                                          300),
                                                                  () {
                                                                Navigator.pop(
                                                                    context);
                                                              });
                                                              setState(() {
                                                                isSend = true;
                                                              });
                                                              //!Print
                                                              final doc =
                                                                  pw.Document();
                                                              await _genPDFDailyByEmpForm(
                                                                  doc,
                                                                  lPaymentMaster,
                                                                  lPaymentDetail,
                                                                  widget.lEmp,
                                                                  lSite
                                                                      .where((ee) =>
                                                                          ee.site_id ==
                                                                          siteToAddPaymentType)
                                                                      .toList());
                                                              await Future.delayed(
                                                                  const Duration(
                                                                      milliseconds:
                                                                          100),
                                                                  () async {
                                                                await showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child: DailyByEmpForm(
                                                                            doc:
                                                                                doc,
                                                                            pdfFileName:
                                                                                printNumber),
                                                                      );
                                                                    });
                                                              });
                                                            });
                                                          } else if (isStatusScreen ==
                                                                  'create' ||
                                                              isStatusScreen ==
                                                                  'reject') {
                                                            Future.delayed(
                                                                const Duration(
                                                                    seconds: 1),
                                                                () async {
                                                              await updatePayment(
                                                                  paymentId);
                                                              for (var pd
                                                                  in lPaymentDetail) {
                                                                if (lPaymentDetailId
                                                                    .where((e) =>
                                                                        e ==
                                                                        pd.tlpayment_detail_id)
                                                                    .isNotEmpty) {
                                                                  await updatePaymentDetail(
                                                                      pd.tlpayment_detail_id);
                                                                } else {
                                                                  await createPaymentDetailByModel(
                                                                      pd);
                                                                }
                                                              }
                                                              for (var pdr
                                                                  in lPaymentRemark) {
                                                                if (lPaymentRemarkId
                                                                    .where((e) =>
                                                                        e ==
                                                                        pdr.tlpayment_d_remark_id)
                                                                    .isNotEmpty) {
                                                                  await updatePaymentDetailRemark(
                                                                      pdr.tlpayment_d_remark_id);
                                                                } else {
                                                                  await createPaymentDetailRemarkByModel(
                                                                      pdr);
                                                                }
                                                              }

                                                              for (var pdi
                                                                  in lPaymentImage) {
                                                                if (lPaymentImageDB
                                                                    .where((e) =>
                                                                        e.tlpayment_detail_image_id ==
                                                                        pdi.tlpayment_detail_image_id)
                                                                    .isNotEmpty) {
                                                                  await updatePaymentDetailImage(
                                                                      pdi.tlpayment_detail_image_id);
                                                                } else {
                                                                  await createPaymentDetailImageDBByModel(
                                                                      pdi);
                                                                  await createPaymentDetailImageFolderByModel(
                                                                      pdi);
                                                                }
                                                              }
                                                              await deletePaymentDetailRemark();
                                                              await deletePaymentDetailImage();

                                                              //! loadPayment
                                                              await loadPaymentMasterById(
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

                                                              Navigator.pop(
                                                                  context);
                                                              showDialog(
                                                                barrierDismissible:
                                                                    false,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return const Center(
                                                                    child: Card(
                                                                      elevation:
                                                                          0,
                                                                      color: Color.fromARGB(
                                                                          0,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                      child:
                                                                          Text(
                                                                        'Update Success..',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.green,
                                                                            fontSize: 24),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                              await Future.delayed(
                                                                  const Duration(
                                                                      milliseconds:
                                                                          300),
                                                                  () {
                                                                Navigator.pop(
                                                                    context);

                                                                setState(() {
                                                                  isSend = true;
                                                                });
                                                              });
                                                              //!Print
                                                              final doc =
                                                                  pw.Document();
                                                              await _genPDFDailyByEmpForm(
                                                                  doc,
                                                                  lPaymentMaster,
                                                                  lPaymentDetail,
                                                                  widget.lEmp,
                                                                  lSite
                                                                      .where((ee) =>
                                                                          ee.site_id ==
                                                                          siteToAddPaymentType)
                                                                      .toList());
                                                              await Future.delayed(
                                                                  const Duration(
                                                                      milliseconds:
                                                                          100),
                                                                  () async {
                                                                await showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child: DailyByEmpForm(
                                                                            doc:
                                                                                doc,
                                                                            pdfFileName:
                                                                                printNumber),
                                                                      );
                                                                    });
                                                              });
                                                            });
                                                          }
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Tooltip(
                                                      message: isSend
                                                          ? ''
                                                          : 'กรุณา Save ก่อนทำการเลือกผู้ตรวจสอบ',
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              isSend
                                                                  ? null
                                                                  : Colors.grey,
                                                        ),
                                                        child: const Text(
                                                            ' Send Approval '),
                                                        onPressed: () async {
                                                          if (isSend) {
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
                                                                      child:
                                                                          SizedBox(
                                                                        height:
                                                                            300,
                                                                        width:
                                                                            600,
                                                                        child:
                                                                            SelectApproverPopup(
                                                                          paymentId:
                                                                              paymentId,
                                                                          empid: widget
                                                                              .lEmp
                                                                              .first
                                                                              .employee_id,
                                                                          siteId: widget
                                                                              .lEmp
                                                                              .first
                                                                              .site_id,
                                                                          callbackUpdate:
                                                                              () async {
                                                                            // await updatePayment(
                                                                            //     paymentId);
                                                                            await updatePaymentStatus(paymentId);
                                                                          },
                                                                          callbackClear:
                                                                              () {
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

                                                                            dTotalActual =
                                                                                0.00;
                                                                            dTotalPaid =
                                                                                0.00;
                                                                            dTotalBalance =
                                                                                0.00;
                                                                            paymentControllers.clear();

                                                                            isSend =
                                                                                false;
                                                                            isStatusScreen =
                                                                                'New';

                                                                            setState(() {});
                                                                          },
                                                                        ),
                                                                      ),
                                                                    );
                                                                  });
                                                            }
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )),
                              ),
                            ]),
                          ),
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
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 60,
                              child: Text('เริ่ม : ', textAlign: TextAlign.end),
                            ),
                            SizedBox(
                              width: 60,
                              child: _buildDropdownTime(
                                  'sh', startTimeHourDDValue, lHour),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Text(':'),
                            ),
                            SizedBox(
                              width: 60,
                              child: _buildDropdownTime(
                                  'sm', startTimeMinuteDDValue, lMinute),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 60,
                              child:
                                  Text('สิ้นสุด : ', textAlign: TextAlign.end),
                            ),
                            SizedBox(
                              width: 60,
                              child: _buildDropdownTime(
                                  'eh', endTimeHourDDValue, lHour),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Text(':'),
                            ),
                            SizedBox(
                              width: 60,
                              child: _buildDropdownTime(
                                  'em', endTimeMinuteDDValue, lMinute),
                            )
                          ],
                        ),
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
                            setState(() {
                              isHover = value;
                            });
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
                              paymentId =
                                  '${TlConstant.runID()}${TlConstant.random()}';
                              startTime =
                                  '$startTimeHourDDValue:$startTimeMinuteDDValue:00';
                              endTime =
                                  '$endTimeHourDDValue:$endTimeMinuteDDValue:59';
                              dateRec = selectedDate;

                              isSend = false;
                              lPaymentRemarkRemoveId = [];
                              lPaymentImageRemoveId = [];
                              paymentControllers.clear();
                              print('Event Btn Run');
                              print(widget.lEmp.first.employee_id);
                              print(selectedDate);
                              print(startTime);
                              print(endTime);
                              print(siteDDValue);

                              await loadPaymentByDate(
                                  widget.lEmp.first.employee_id,
                                  siteDDValue,
                                  selectedDate);

                              if (lPaymentChoice.isNotEmpty) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16.0))),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            height: 400,
                                            width: 500,
                                            child: Column(
                                              children: [
                                                const Center(
                                                    child: SizedBox(
                                                        height: 42,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                'บันทึก การปิดผลัด',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ],
                                                          ),
                                                        ))),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.grey[400],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: ListView.builder(
                                                          itemCount:
                                                              lPaymentChoice
                                                                  .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return Card(
                                                              child: InkWell(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4),
                                                                onTap:
                                                                    () async {
                                                                  paymentId = lPaymentChoice[
                                                                          index]
                                                                      .tlpayment_id;
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
                                                                  Navigator.pop(
                                                                      context);
                                                                  runProcess =
                                                                      'loadData';

                                                                  if (isStatusScreen ==
                                                                          'create' ||
                                                                      isStatusScreen ==
                                                                          'reject') {
                                                                    isSend =
                                                                        true;
                                                                  }

                                                                  setState(
                                                                      () {});
                                                                },
                                                                onHover:
                                                                    (select) {
                                                                  // setState;
                                                                },
                                                                hoverColor:
                                                                    Colors.green[
                                                                        50],
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                          style:
                                                                              TextStyle(fontSize: 16),
                                                                          'สาขา : ${lPaymentChoice[index].tlpayment_rec_site} วันที่ : ${lPaymentChoice[index].tlpayment_rec_date} [ ${lPaymentChoice[index].tlpayment_rec_time_from} - ${lPaymentChoice[index].tlpayment_rec_time_to} ]'),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            vertical:
                                                                                4.0),
                                                                        child: Text(
                                                                            style:
                                                                                const TextStyle(fontSize: 14),
                                                                            'Paid : ${lPaymentChoice[index].tlpayment_imed_total}, Actual : ${lPaymentChoice[index].tlpayment_actual_total}, Balance : ${lPaymentChoice[index].tlpayment_diff_abs}'),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            vertical:
                                                                                4.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              lPaymentChoice[index].tlpayment_status,
                                                                              style: const TextStyle(color: Colors.blue),
                                                                            ),
                                                                            Text(
                                                                                style: const TextStyle(fontSize: 14),
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
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Tooltip(
                                                    message: 'New Payment',
                                                    child: IconButton(
                                                      iconSize: 32,
                                                      color: Colors.green[900],
                                                      icon: const Icon(
                                                        Icons.note_add_rounded,
                                                      ),
                                                      onPressed: () async {
                                                        if (isNew == false) {
                                                          setState(() {
                                                            lPaymentImage = [];
                                                            lPaymentRemark = [];
                                                            runProcess =
                                                                'loadData';
                                                            isCheckRun = true;
                                                            isNew = true;
                                                            isSend = false;
                                                            Navigator.pop(
                                                                context);
                                                          });

                                                          await loadPaymentImed(
                                                              paymentId,
                                                              widget.lEmp.first
                                                                  .employee_id,
                                                              siteDDValue,
                                                              selectedDate,
                                                              startTime,
                                                              endTime);

                                                          setState(() {
                                                            isNew = false;
                                                            isCheckRun = false;
                                                            isStatusScreen =
                                                                'New';
                                                          });
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ));
                                    });
                              } else {
                                if (isNew == false) {
                                  lPaymentImage = [];
                                  lPaymentRemark = [];
                                  setState(() {
                                    ///**
                                    runProcess = 'loadData';
                                    isCheckRun = true;
                                    isNew = true;
                                  });
                                  await loadPaymentImed(
                                      paymentId,
                                      widget.lEmp.first.employee_id,
                                      siteDDValue,
                                      selectedDate,
                                      startTime,
                                      endTime);
                                  setState(() {
                                    isNew = false;
                                    isCheckRun = false;
                                    isStatusScreen = 'New';
                                  });
                                }
                              }
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

  _buildDropdownTime(String type, String DDValue, List<String> lTime) {
    return StatefulBuilder(
      builder: (context, setState) {
        return DropdownButton<String>(
          isExpanded: true,
          value: DDValue,
          icon:
              const Icon(Icons.arrow_drop_down_rounded, color: Colors.blueGrey),
          elevation: 16,
          style: const TextStyle(color: Colors.blueGrey),
          underline: Container(
            height: 2,
            color: Colors.blueGrey,
          ),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              DDValue = value!;
              if (type == 'sh') {
                startTimeHourDDValue = value;
              } else if (type == 'sm') {
                startTimeMinuteDDValue = value;
              } else if (type == 'eh') {
                endTimeHourDDValue = value;
              } else if (type == 'em') {
                endTimeMinuteDDValue = value;
              }
              print('DDValue :: $DDValue');
            });
          },
          items: lTime.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(value),
              ),
            );
          }).toList(),
        );
      },
    );
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

  Future loadPaymentImed(
      String paymentId, emp_id, site_id, date, startTime, endTime) async {
    lReceiptImed = [];
    lPaymentDetail = [];

    lPaymentDetailTypeId = [];
    dTotalPaid = 0.0;
    dTotalActual = 0.0;
    dTotalBalance = 0.0;
    dTotalIncome = 0.0;
    siteToAddPaymentType = site_id;
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "emp_id": emp_id,
      "site_id": site_id,
      "date_": date,
      "startTime": startTime,
      "endTime": endTime
    });
    String api = '${TlConstant.syncApi}receipt.php?id=imedRec';

    await Dio().post(api, data: formData).then((value) {
      if (value.data == null) {
        print('Receipt Imed Null !');
      } else {
        for (var receipt in value.data) {
          ReceiptModel newRec = ReceiptModel.fromMap(receipt);
          lReceiptImed.add(newRec);
        }
        for (var i = 0; i < lReceiptImed.length; i++) {
          var formatId = i.toString().padLeft(4, '0');
          PaymentDetailModel newPD = PaymentDetailModel(
              tlpayment_detail_id:
                  '${TlConstant.runID()}${TlConstant.random()}$formatId',
              tlpayment_id: paymentId,
              tlpayment_type_id: lReceiptImed[i].paid_method_func.toString(),
              tlpayment_type: lReceiptImed[i].paid_method_th.toString(),
              tlpayment_type_detail:
                  lReceiptImed[i].paid_method_sub_th.toString(),
              tlpayment_type_detail_id: lReceiptImed[i].c_num.toString(),
              opd_paid: double.parse(lReceiptImed[i].opd_paid.toString())
                  .toStringAsFixed(2),
              ipd_paid: double.parse(lReceiptImed[i].ipd_paid.toString())
                  .toStringAsFixed(2),
              paid: double.parse(lReceiptImed[i].paid.toString())
                  .toStringAsFixed(2),
              paid_go: double.parse(lReceiptImed[i].paid_go.toString())
                  .toStringAsFixed(2),
              prpdsp: lReceiptImed[i].grpdsp.toString(),
              tlpayment_detail_site_id: siteToAddPaymentType,
              tlpayment_detail_actual_paid:
                  double.parse(lReceiptImed[i].paid_go.toString())
                      .toStringAsFixed(2),
              tlpayment_detail_diff_paid: '0',
              tlpayment_detail_comment: '');

          lPaymentDetail.add(newPD);
          // if (newPD.tlpayment_type_id == '1') {
          //   lPaymentDetailTypeId.add('001');
          // } else {
          lPaymentDetailId.add(newPD.tlpayment_detail_id);
          lPaymentDetailTypeId.add(newPD.tlpayment_type_detail_id);
          // }

          dTotalPaid += double.parse(newPD.paid_go);
          dTotalActual += double.parse(newPD.paid_go);
          dTotalBalance += double.parse(newPD.tlpayment_detail_diff_paid);
          dTotalIncome += double.parse(newPD.paid);
        }
        groupName = groupPaymentDeposit(lPaymentDetail);
      }
    });
  }

  Future loadPaymentByDate(
      String employee_id, String siteDDValue, String selectedDate) async {
    lPaymentChoice = [];
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "emp_id": employee_id,
      "site_id": siteDDValue,
      "date_": selectedDate,
    });
    String api = '${TlConstant.syncApi}tlPayment.php?id=loadByDate';

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

  Future loadPaymentMasterById(String paymentId) async {
    dTotalPaid = 0.0;
    dTotalActual = 0.0;
    dTotalBalance = 0.0;
    dTotalIncome = 0.0;
    siteToAddPaymentType = '';
    lPaymentMaster = [];

    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "id": paymentId,
    });
    String api = '${TlConstant.syncApi}tlPayment.php?id=1';

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

    siteToAddPaymentType = lPaymentMaster.first.tlpayment_rec_site;
    dTotalPaid = double.parse(lPaymentMaster.first.tlpayment_imed_total);
    dTotalActual = double.parse(lPaymentMaster.first.tlpayment_actual_total);
    dTotalBalance = double.parse(lPaymentMaster.first.tlpayment_diff_abs);
    dTotalIncome =
        double.parse(lPaymentMaster.first.tlpayment_imed_total_income);
    paymentControllers.text = lPaymentMaster.first.tlpayment_comment;

    printNumber = lPaymentMaster.first.tlpayment_print_number;
  }

  Future loadPaymentMaster(String paymentId) async {
    dTotalPaid = 0.0;
    dTotalActual = 0.0;
    dTotalBalance = 0.0;
    dTotalIncome = 0.0;
    siteToAddPaymentType = '';
    lPaymentMaster =
        lPaymentChoice.where((e) => e.tlpayment_id == paymentId).toList();

    siteToAddPaymentType = lPaymentMaster.first.tlpayment_rec_site;
    dTotalPaid = double.parse(lPaymentMaster.first.tlpayment_imed_total);
    dTotalActual = double.parse(lPaymentMaster.first.tlpayment_actual_total);
    dTotalBalance = double.parse(lPaymentMaster.first.tlpayment_diff_abs);
    dTotalIncome =
        double.parse(lPaymentMaster.first.tlpayment_imed_total_income);
    paymentControllers.text = lPaymentMaster.first.tlpayment_comment;

    printNumber = lPaymentMaster.first.tlpayment_print_number;
  }

  Future loadPaymentDetail(String paymentId) async {
    setState(() {
      lPaymentDetail = [];
      lPaymentDetailTypeId = [];
      groupName = '';
    });

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
        groupName = groupPaymentDeposit(lPaymentDetail);
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
      "printnumber": printNumber,
    });
    String api = '${TlConstant.syncApi}tlPayment.php?id=update';
    await Dio().post(api, data: formData);
  }

  Future updatePaymentStatus(String id) async {
    String status = 'waiting';
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "id": id,
      "status": status,
    });
    String api = '${TlConstant.syncApi}tlPayment.php?id=send';
    await Dio().post(api, data: formData);
  }

  Future updatePaymentDetail(String id) async {
    String act = lPaymentDetail
        .where((e) => e.tlpayment_detail_id == id)
        .first
        .tlpayment_detail_actual_paid;
    String balance = lPaymentDetail
        .where((e) => e.tlpayment_detail_id == id)
        .first
        .tlpayment_detail_diff_paid;
    String comment = lPaymentDetail
        .where((e) => e.tlpayment_detail_id == id)
        .first
        .tlpayment_detail_comment;

    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "id": id,
      "act": act,
      "balance": balance,
      "comment": comment,
    });
    String api = '${TlConstant.syncApi}tlPaymentDetail.php?id=update';
    await Dio().post(api, data: formData);
  }

  Future updatePaymentDetailImage(String id) async {
    String description = lPaymentImage
        .where((e) => e.tlpayment_detail_image_id == id)
        .first
        .tlpayment_image_description;
    FormData formData = FormData.fromMap(
        {"token": TlConstant.token, "id": id, "description": description});
    String api = '${TlConstant.syncApi}tlPaymentDetailImage.php?id=update';
    await Dio().post(api, data: formData);
  }

  Future updatePaymentDetailRemark(String id) async {
    String bank = lPaymentRemark
        .where((e) => e.tlpayment_d_remark_id == id)
        .first
        .tlpayment_d_remark_bank;
    String date = lPaymentRemark
        .where((e) => e.tlpayment_d_remark_id == id)
        .first
        .tlpayment_d_remark_date;
    String time = lPaymentRemark
        .where((e) => e.tlpayment_d_remark_id == id)
        .first
        .tlpayment_d_remark_time;
    String amount = lPaymentRemark
        .where((e) => e.tlpayment_d_remark_id == id)
        .first
        .tlpayment_d_remark_amount;
    String comment = lPaymentRemark
        .where((e) => e.tlpayment_d_remark_id == id)
        .first
        .tlpayment_d_remark_comment;

    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "id": id,
      "bank": bank,
      "date": date,
      "time": time,
      "amount": amount,
      "comment": comment,
    });
    String api = '${TlConstant.syncApi}tlPaymentDetailRemark.php?id=update';
    await Dio().post(api, data: formData);
  }

  //! ------------------Delete------------------
  Future deletePaymentDetailImage() async {
    if (lPaymentImageRemoveId.isNotEmpty) {
      for (var id in lPaymentImageRemoveId) {
        FormData formData =
            FormData.fromMap({"token": TlConstant.token, "id": id});
        String api = '${TlConstant.syncApi}tlPaymentDetailImage.php?id=del';
        await Dio().post(api, data: formData);
      }
    }
  }

  Future deletePaymentDetailRemark() async {
    if (lPaymentRemarkRemoveId.isNotEmpty) {
      for (var id in lPaymentRemarkRemoveId) {
        FormData formData =
            FormData.fromMap({"token": TlConstant.token, "id": id});
        String api = '${TlConstant.syncApi}tlPaymentDetailRemark.php?id=del';
        await Dio().post(api, data: formData);
      }
    }
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
      "tlpayment_comment": paymentControllers.text,
      "tlpayment_imed_total_income": dTotalIncome.toStringAsFixed(2),
      "tlpayment_print_number": printNumber,
      //"tlpayment_comment": paymentControllers.text
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
    double dTotalIncome = 0.00;
    lPaymentDetail.sort((a, b) => int.parse(a.tlpayment_type_id)
        .compareTo(int.parse(b.tlpayment_type_id)));

    return groupBy(lPaymentDetail, (gKey) {
      dTotalIncome = 0.00;
      lPaymentDetail
          .where((element) => element.tlpayment_type == gKey.tlpayment_type)
          .forEach((e) {
        dTotalIncome += double.parse(e.paid);
      });

      var nameAndDate =
          '${gKey.tlpayment_type} (${oCcy.format(dTotalIncome)}) ';
      return nameAndDate;
    });
    //=> gKey.emp_fullname);
  }

  Future<void> _genPDFDailyByEmpForm(
    pw.Document doc,
    List<PaymentModel> pLPayment,
    List<PaymentDetailModel> pLPaymentDetail,
    List<EmployeeModel> pLEmployee,
    List<SiteModel> pLSite,
  ) async {
    var pGroupName = groupPaymentDeposit(pLPaymentDetail);

    Uint8List imagePNG =
        (await rootBundle.load('images/logothonglor_circle.png'))
            .buffer
            .asUint8List();
    var siteName = pLSite.first.site_name;
//Prompt-Regular.ttf
    var arabicFont = //Prompt-Medium.ttf
        pw.Font.ttf(await rootBundle.load("fonts/RSU-Regular.ttf"));

    var fontBold = pw.Font.ttf(await rootBundle.load("fonts/RSU-Bold.ttf"));

    var imagelogo = pw.MemoryImage(imagePNG);

    var countrowSitepdf = pLPaymentDetail.length;
    String yyyynow = DateTime.now().year.toString();
    String MMnow = DateTime.now().month.toString();
    String ddnow = DateTime.now().day.toString();

    int iPdfIndex = 0;

    doc.addPage(
      pw.Page(
        orientation: pw.PageOrientation.natural,
        margin: const pw.EdgeInsets.all(8.0),
        theme: pw.ThemeData.withFont(
          base: arabicFont,
        ),
        pageFormat: PdfPageFormat.a4.portrait,
        build: (pw.Context context) {
          return pw.Container(
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    // Harder
                    pw.Container(
                        height: 100,
                        child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.center,
                            children: [
                              pw.SizedBox(height: 8),
                              pw.Text('บริษัท โรงพยาบาลสัตว์ทองหล่อ จำกัด',
                                  style: pw.TextStyle(
                                      font: fontBold, fontSize: 14)),
                              pw.Text('Thonglor Pet Hospital Co.,Ltd.',
                                  style: pw.TextStyle(
                                      font: fontBold, fontSize: 14)),
                              pw.Text(
                                  'รายงานปิดผลัด จำแนกตามประเภทเงิน (รวม VAT)',
                                  style: pw.TextStyle(fontSize: 10)),
                              pw.SizedBox(height: 8),
                              pw.Text(
                                  'ปิดผลัด ${siteName} ผลัดวันที่ ${pLPayment.first.tlpayment_rec_date}  โดย ${pLEmployee.first.emp_fullname}',
                                  style: pw.TextStyle(fontSize: 10)),
                            ])),

                    pw.SizedBox(height: 8),
                    //body
                    pw.Expanded(
                      flex: 8,
                      child: pw.Container(
                          //color: PdfColors.green100,
                          child: pw.Column(children: [
                        pw.Container(
                          decoration: const pw.BoxDecoration(
                              color: PdfColors.green900,
                              borderRadius: pw.BorderRadius.only(
                                  topLeft: pw.Radius.circular(4),
                                  topRight: pw.Radius.circular(4))),
                          child: pw.Padding(
                            padding: const pw.EdgeInsets.symmetric(
                                horizontal: 4, vertical: 6),
                            child: pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceAround,
                                children: [
                                  pw.Expanded(
                                    child: pw.SizedBox(
                                        child: pw.Text('สรุปรายงานปิดผลัด',
                                            style: pw.TextStyle(
                                                font: fontBold,
                                                fontSize: 10,
                                                color: PdfColors.white))),
                                  ),
                                  pw.SizedBox(
                                    width: 100,
                                    child: pw.Center(
                                        child: pw.Text('สรุปยอดรายได้',
                                            style: pw.TextStyle(
                                                font: fontBold,
                                                fontSize: 10,
                                                color: PdfColors.white))),
                                  ),
                                  pw.SizedBox(
                                    width: 100,
                                    child: pw.Center(
                                        child: pw.Text('สรุปยอดส่งเงิน',
                                            style: pw.TextStyle(
                                                font: fontBold,
                                                fontSize: 10,
                                                color: PdfColors.white))),
                                  ),
                                  pw.SizedBox(
                                    width: 100,
                                    child: pw.Center(
                                        child: pw.Text('ยอดนำส่งเงินจริง',
                                            style: pw.TextStyle(
                                                font: fontBold,
                                                fontSize: 10,
                                                color: PdfColors.white))),
                                  ),
                                  pw.Container(
                                    width: 100,
                                    child: pw.Center(
                                      child: pw.Text('หมายเหตุ',
                                          style: pw.TextStyle(
                                              font: fontBold,
                                              fontSize: 10,
                                              color: PdfColors.white)),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                        pw.SizedBox(
                          height: 2,
                        ),
                        pw.Expanded(
                          child: pw.SizedBox(
                            child: pw.ListView.builder(
                              itemCount: pGroupName.length,
                              itemBuilder: (context, indexHeader) {
                                iPdfIndex += 1;

                                String pFullName =
                                    pGroupName.keys.elementAt(indexHeader);
                                List<PaymentDetailModel> data =
                                    pGroupName.values.elementAt(indexHeader);

                                return pw.Column(
                                  children: [
                                    pw.Container(
                                        color: PdfColors.green100,
                                        child: pw.Align(
                                          alignment: pw.Alignment.centerLeft,
                                          child: pw.Padding(
                                            padding:
                                                const pw.EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 4),
                                            child: pw.Text(
                                              pFullName,
                                              style: pw.TextStyle(
                                                  font: fontBold, fontSize: 8),
                                            ),
                                          ),
                                        )),
                                    pw.ListView.builder(
                                        // shrinkWrap: true,
                                        // physics: ClampingScrollPhysics(),
                                        itemCount: data.length,
                                        itemBuilder:
                                            (context, int indexDetail) {
                                          iPdfIndex += 1;
                                          PaymentDetailModel pPaymentDetail =
                                              data[indexDetail];

                                          //mTextController.text = mPaymentDetail.tlpayment_detail_actual_paid;
                                          // Return a widget representing the item
                                          return pw.Row(
                                            mainAxisAlignment: pw
                                                .MainAxisAlignment.spaceAround,
                                            children: [
                                              pw.SizedBox(
                                                width: 20,
                                              ),
                                              pw.Expanded(
                                                child: pw.SizedBox(
                                                  child: pw.Align(
                                                    alignment:
                                                        pw.Alignment.centerLeft,
                                                    child: pw.Text(
                                                      '${pPaymentDetail.tlpayment_type_detail}',
                                                      style: pw.TextStyle(
                                                          fontSize: 8),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              pw.SizedBox(
                                                width: 100,
                                                child: pw.Align(
                                                  alignment:
                                                      pw.Alignment.centerRight,
                                                  child: pw.Padding(
                                                    padding: const pw
                                                        .EdgeInsets.only(
                                                        right: 20.0),
                                                    child: pw.Text(
                                                      oCcy.format(double.parse(
                                                          pPaymentDetail.paid)),
                                                      style: pw.TextStyle(
                                                          fontSize: 8),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              pw.SizedBox(
                                                width: 100,
                                                child: pw.Align(
                                                  alignment:
                                                      pw.Alignment.centerRight,
                                                  child: pw.Padding(
                                                    padding: const pw
                                                        .EdgeInsets.only(
                                                        right: 20.0),
                                                    child: pw.Text(
                                                      oCcy.format(double.parse(
                                                          pPaymentDetail
                                                              .paid_go)),
                                                      style: pw.TextStyle(
                                                          fontSize: 8),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              pw.SizedBox(
                                                  width: 100,
                                                  child: pw.Align(
                                                    alignment: pw
                                                        .Alignment.centerRight,
                                                    child: pw.Padding(
                                                      padding: const pw
                                                          .EdgeInsets.only(
                                                          right: 20.0),
                                                      child: pw.Text(
                                                        oCcy.format(double.parse(
                                                            pPaymentDetail
                                                                .tlpayment_detail_actual_paid)),
                                                        style:
                                                            const pw.TextStyle(
                                                                fontSize: 8),
                                                      ),
                                                    ),
                                                  )),
                                              pw.SizedBox(
                                                width: 100,
                                                child: pw.Padding(
                                                  padding:
                                                      const pw.EdgeInsets.only(
                                                          left: 8.0),
                                                  child: pw.Text(
                                                    pPaymentDetail
                                                        .tlpayment_detail_comment,
                                                    style: pw.TextStyle(
                                                        fontSize: 8),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ])),
                    ),
                    pw.Container(
                      decoration: pw.BoxDecoration(
                          color: PdfColors.green300,
                          borderRadius:
                              pw.BorderRadius.all(pw.Radius.circular(8))),
                      child: pw.Row(children: [
                        pw.Expanded(
                            child: pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.SizedBox(
                              child: pw.Text('  สรุปยอด',
                                  style: pw.TextStyle(
                                    font: fontBold,
                                    fontSize: 14,
                                  ))),
                        )),
                        pw.SizedBox(
                            width: 100,
                            child: pw.Align(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Padding(
                                padding: const pw.EdgeInsets.only(right: 20.0),
                                child: pw.Text(
                                  oCcy.format(double.parse(pLPayment
                                      .first.tlpayment_imed_total_income)),
                                  style: pw.TextStyle(
                                      font: fontBold, fontSize: 12),
                                ),
                              ),
                            )),
                        pw.SizedBox(
                            width: 100,
                            child: pw.Align(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Padding(
                                padding: const pw.EdgeInsets.only(right: 20.0),
                                child: pw.Text(
                                  oCcy.format(double.parse(
                                      pLPayment.first.tlpayment_imed_total)),
                                  style: pw.TextStyle(
                                      font: fontBold, fontSize: 12),
                                ),
                              ),
                            )),
                        pw.SizedBox(
                            width: 100,
                            child: pw.Align(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Padding(
                                padding: const pw.EdgeInsets.only(right: 20.0),
                                child: pw.Text(
                                  oCcy.format(double.parse(
                                    pLPayment.first.tlpayment_actual_total,
                                  )),
                                  style: pw.TextStyle(
                                      font: fontBold, fontSize: 12),
                                ),
                              ),
                            )),
                        pw.SizedBox(
                            width: 100,
                            child: pw.Align(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Padding(
                                padding: const pw.EdgeInsets.only(right: 20.0),
                                child: pw.Text(
                                  'ขาด/เกิน\n${oCcy.format(double.parse(pLPayment.first.tlpayment_diff_abs))}',
                                  style: pw.TextStyle(
                                      font: fontBold, fontSize: 12),
                                ),
                              ),
                            )),
                      ]),
                    ),

                    pw.SizedBox(height: 4),
                    pw.Row(children: [
                      pw.SizedBox(
                          width: 60,
                          child: pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(' หมายเหตุ : ',
                                style: pw.TextStyle(
                                  font: fontBold,
                                  fontSize: 10,
                                )),
                          )),
                      pw.Expanded(
                        child: pw.Container(
                          alignment: pw.Alignment.centerLeft,
                          color: PdfColors.grey200,
                          height: 20,
                          child:
                              pw.Text('   ${pLPayment.first.tlpayment_comment}',
                                  style: const pw.TextStyle(
                                    fontSize: 10,
                                  )),
                        ),
                      ),
                    ]),

                    pw.SizedBox(height: 4),

                    //Footer
                    pw.Expanded(
                      flex: 1,
                      child: pw.Container(
                        height: 100,
                        color: PdfColors.grey300,
                        child: pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                            children: [
                              pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.end,
                                children: [
                                  pw.Text('_________________________________'),
                                  pw.SizedBox(
                                    height: 20,
                                    child: pw.Text(
                                        '( ${pLEmployee.first.emp_fullname} )'),
                                  ),
                                  pw.Text('( ผู้นำส่งเงิน )'),
                                ],
                              ),
                              pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.end,
                                children: [
                                  pw.Text('_________________________________'),
                                  pw.SizedBox(height: 20),
                                  pw.Text('( ผู้ตรวจสอบ )'),
                                ],
                              )
                            ]),
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Container(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                            'No. ${pLPayment.first.tlpayment_print_number}',
                            style: const pw.TextStyle(fontSize: 8))),
                    pw.SizedBox(height: 8),
                  ]),
            ),
          );
        },
      ),
    );
  }
}

class DailyByEmpForm extends StatelessWidget {
  final pw.Document doc;
  String pdfFileName;

  DailyByEmpForm({Key? key, required this.doc, required this.pdfFileName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(' Preview Document ')),
      body: Container(
        child: Center(
          child: PdfPreview(
            build: (format) => doc.save(),
            allowSharing: true,
            allowPrinting: true,
            initialPageFormat: PdfPageFormat.a4,
            pdfFileName: '${pdfFileName}.pdf',
          ),
        ),
      ),
    );
  }
}
