import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:thonglor_e_smart_cashier_web/models/financialDepositAndDetail_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/financialDetail_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/financialMenu_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/financialPaymentAndDetail_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/financialGroup_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/financialType_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/financial_model.dart';
import 'package:thonglor_e_smart_cashier_web/screens/add_payment_type_financial_screen.dart';
import 'package:thonglor_e_smart_cashier_web/screens/deposit_image_screen.dart';
import 'package:thonglor_e_smart_cashier_web/screens/payment_image_screen.dart';
import 'package:thonglor_e_smart_cashier_web/util/constant.dart';
import 'package:collection/collection.dart';

import '../models/choicePayment_model.dart';
import '../models/depositImageTemp_model.dart';
import '../models/depositImage_model.dart';
import '../models/employee_model.dart';
import '../models/financialTypeAndCom_model.dart';
import '../models/paymentDetailImageTemp_model.dart';
import '../models/paymentDetailImage_model.dart';
import '../models/paymentDetailRemark_model.dart';
import '../models/payment_empFullName_model.dart';
import '../models/receiptReview_model.dart';
import '../models/site_model.dart';
import '../widgets/remarkPopup.dart';
import '../widgets/textFormFieldActualFin.dart';

class CheckFinancialScreen extends StatefulWidget {
  List<EmployeeModel> lEmp;

  Function callbackUpdate;
  CheckFinancialScreen(
      {required this.lEmp, required this.callbackUpdate, super.key});

  @override
  State<CheckFinancialScreen> createState() => _CheckFinancialScreenState();
}

class _CheckFinancialScreenState extends State<CheckFinancialScreen> {
  String selectRecDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  List<SiteModel> lSite = [];
  List<String> lSiteId = [];
  String siteDDValue = 'R9';
  String recSite = '';

  List<EmployeeModel> lEmployeeProfile = [];
  List<ReceiptReviewModel> lRecReview = [];

  List<PaymentEmpFullNameModel> lPaymentMaster = [];
  List<FinancialPaymentAndDetailModel> lFinPaymentAndDetail = [];
  List<FinancialDepositAndDetailModel> lFinDepositAndDetail = [];

  List<FinancialModel> lFin = [];
  String financialId = '';
  String financialStatus = '';

  List<FinancialMenuModel> lFinLeftMenu = [];
  String finLeftMenuRecBy = 'ALL';
  String finLeftMenuId = '';
  String finLeftMenuStatus = '';

  List<FinancialTypeAndComModel> lFinTypeAndCom = [];
  List<FinancialTypeModel> lFinType = [];
  List<FinancialDetailModel> lFinDetail = [];
  var groupFinTypeId;
  List<FinancialGroupModel> lFinGroup = [];

  List<PaymentDetailImageTempModel> lPaymentImage = [];
  List<PaymentDetailImageModel> lPaymentImageDB = [];
  List<PaymentDetailRemarkModel> lPaymentRemark = [];

  TextEditingController finDetailCommentController = TextEditingController();

  TextEditingController finCommentController = TextEditingController();

  bool isLoadFinancialGroup = false;
  bool isLoadFinancialDetail = false;

  List<DepositImageTempModel> lDepositImage = [];
  List<DepositImageModel> lDepositImageDB = [];

  bool isHoverBtnLoad = false;

  bool isCheckBtnLoadData = false;

  bool isBtnUpdateHover = false;

  bool isBtnAddPaymentHover = false;

  bool isBtnFinConfirmHover = false;

  bool isBtnFinReviewHover = false;

  bool isFinMenuStatusSwitch = false;

  bool isCheckALLApprove = true;
  //String finLeftMenuRecByxx = 'ALL';

  String recDate = '';

  String runProcess = 'Start';

  String isStatusScreen = 'New';

  final oCcy = NumberFormat(
    "#,##0.00",
  );

  double dTotalPaidGo = 0.0;
  double dTotalRecActual = 0.0;
  double dTotalDiffRec = 0.0;
  double dTotalFinDetailActual = 0.0;
  double dTotalDiffFinDetail = 0.0;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState

    Future.delayed(Duration(microseconds: 10000), () async {
      await loadFinTypeAndCom();
      await loadFinType();

      await loadSite();
      lSite.forEach((element) {
        lSiteId.add(element.site_id);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(children: [
        SizedBox(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              const SizedBox(
                child: Text('วันที่ปิดผลัด :'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  width: 100,
                  child: InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.0))),
                              child: SizedBox(
                                height: 300,
                                width: 300,
                                child: Center(
                                  child: SfDateRangePicker(
                                    onSelectionChanged: _onSelectionRec,
                                    selectionMode:
                                        DateRangePickerSelectionMode.single,
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    onHover: (select) {},
                    child: Text(
                      selectRecDate,
                      style: TextStyle(fontSize: 16, color: Colors.blue[900]),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                child: Text('สาขา :'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(width: 120, child: _buildDropdownSite()),
              ),
              const SizedBox(
                width: 32,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ElevatedButton(
                  onHover: (value) {
                    setState(() => isHoverBtnLoad = value);
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: isCheckBtnLoadData
                          ? null
                          : isHoverBtnLoad
                              ? Colors.green[900]
                              : Colors.green,
                      backgroundColor: isCheckBtnLoadData
                          ? Colors.grey[600]
                          : isHoverBtnLoad
                              ? Colors.green[100]
                              : Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  child: SizedBox(
                    width: 100,
                    child: isCheckBtnLoadData
                        ? const Center(child: Text(' Loading... '))
                        : const Center(child: Text(' Load ')),
                  ),
                  onPressed: () async {
                    if (isCheckBtnLoadData == false) {
                      finLeftMenuRecBy = 'ALL';
                      recDate = selectRecDate;
                      recSite = siteDDValue;

                      dTotalPaidGo = 0.0;
                      dTotalRecActual = 0.0;
                      dTotalDiffRec = 0.0;
                      dTotalFinDetailActual = 0.0;
                      lFin = [];
                      lFinLeftMenu = [];
                      lFinDetail = [];
                      lFinGroup = [];
                      finCommentController.clear();
                      setState(() {
                        runProcess = 'LoadData';
                        isCheckBtnLoadData = true;
                      });
                      //  ✔
                      // ❌

                      await loadFin(recSite, recDate);
                      await loadDepositAndDetail(recSite, recDate);
                      await loadPaymentMasterBuildImage(recSite, recDate);
                      await loadPaymentDetailAll(recSite, recDate);
                      await loadDepositImageDB();
                      await loadPaymentDetailImageAll();
                      await loadPaymentDetailRemarkAll();

                      print(lFin);
                      if (lFin.isNotEmpty) {
                        //1 มี fin ✔ finMenu ✔ finDetail ✔  finGroup ✔

                        financialStatus = lFin.first.tlfinancial_status;
                        finCommentController.text =
                            lFin.first.tlfinancial_comment;
                        financialId = lFin.first.tlfinancial_id;
                        finLeftMenuStatus = 'confirm';

                        dTotalPaidGo =
                            double.parse(lFin.first.tlfin_payment_paid_go);
                        dTotalRecActual =
                            double.parse(lFin.first.tlfin_payment_paid_actual);
                        dTotalDiffRec = dTotalPaidGo - dTotalRecActual;
                        dTotalFinDetailActual =
                            double.parse(lFin.first.tlfinancial_actual);

                        dTotalDiffFinDetail =
                            dTotalFinDetailActual - dTotalRecActual;

                        await loadFinMenu(recSite, recDate);
                        await loadFinDetailByFinId(financialId);

                        lFinDetail.sort((a, b) => a.tlfinancial_type_number
                            .compareTo(b.tlfinancial_type_number));
                        groupFinTypeId = groupFinancialDetail(lFinDetail);

                        //!*--FinancialGroup
                        await buildFinancialGroup();
                        lFinGroup.sort(
                          (a, b) => a.tlfinancial_type_number
                              .compareTo(b.tlfinancial_type_number),
                        );

                        //!* -----------------
                      } else {
                        financialStatus = 'new'; // 'success'; //
                        await loadFinMenu(recSite, recDate);

                        if (lFinLeftMenu.isNotEmpty) {
                          //2 มี fin ❌ finMenu ✔ finDetail ✔❌(มีไม่ครบ)  finGroup ❌
                          financialId = lFinLeftMenu
                              .where((element) => element.rec_by != 'ALL')
                              .first
                              .tlfinancial_id;
                          //await loadPaymentMasterCheck(recSite, recDate);

                          await loadFinDetailByFinId(financialId);
                          //!** FinancialDetail
                          await buildPaymentToFinancialDetailAll();
                          await buildDepositToFinancialDetailAll();

                          dTotalPaidGo = double.parse(lFinLeftMenu
                              .where((element) =>
                                  element.rec_by == finLeftMenuRecBy)
                              .first
                              .tlpayment_sum_paid_go);
                          dTotalRecActual = double.parse(lFinLeftMenu
                              .where((element) =>
                                  element.rec_by == finLeftMenuRecBy)
                              .first
                              .tlpayment_sum_actual);

                          dTotalDiffRec = dTotalRecActual - dTotalPaidGo;

                          dTotalDiffFinDetail =
                              dTotalFinDetailActual - dTotalRecActual;

                          lFinDetail.sort((a, b) => a.tlfinancial_type_number
                              .compareTo(b.tlfinancial_type_number));
                          groupFinTypeId = groupFinancialDetail(lFinDetail);
                          //!* -----------------
                          //!** FinancialGroup
                          await buildFinancialGroup();
                          lFinGroup.sort(
                            (a, b) => a.tlfinancial_type_number
                                .compareTo(b.tlfinancial_type_number),
                          );
                          //!* -----------------
                        } else {
                          //3 มี fin ❌ finMenu❌ finDetail ❌ finGroup ❌
                          //!------------------
                          financialId = '${TlConstant.runID()}000';
                          await loadiMedRecReview(recSite, recDate);
                          //! load Payment Status Confirm
                          await loadPaymentMasterBuildFinMenu(recSite, recDate);
                          //!
                          await loadDepositAndDetail(recSite, recDate);

                          await loadPaymentDetailAll(recSite, recDate);
                          await loadDepositImageDB();
                          await loadPaymentDetailImageAll();
                          await loadPaymentDetailRemarkAll();

                          //!** FinancialDetail
                          await buildPaymentToFinancialDetailAll();
                          await buildDepositToFinancialDetailAll();

                          if (lRecReview.isNotEmpty) {
                            dTotalPaidGo = double.parse(lFinLeftMenu
                                .where((element) =>
                                    element.rec_by == finLeftMenuRecBy)
                                .first
                                .tlpayment_sum_paid_go);
                            dTotalRecActual = double.parse(lFinLeftMenu
                                .where((element) =>
                                    element.rec_by == finLeftMenuRecBy)
                                .first
                                .tlpayment_sum_actual);

                            dTotalDiffRec = dTotalRecActual - dTotalPaidGo;

                            dTotalDiffFinDetail =
                                dTotalFinDetailActual - dTotalRecActual;

                            lFinDetail.sort((a, b) => a.tlfinancial_type_number
                                .compareTo(b.tlfinancial_type_number));
                            groupFinTypeId = groupFinancialDetail(lFinDetail);
                            //!* -----------------
                            //!** FinancialGroup
                            await buildFinancialGroup();
                            lFinGroup.sort(
                              (a, b) => a.tlfinancial_type_number
                                  .compareTo(b.tlfinancial_type_number),
                            );
                            //!* -----------------

                            await createFinancialMenu();
                          }
                        }
                        isCheckALLApprove = true;
                        finLeftMenuStatus = 'confirm';
                        for (var ee in lFinLeftMenu) {
                          if (ee.rec_by == 'ALL') {
                          } else {
                            if (ee.tlfinancial_menu_status != 'confirm') {
                              isCheckALLApprove = false;
                              finLeftMenuStatus = 'create';
                            }
                          }
                        }
                      }

                      setState(() {
                        runProcess = 'Success';
                        isCheckBtnLoadData = false;
                      });
                    }
                  },
                ),
              ),
            ]),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Expanded(
            child: SizedBox(
                child: runProcess == 'Start'
                    ? const Center(
                        child: Text('เลือก วันที่ และ สาขา'),
                      )
                    : runProcess == 'LoadData'
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : runProcess == 'Success' &&
                                lRecReview.isEmpty &&
                                lFinLeftMenu.isEmpty
                            ? const Center(
                                child: Text('ไม่มีรายการ'),
                              )
                            : Row(
                                children: [
                                  Expanded(
                                      flex: 4,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: Column(children: [
                                          Card(
                                            color: Colors.green[200],
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                      //width: 160,
                                                      child: Center(
                                                          child: Text(
                                                    'ชื่อ',
                                                    style: TextStyle(
                                                        color:
                                                            Colors.green[900],
                                                        fontSize: 16),
                                                  ))),
                                                  Expanded(
                                                      //width: 140,
                                                      child: Center(
                                                          child: Text(
                                                    'ยอดปิดผลัด',
                                                    style: TextStyle(
                                                        color:
                                                            Colors.green[900],
                                                        fontSize: 16),
                                                  ))),
                                                  Expanded(
                                                      //  width: 140,
                                                      child: Center(
                                                          child: Text(
                                                    'ยอดรายงาน 6.10',
                                                    style: TextStyle(
                                                        color:
                                                            Colors.green[900],
                                                        fontSize: 16),
                                                  ))),
                                                  SizedBox(
                                                      width: 60,
                                                      child: Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Text(
                                                            'ส่วนต่าง',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green[900],
                                                                fontSize: 16),
                                                          ))),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Expanded(
                                              child: SizedBox(
                                            child: ListView.builder(
                                              itemCount: lFinLeftMenu.length,
                                              itemBuilder: (context, indexRec) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 1.0),
                                                  child: Card(
                                                    color: financialStatus ==
                                                                'success' &&
                                                            lFinLeftMenu[
                                                                        indexRec]
                                                                    .rec_by ==
                                                                'ALL'
                                                        ? Colors.grey[300]
                                                        : lFinLeftMenu[indexRec]
                                                                    .tlfinancial_menu_status ==
                                                                'confirm'
                                                            ? Colors.grey[300]
                                                            : finLeftMenuRecBy ==
                                                                    lFinLeftMenu[
                                                                            indexRec]
                                                                        .rec_by
                                                                ? Colors
                                                                    .green[100]
                                                                : null,
                                                    child: SizedBox(
                                                      height: 60,
                                                      child: InkWell(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        hoverColor:
                                                            Colors.green[100],
                                                        onTap: () async {
                                                          print(
                                                              'selectFinLeftMent =>');
                                                          print(lFinLeftMenu[
                                                              indexRec]);
                                                          //!1 Setให้ สีขึ้นที่Card ที่เลือก
                                                          finLeftMenuRecBy =
                                                              lFinLeftMenu[
                                                                      indexRec]
                                                                  .rec_by;
                                                          finLeftMenuId =
                                                              lFinLeftMenu[
                                                                      indexRec]
                                                                  .tlfinancial_menu_id;
                                                          //!2 Setให้ ส่วนFinanMaster show Loading
                                                          isLoadFinancialGroup =
                                                              true;
                                                          //!3 Setให้ ส่วนFinanDetail show Loading
                                                          isLoadFinancialDetail =
                                                              true;
                                                          lFinDetail = [];
                                                          lFinGroup = [];
                                                          dTotalPaidGo = 0.0;
                                                          dTotalRecActual = 0.0;
                                                          dTotalDiffRec = 0.0;
                                                          dTotalDiffFinDetail =
                                                              0.0;
                                                          dTotalFinDetailActual =
                                                              0.0;

                                                          isCheckALLApprove =
                                                              false;
                                                          setState(() {});
                                                          if (finLeftMenuRecBy ==
                                                              'ALL') {
                                                            //!** FinancialDetail
                                                            await loadFinDetailByFinId(
                                                                financialId);
                                                            await buildPaymentToFinancialDetailAll();
                                                            await buildDepositToFinancialDetailAll();

                                                            dTotalPaidGo = double
                                                                .parse(lFinLeftMenu[
                                                                        indexRec]
                                                                    .tlpayment_sum_paid_go);
                                                            dTotalRecActual = double
                                                                .parse(lFinLeftMenu[
                                                                        indexRec]
                                                                    .tlpayment_sum_actual);

                                                            dTotalDiffRec =
                                                                dTotalRecActual -
                                                                    dTotalPaidGo;

                                                            dTotalDiffFinDetail =
                                                                dTotalFinDetailActual -
                                                                    dTotalRecActual;

                                                            lFinDetail.sort((a,
                                                                    b) =>
                                                                a.tlfinancial_type_number
                                                                    .compareTo(b
                                                                        .tlfinancial_type_number));
                                                            groupFinTypeId =
                                                                groupFinancialDetail(
                                                                    lFinDetail);

                                                            //!** FinancialGroup
                                                            await buildFinancialGroup();
                                                            lFinGroup.sort(
                                                              (a, b) => a
                                                                  .tlfinancial_type_number
                                                                  .compareTo(b
                                                                      .tlfinancial_type_number),
                                                            );
                                                            isCheckALLApprove =
                                                                true;
                                                            finLeftMenuStatus =
                                                                'confirm';
                                                            for (var ee
                                                                in lFinLeftMenu) {
                                                              if (ee.rec_by ==
                                                                  'ALL') {
                                                              } else {
                                                                if (ee.tlfinancial_menu_status !=
                                                                    'confirm') {
                                                                  isCheckALLApprove =
                                                                      false;
                                                                  finLeftMenuStatus =
                                                                      'create';
                                                                }
                                                              }
                                                            }

                                                            //!* -----------------
                                                          } else {
                                                            finLeftMenuStatus =
                                                                lFinLeftMenu[
                                                                        indexRec]
                                                                    .tlfinancial_menu_status;

                                                            if (finLeftMenuStatus ==
                                                                    'nodata' ||
                                                                finLeftMenuStatus ==
                                                                    'create') {
                                                              isFinMenuStatusSwitch =
                                                                  false;
                                                            } else {
                                                              isFinMenuStatusSwitch =
                                                                  true;
                                                            }

                                                            print(
                                                                'finLeftMenuStatus ${lFinLeftMenu[indexRec].tlfinancial_menu_status}');
                                                            await loadFinDetailByFinMenu();

                                                            //!** FinancialDetail
                                                            await buildPaymentToFinancialDetail(
                                                                finLeftMenuRecBy);
                                                            await buildDepositToFinancialDetail(
                                                                finLeftMenuRecBy);

                                                            for (var mFinDetail
                                                                in lFinDetail) {
                                                              dTotalPaidGo +=
                                                                  double.parse(
                                                                      mFinDetail
                                                                          .tlpayment_detail_paid_go);

                                                              dTotalRecActual +=
                                                                  double.parse(
                                                                      mFinDetail
                                                                          .tlpayment_detail_actual_paid);
                                                            }

                                                            dTotalDiffRec =
                                                                dTotalRecActual -
                                                                    dTotalPaidGo;

                                                            dTotalDiffFinDetail =
                                                                dTotalFinDetailActual -
                                                                    dTotalRecActual;

                                                            lFinDetail.sort((a,
                                                                    b) =>
                                                                a.tlfinancial_type_number
                                                                    .compareTo(b
                                                                        .tlfinancial_type_number));
                                                            groupFinTypeId =
                                                                groupFinancialDetail(
                                                                    lFinDetail);
                                                            //!* -----------------
                                                            //!** FinancialGroup
                                                            await buildFinancialGroup();
                                                            lFinGroup.sort(
                                                              (a, b) => a
                                                                  .tlfinancial_type_number
                                                                  .compareTo(b
                                                                      .tlfinancial_type_number),
                                                            );
                                                            //!* -----------------
                                                          }
                                                          Future.delayed(
                                                            const Duration(
                                                                milliseconds:
                                                                    1000),
                                                            () {
                                                              isLoadFinancialGroup =
                                                                  false;
                                                              isLoadFinancialDetail =
                                                                  false;
                                                              setState(() {});
                                                            },
                                                          );
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: Center(
                                                                  child: indexRec ==
                                                                          0
                                                                      ? Text(
                                                                          '${lFinLeftMenu[indexRec].tlpayment_fullname}(${lFinLeftMenu.length - 1})',
                                                                          style:
                                                                              TextStyle(color: financialStatus == 'success' && lFinLeftMenu[indexRec].rec_by == 'ALL' ? Colors.blue[900] : null),
                                                                        )
                                                                      : Text(
                                                                          '${indexRec}. ${lFinLeftMenu[indexRec].tlpayment_fullname}',
                                                                          style:
                                                                              TextStyle(color: lFinLeftMenu[indexRec].tlfinancial_menu_status == 'confirm' ? Colors.blue[900] : null)),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  child: Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          //! มาจาก lPaymentMaster
                                                                          Text(
                                                                              oCcy.format(double.parse(lFinLeftMenu[indexRec].tlpayment_sum_paid)),
                                                                              style: TextStyle(
                                                                                  color: financialStatus == 'success' && lFinLeftMenu[indexRec].rec_by == 'ALL'
                                                                                      ? Colors.blue[900]
                                                                                      : lFinLeftMenu[indexRec].tlfinancial_menu_status == 'confirm'
                                                                                          ? Colors.blue[900]
                                                                                          : null)))),
                                                              Expanded(
                                                                  child: Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child: Text(
                                                                          oCcy.format(
                                                                              double.parse(lFinLeftMenu[indexRec].rec_sum_paid_imed)),
                                                                          style: TextStyle(
                                                                              color: financialStatus == 'success' && lFinLeftMenu[indexRec].rec_by == 'ALL'
                                                                                  ? Colors.blue[900]
                                                                                  : lFinLeftMenu[indexRec].tlfinancial_menu_status == 'confirm'
                                                                                      ? Colors.blue[900]
                                                                                      : null)))),
                                                              SizedBox(
                                                                width: 80,
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  child: double.parse(lFinLeftMenu[indexRec].tlfinancial_menu_diffimedpaid) >
                                                                              -100 &&
                                                                          double.parse(lFinLeftMenu[indexRec].tlfinancial_menu_diffimedpaid) <
                                                                              0
                                                                      ? Text(
                                                                          lFinLeftMenu[indexRec]
                                                                              .tlfinancial_menu_diffimedpaid,
                                                                          style:
                                                                              const TextStyle(color: Colors.red),
                                                                        )
                                                                      : double.parse(lFinLeftMenu[indexRec].tlfinancial_menu_diffimedpaid) < 100 &&
                                                                              double.parse(lFinLeftMenu[indexRec].tlfinancial_menu_diffimedpaid) >= 0
                                                                          ? Text(
                                                                              lFinLeftMenu[indexRec].tlfinancial_menu_diffimedpaid,
                                                                              style: const TextStyle(color: Colors.green),
                                                                            )
                                                                          : Tooltip(
                                                                              message: oCcy.format(double.parse(lFinLeftMenu[indexRec].tlfinancial_menu_diffimedpaid)),
                                                                              child: Icon(
                                                                                Icons.warning_outlined,
                                                                                color: Colors.red[900],
                                                                              ),
                                                                            ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          )),
                                        ]),
                                      )),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                      flex: 10,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 120,
                                            child: Card(
                                              elevation: 3,
                                              color: Colors.grey[300],
                                              child: Padding(
                                                  padding: EdgeInsets.all(4.0),
                                                  child: isLoadFinancialGroup
                                                      ? const Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        )
                                                      : lFinGroup.isEmpty
                                                          ? Center(
                                                              child: const Text(
                                                                  "No data"))
                                                          :
                                                          //! FinancialGroup
                                                          SizedBox(
                                                              child: Center(
                                                                child: ListView
                                                                    .builder(
                                                                  shrinkWrap:
                                                                      true,
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  itemCount:
                                                                      lFinGroup
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          indexK) {
                                                                    return Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          vertical:
                                                                              8.0,
                                                                          horizontal:
                                                                              16.0),
                                                                      child: lFinGroup[indexK].tlfinancial_type_group == 'DepositBank' &&
                                                                              finLeftMenuRecBy == 'ALL'
                                                                          ? InkWell(
                                                                              onTap: () {
                                                                                showDialog(
                                                                                  context: context,
                                                                                  builder: (context) {
                                                                                    return Dialog(
                                                                                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                                                                                        child: DepositImageScreen(
                                                                                          lDepositImage: lDepositImage,
                                                                                          lDepositImageDB: lDepositImageDB,
                                                                                          isStatusScreen: isStatusScreen,
                                                                                          depositId: '',
                                                                                          callbackFunctions: (p0) {},
                                                                                          callbackRemove: (reId) {},
                                                                                          callbackChangeComment: (dim) {},
                                                                                        ));
                                                                                  },
                                                                                );
                                                                              },
                                                                              child: Column(
                                                                                children: [
                                                                                  Text(lFinGroup[indexK].tlfinancial_type_group, style: TextStyle(color: Colors.green[900])),
                                                                                  const SizedBox(
                                                                                    height: 8,
                                                                                  ),
                                                                                  SizedBox(
                                                                                      child: lDepositImageDB.isNotEmpty
                                                                                          ? Row(
                                                                                              children: [
                                                                                                Text(lFinGroup[indexK].tlfinancial_type_name, style: TextStyle(color: Colors.green[900])),
                                                                                                const SizedBox(
                                                                                                  width: 4.0,
                                                                                                ),
                                                                                                Icon(
                                                                                                  Icons.image,
                                                                                                  color: Colors.green[900],
                                                                                                )
                                                                                              ],
                                                                                            )
                                                                                          : Text(lFinGroup[indexK].tlfinancial_type_name, style: TextStyle(color: Colors.green[900]))),
                                                                                  const SizedBox(
                                                                                    height: 8,
                                                                                  ),
                                                                                  Text(oCcy.format(double.parse(lFinGroup[indexK].tlfinancial_group_sum)), style: TextStyle(color: Colors.green[900])),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          : Column(
                                                                              children: [
                                                                                Text(lFinGroup[indexK].tlfinancial_type_group, style: TextStyle(color: lFinGroup[indexK].tlfinancial_type_group == 'other' ? Colors.red : Colors.green[900])),
                                                                                const SizedBox(
                                                                                  height: 8,
                                                                                ),
                                                                                Text(lFinGroup[indexK].tlfinancial_type_name, style: TextStyle(color: lFinGroup[indexK].tlfinancial_type_group == 'other' ? Colors.red : Colors.green[900])),
                                                                                const SizedBox(
                                                                                  height: 8,
                                                                                ),
                                                                                Text(oCcy.format(double.parse(lFinGroup[indexK].tlfinancial_group_sum)), style: TextStyle(color: lFinGroup[indexK].tlfinancial_type_group == 'other' ? Colors.red : Colors.green[900])),
                                                                              ],
                                                                            ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            )),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: SizedBox(
                                              child: finLeftMenuRecBy ==
                                                          'ALL' &&
                                                      isCheckALLApprove == true
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: SizedBox(
                                                        height: 36,
                                                        child: ElevatedButton(
                                                          onHover: (hover) {
                                                            isBtnFinReviewHover =
                                                                hover;
                                                            setState(() {});
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                              foregroundColor:
                                                                  isBtnFinReviewHover
                                                                      ? Colors.grey[
                                                                          300]
                                                                      : Colors.green[
                                                                          900],
                                                              backgroundColor:
                                                                  isBtnFinReviewHover
                                                                      ? Colors.green[
                                                                          900]
                                                                      : Colors.grey[
                                                                          300],
                                                              shape: RoundedRectangleBorder(
                                                                  side: BorderSide(
                                                                      width: 2,
                                                                      color: Colors
                                                                          .green
                                                                          .shade900),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50))),
                                                          child: const Text(
                                                              ' Review '),
                                                          onPressed: () async {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return StatefulBuilder(
                                                                  builder: (context,
                                                                      setState) {
                                                                    return Dialog(
                                                                      child: SizedBox(
                                                                          height: MediaQuery.of(context).size.height / 1.2,
                                                                          width: MediaQuery.of(context).size.width / 3,
                                                                          child: Card(
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.all(16.0),
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: SizedBox(
                                                                                      child: ListView.builder(
                                                                                        itemCount: lFinGroup.length,
                                                                                        itemBuilder: (context, indexFinal) {
                                                                                          return Padding(
                                                                                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                                                                            child: lFinGroup[indexFinal].tlfinancial_type_group == 'DepositBank' && finLeftMenuRecBy == 'ALL'
                                                                                                ? InkWell(
                                                                                                    onTap: () {
                                                                                                      showDialog(
                                                                                                        context: context,
                                                                                                        builder: (context) {
                                                                                                          return Dialog(
                                                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                                                                                                              child: DepositImageScreen(
                                                                                                                lDepositImage: lDepositImage,
                                                                                                                lDepositImageDB: lDepositImageDB,
                                                                                                                isStatusScreen: isStatusScreen,
                                                                                                                depositId: '',
                                                                                                                callbackFunctions: (p0) {},
                                                                                                                callbackRemove: (reId) {},
                                                                                                                callbackChangeComment: (dim) {},
                                                                                                              ));
                                                                                                        },
                                                                                                      );
                                                                                                    },
                                                                                                    child: Row(
                                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                      children: [
                                                                                                        SizedBox(
                                                                                                            child: lDepositImageDB.isNotEmpty
                                                                                                                ? Row(
                                                                                                                    children: [
                                                                                                                      Text('${lFinGroup[indexFinal].tlfinancial_type_name} (${lFinGroup[indexFinal].tlfinancial_type_group})', style: TextStyle(color: Colors.green[900])),
                                                                                                                      const SizedBox(
                                                                                                                        width: 4.0,
                                                                                                                      ),
                                                                                                                      Icon(
                                                                                                                        Icons.image,
                                                                                                                        color: Colors.green[900],
                                                                                                                      )
                                                                                                                    ],
                                                                                                                  )
                                                                                                                : Text('${lFinGroup[indexFinal].tlfinancial_type_name} (${lFinGroup[indexFinal].tlfinancial_type_group})', style: TextStyle(color: Colors.green[900]))),
                                                                                                        Text(oCcy.format(double.parse(lFinGroup[indexFinal].tlfinancial_group_sum)), style: TextStyle(color: Colors.green[900])),
                                                                                                      ],
                                                                                                    ),
                                                                                                  )
                                                                                                : lFinGroup[indexFinal].tlfinancial_type_group == 'CheckByFIN'
                                                                                                    ? Padding(
                                                                                                        padding: const EdgeInsets.only(top: 24.0),
                                                                                                        child: Row(
                                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                          children: [
                                                                                                            Text('${lFinGroup[indexFinal].tlfinancial_type_name} (${lFinGroup[indexFinal].tlfinancial_type_group})', style: TextStyle(color: lFinGroup[indexFinal].tlfinancial_type_group == 'other' ? Colors.red : Colors.green[900])),
                                                                                                            Text(oCcy.format(double.parse(lFinGroup[indexFinal].tlfinancial_group_sum)), style: TextStyle(color: lFinGroup[indexFinal].tlfinancial_type_group == 'other' ? Colors.red : Colors.green[900])),
                                                                                                          ],
                                                                                                        ),
                                                                                                      )
                                                                                                    : Row(
                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                        children: [
                                                                                                          Text('${lFinGroup[indexFinal].tlfinancial_type_name} (${lFinGroup[indexFinal].tlfinancial_type_group})', style: TextStyle(color: lFinGroup[indexFinal].tlfinancial_type_group == 'other' ? Colors.red : Colors.green[900])),
                                                                                                          Text(oCcy.format(double.parse(lFinGroup[indexFinal].tlfinancial_group_sum)), style: TextStyle(color: lFinGroup[indexFinal].tlfinancial_type_group == 'other' ? Colors.red : Colors.green[900])),
                                                                                                        ],
                                                                                                      ),
                                                                                          );
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 24,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    child: TextFormField(
                                                                                      readOnly: financialStatus == 'success' ? true : false,
                                                                                      autofocus: true,
                                                                                      decoration: const InputDecoration(labelText: "หมายเหตุ"),
                                                                                      controller: finCommentController,
                                                                                      onChanged: (value) {},
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 24,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 36,
                                                                                    child: financialStatus == 'success'
                                                                                        ? null
                                                                                        : ElevatedButton(
                                                                                            onHover: (hover) {
                                                                                              isBtnFinConfirmHover = hover;
                                                                                              setState(() {});
                                                                                            },
                                                                                            style: ElevatedButton.styleFrom(foregroundColor: isBtnFinConfirmHover ? Colors.grey[300] : Colors.green[900], backgroundColor: isBtnFinConfirmHover ? Colors.green[900] : Colors.grey[300], shape: RoundedRectangleBorder(side: BorderSide(width: 2, color: Colors.green.shade900), borderRadius: BorderRadius.circular(50))),
                                                                                            child: const Text(' Financial Confirm '),
                                                                                            onPressed: () async {
                                                                                              double sumFinActual = 0.0;
                                                                                              double diffFin = 0.0;
                                                                                              lFin = [];
                                                                                              showDialog(
                                                                                                barrierDismissible: true,
                                                                                                context: context,
                                                                                                builder: (context) {
                                                                                                  return const Center(child: CircularProgressIndicator());
                                                                                                },
                                                                                              );
                                                                                              for (var fg in lFinGroup) {
                                                                                                await createFinancialGroup(fg);
                                                                                                sumFinActual += double.parse(fg.tlfinancial_group_sum);
                                                                                              }
                                                                                              diffFin = sumFinActual - double.parse(lFinLeftMenu.where((element) => element.rec_by == 'ALL').first.tlpayment_sum_actual);

                                                                                              final dateNow = DateTime.now();
                                                                                              print('lFinancial =>');
                                                                                              FinancialModel newFin = FinancialModel(tlfinancial_id: financialId, tlfinancial_rec_date: recDate, tlfinancial_rec_site: recSite, tlfinancial_create_by: widget.lEmp.first.employee_id, tlfinancial_create_date: DateFormat('yyyy-MM-dd').format(dateNow), tlfinancial_create_time: DateFormat('HH:mm:ss').format(dateNow), tlfin_imed_paid: lFinLeftMenu.where((element) => element.rec_by == 'ALL').first.rec_sum_paid_imed, tlfin_payment_paid: lFinLeftMenu.where((element) => element.rec_by == 'ALL').first.tlpayment_sum_paid, tlfin_payment_paid_go: lFinLeftMenu.where((element) => element.rec_by == 'ALL').first.tlpayment_sum_paid_go, tlfin_payment_paid_actual: lFinLeftMenu.where((element) => element.rec_by == 'ALL').first.tlpayment_sum_actual, tlfinancial_actual: sumFinActual.toStringAsFixed(2), tlfinancial_diff: diffFin.toStringAsFixed(2), tlfinancial_status: 'success', tlfinancial_comment: finCommentController.text, tlfinancial_modify_by: '', tlfinancial_modify_date: '', tlfinancial_modify_time: '');
                                                                                              lFin.add(newFin);
                                                                                              await createFinancial(newFin);

                                                                                              Navigator.pop(context);
                                                                                              Navigator.pop(context);
                                                                                              financialStatus = 'success';
                                                                                              setStateMain();
                                                                                            },
                                                                                          ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          )),
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox(
                                                      height: 4,
                                                    ),
                                            ),
                                          ),
                                          Expanded(
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[200],
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          36))),
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                        flex: 8,
                                                        child:
                                                            isLoadFinancialDetail
                                                                ? const Center(
                                                                    child:
                                                                        CircularProgressIndicator(),
                                                                  )
                                                                : lFinDetail
                                                                        .isEmpty
                                                                    ? const Center(
                                                                        child: Text(
                                                                            "No data"))
                                                                    : SizedBox(
                                                                        child:
                                                                            //! Financial Detail
                                                                            ListView.builder(
                                                                                itemCount: groupFinTypeId.length,
                                                                                itemBuilder: (context, indexM) {
                                                                                  String typeId = groupFinTypeId.keys.elementAt(indexM);
                                                                                  final lFinTAC = lFinTypeAndCom.where((element) => element.tlfinancial_type_id == typeId).toList();

                                                                                  String typeName = 'อื่นๆ (other)';
                                                                                  if (lFinTAC.isNotEmpty) {
                                                                                    typeName = '${lFinTAC.first.tlfinancial_type_name} (${lFinTAC.first.tlfinancial_type_group})';
                                                                                  }

                                                                                  List<FinancialDetailModel> data = groupFinTypeId.values.elementAt(indexM);
                                                                                  data.sort((a, b) {
                                                                                    int sortMulti = a.tlpayment_type_id.compareTo(b.tlpayment_type_id);
                                                                                    if (sortMulti == 0) {
                                                                                      return a.tlpayment_rec_by.compareTo(b.tlpayment_rec_by);
                                                                                    }
                                                                                    return sortMulti;
                                                                                  });
                                                                                  return Column(
                                                                                    children: [
                                                                                      Card(
                                                                                          color: finLeftMenuStatus == 'confirm' ? Colors.grey[300] : Colors.green[100],
                                                                                          child: Align(
                                                                                            alignment: Alignment.centerLeft,
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8.0),
                                                                                              child: InkWell(
                                                                                                onHover: (value) {
                                                                                                  //print(typeId);
                                                                                                },
                                                                                                onTap: () {},
                                                                                                child: Text(
                                                                                                  typeName,
                                                                                                  style: const TextStyle(fontSize: 16),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          )),
                                                                                      ListView.builder(
                                                                                        shrinkWrap: true,
                                                                                        physics: ClampingScrollPhysics(),
                                                                                        itemCount: data.length,
                                                                                        itemBuilder: (context, index) {
                                                                                          FinancialDetailModel mFinDetail = data[index];
                                                                                          return Padding(
                                                                                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                                                                            child: Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                              children: [
                                                                                                TextButton(
                                                                                                    onHover: (value) {},
                                                                                                    onPressed: () {
                                                                                                      showDialog(
                                                                                                        context: context,
                                                                                                        builder: (context) {
                                                                                                          finDetailCommentController.text = mFinDetail.tlfinancial_detail_comment;
                                                                                                          bool isEditFinGroup = true;
                                                                                                          String finGroup = mFinDetail.tlfinancial_type_group;
                                                                                                          String finName = mFinDetail.tlfinancial_type_name;
                                                                                                          String finTypeId = mFinDetail.tlfinancial_type_id;
                                                                                                          String finTypeNum = '';
                                                                                                          return StatefulBuilder(
                                                                                                            builder: (context, setState) {
                                                                                                              return Dialog(
                                                                                                                child: SizedBox(
                                                                                                                    height: MediaQuery.of(context).size.height / 1.2,
                                                                                                                    width: MediaQuery.of(context).size.width / 3,
                                                                                                                    child: Card(
                                                                                                                      child: SingleChildScrollView(
                                                                                                                        child: Padding(
                                                                                                                          padding: EdgeInsets.all(16.0),
                                                                                                                          child: Column(
                                                                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                                                                            children: [
                                                                                                                              Text(
                                                                                                                                '${mFinDetail.tlpayment_type_detail} (${mFinDetail.tlpayment_type})',
                                                                                                                                style: TextStyle(color: Colors.green[900]),
                                                                                                                              ),
                                                                                                                              const SizedBox(
                                                                                                                                height: 24.0,
                                                                                                                              ),
                                                                                                                              Row(
                                                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                                children: [
                                                                                                                                  const Text('ประเภทการชำระเงิน'),
                                                                                                                                  Text('${mFinDetail.tlpayment_type}'),
                                                                                                                                ],
                                                                                                                              ),
                                                                                                                              Row(
                                                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                                children: [
                                                                                                                                  const Text('ประเภทการรับเงิน'),
                                                                                                                                  Text('${mFinDetail.tlpayment_type_detail}'),
                                                                                                                                ],
                                                                                                                              ),
                                                                                                                              const SizedBox(
                                                                                                                                height: 24,
                                                                                                                              ),
                                                                                                                              Row(
                                                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                                children: [
                                                                                                                                  const Text('ยอดรายได้ในผลัด'),
                                                                                                                                  Text(oCcy.format(double.parse(mFinDetail.tlpayment_detail_paid))),
                                                                                                                                ],
                                                                                                                              ),
                                                                                                                              Row(
                                                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                                children: [
                                                                                                                                  const Text('ยอดที่ต้องนำส่ง'),
                                                                                                                                  Text(oCcy.format(double.parse(mFinDetail.tlpayment_detail_paid_go))),
                                                                                                                                ],
                                                                                                                              ),
                                                                                                                              Row(
                                                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                                children: [
                                                                                                                                  const Text('ยอดส่งจริง'),
                                                                                                                                  Text(oCcy.format(double.parse(mFinDetail.tlpayment_detail_actual_paid))),
                                                                                                                                ],
                                                                                                                              ),
                                                                                                                              Row(
                                                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                                children: [
                                                                                                                                  const Text('ส่วนต่าง(ปิดผลัด)'),
                                                                                                                                  Text(oCcy.format(double.parse(mFinDetail.tlpayment_detail_diff_paid))),
                                                                                                                                ],
                                                                                                                              ),
                                                                                                                              const SizedBox(
                                                                                                                                height: 24,
                                                                                                                              ),
                                                                                                                              Row(
                                                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                                children: [
                                                                                                                                  const Text('ยอดสรุปจาก การเงิน'),
                                                                                                                                  Text(oCcy.format(double.parse(mFinDetail.tlfinancial_detail_actual))),
                                                                                                                                ],
                                                                                                                              ),
                                                                                                                              const SizedBox(
                                                                                                                                height: 24,
                                                                                                                              ),
                                                                                                                              Row(
                                                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                                children: [
                                                                                                                                  const Text('วันที่ฝาก'),
                                                                                                                                  Text(mFinDetail.tldeposit_date.isEmpty ? '-' : '${mFinDetail.tldeposit_date}'),
                                                                                                                                ],
                                                                                                                              ),
                                                                                                                              Row(
                                                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                                children: [
                                                                                                                                  const Text('เลขบัญชีนำฝาก'),
                                                                                                                                  Text(mFinDetail.tldeposit_bank_account.isEmpty ? '-' : '${mFinDetail.tldeposit_bank_account}'),
                                                                                                                                ],
                                                                                                                              ),
                                                                                                                              Row(
                                                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                                children: [
                                                                                                                                  const Text('คนนำฝาก'),
                                                                                                                                  Text(mFinDetail.deposit_fullname.isEmpty ? '-' : '${mFinDetail.deposit_fullname}'),
                                                                                                                                ],
                                                                                                                              ),
                                                                                                                              Row(
                                                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                                children: [
                                                                                                                                  const Text('จำนวนที่ต้องนำฝาก'),
                                                                                                                                  Text(mFinDetail.tldeposit_total.isEmpty ? '-' : oCcy.format(double.parse(mFinDetail.tldeposit_total))),
                                                                                                                                ],
                                                                                                                              ),
                                                                                                                              Row(
                                                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                                children: [
                                                                                                                                  const Text('จำนวนที่นำฝาก'),
                                                                                                                                  Text(mFinDetail.tldeposit_total_actual.isEmpty ? '-' : oCcy.format(double.parse(mFinDetail.tldeposit_total_actual))),
                                                                                                                                ],
                                                                                                                              ),
                                                                                                                              Row(
                                                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                                children: [
                                                                                                                                  const Text('ส่วนต่าง(นำฝาก)'),
                                                                                                                                  Text(mFinDetail.tldeposit_total_balance.isEmpty ? '-' : oCcy.format(double.parse(mFinDetail.tldeposit_total_balance))),
                                                                                                                                ],
                                                                                                                              ),
                                                                                                                              const SizedBox(
                                                                                                                                height: 24,
                                                                                                                              ),
                                                                                                                              Row(
                                                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                                children: [
                                                                                                                                  const Text('กลุ่มทางการเงิน'),
                                                                                                                                  Text('${finGroup}'),
                                                                                                                                ],
                                                                                                                              ),
                                                                                                                              Row(
                                                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                                children: [
                                                                                                                                  const Text('ประเภททางการเงิน'),
                                                                                                                                  Text('${finName}'),
                                                                                                                                ],
                                                                                                                              ),
                                                                                                                              const SizedBox(
                                                                                                                                height: 8,
                                                                                                                              ),
                                                                                                                              Align(
                                                                                                                                  alignment: Alignment.centerRight,
                                                                                                                                  child: isEditFinGroup == true && lFinLeftMenu.where((element) => element.rec_by == mFinDetail.tlpayment_rec_by).first.tlfinancial_menu_status != 'confirm'
                                                                                                                                      ? JustTheTooltip(
                                                                                                                                          isModal: true,
                                                                                                                                          content: SizedBox(
                                                                                                                                              height: 400,
                                                                                                                                              width: 300,
                                                                                                                                              child: Column(
                                                                                                                                                children: [
                                                                                                                                                  Card(
                                                                                                                                                    color: Colors.blue[100],
                                                                                                                                                    child: Padding(
                                                                                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                                                                                      child: Row(
                                                                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                                                        children: [
                                                                                                                                                          Text(
                                                                                                                                                            'ประเภท',
                                                                                                                                                            style: TextStyle(color: Colors.blue[900]),
                                                                                                                                                          ),
                                                                                                                                                          Text('กลุ่ม', style: TextStyle(color: Colors.blue[900])),
                                                                                                                                                        ],
                                                                                                                                                      ),
                                                                                                                                                    ),
                                                                                                                                                  ),
                                                                                                                                                  Expanded(
                                                                                                                                                    child: SizedBox(
                                                                                                                                                      child: ListView.builder(
                                                                                                                                                        itemCount: lFinType.length,
                                                                                                                                                        itemBuilder: (context, index) {
                                                                                                                                                          return Card(
                                                                                                                                                            color: finTypeId == lFinType[index].tlfinancial_type_id ? Colors.grey : null,
                                                                                                                                                            child: InkWell(
                                                                                                                                                              hoverColor: Colors.green[100],
                                                                                                                                                              onTap: () async {
                                                                                                                                                                setState(() {
                                                                                                                                                                  finGroup = lFinType[index].tlfinancial_type_group;
                                                                                                                                                                  finName = lFinType[index].tlfinancial_type_name;
                                                                                                                                                                  finTypeId = lFinType[index].tlfinancial_type_id;
                                                                                                                                                                  finTypeNum = lFinType[index].tlfinancial_type_number;
                                                                                                                                                                  isEditFinGroup = false;
                                                                                                                                                                });

                                                                                                                                                                if (mFinDetail.tlfinancial_type_id == 'other') {
                                                                                                                                                                  String tlfinancial_type_compare_id = '${TlConstant.runID()}00';
                                                                                                                                                                  String tlfinancial_type_id = lFinType[index].tlfinancial_type_id;
                                                                                                                                                                  String tlpayment_type_id = mFinDetail.tlpayment_type_id;
                                                                                                                                                                  String tlpayment_type = mFinDetail.tlpayment_type;
                                                                                                                                                                  String tlpayment_type_detail = mFinDetail.tlpayment_type_detail;
                                                                                                                                                                  await createFinancialTypeCompare(tlfinancial_type_compare_id, tlfinancial_type_id, tlpayment_type_id, tlpayment_type, tlpayment_type_detail);

                                                                                                                                                                  //** */
                                                                                                                                                                  //!** FinancialDetail
                                                                                                                                                                  await loadFinTypeAndCom();

                                                                                                                                                                  lFinDetail.where((element) => element.tlpayment_detail_id == mFinDetail.tlpayment_detail_id).first.tlfinancial_type_id = finTypeId;
                                                                                                                                                                  lFinDetail.where((element) => element.tlpayment_detail_id == mFinDetail.tlpayment_detail_id).first.tlfinancial_type_name = finName;
                                                                                                                                                                  lFinDetail.where((element) => element.tlpayment_detail_id == mFinDetail.tlpayment_detail_id).first.tlfinancial_type_group = finGroup;
                                                                                                                                                                  lFinDetail.where((element) => element.tlpayment_detail_id == mFinDetail.tlpayment_detail_id).first.tlfinancial_type_number = finTypeNum;
                                                                                                                                                                  lFinDetail.where((element) => element.tlpayment_detail_id == mFinDetail.tlpayment_detail_id).first.tlfinancial_detail_comment = finDetailCommentController.text;

                                                                                                                                                                  lFinDetail.sort((a, b) => a.tlfinancial_type_number.compareTo(b.tlfinancial_type_number));

                                                                                                                                                                  groupFinTypeId = groupFinancialDetail(lFinDetail);

                                                                                                                                                                  //!* -----------------
                                                                                                                                                                  //!** FinancialGroup
                                                                                                                                                                  lFinGroup = [];
                                                                                                                                                                  await buildFinancialGroup();

                                                                                                                                                                  lFinGroup.sort(
                                                                                                                                                                    (a, b) => a.tlfinancial_type_number.compareTo(b.tlfinancial_type_number),
                                                                                                                                                                  );
                                                                                                                                                                } else {
                                                                                                                                                                  //Update
                                                                                                                                                                }
                                                                                                                                                                setStateMain();
                                                                                                                                                                Future.delayed(
                                                                                                                                                                  Duration(milliseconds: 200),
                                                                                                                                                                  () {
                                                                                                                                                                    setState(() {
                                                                                                                                                                      isEditFinGroup = true;
                                                                                                                                                                    });
                                                                                                                                                                  },
                                                                                                                                                                );

                                                                                                                                                                //ถ้าไม่มีใน database ให้ Create to FInancailTypeDetail

                                                                                                                                                                //ถ้ามี ให้ update
                                                                                                                                                              },
                                                                                                                                                              child: Padding(
                                                                                                                                                                padding: const EdgeInsets.all(8.0),
                                                                                                                                                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                                                                                                                                  Text(lFinType[index].tlfinancial_type_name),
                                                                                                                                                                  Text(lFinType[index].tlfinancial_type_group)
                                                                                                                                                                ]),
                                                                                                                                                              ),
                                                                                                                                                            ),
                                                                                                                                                          );
                                                                                                                                                        },
                                                                                                                                                      ),
                                                                                                                                                    ),
                                                                                                                                                  ),
                                                                                                                                                ],
                                                                                                                                              )),
                                                                                                                                          child: Icon(Icons.edit_square, color: Colors.grey))
                                                                                                                                      : const Icon(Icons.edit_square, color: Colors.grey)),
                                                                                                                              const SizedBox(
                                                                                                                                height: 24,
                                                                                                                              ),
                                                                                                                              SizedBox(
                                                                                                                                child: TextFormField(
                                                                                                                                  readOnly: lFinLeftMenu.where((element) => element.rec_by == mFinDetail.tlpayment_rec_by).first.tlfinancial_menu_status != 'confirm' ? false : true,
                                                                                                                                  autofocus: true,
                                                                                                                                  decoration: const InputDecoration(labelText: "หมายเหตุ"),
                                                                                                                                  controller: finDetailCommentController,
                                                                                                                                  onChanged: (value) {
                                                                                                                                    mFinDetail.tlfinancial_detail_comment = value;
                                                                                                                                    lFinDetail.where((element) => element.tlfinancial_detail_id == mFinDetail.tlfinancial_detail_id).first.tlfinancial_detail_comment = value;
                                                                                                                                    Future.delayed(
                                                                                                                                      Duration(milliseconds: 200),
                                                                                                                                      () {
                                                                                                                                        setStateMain();
                                                                                                                                      },
                                                                                                                                    );
                                                                                                                                  },
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            ],
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    )),
                                                                                                              );
                                                                                                            },
                                                                                                          );
                                                                                                        },
                                                                                                      );
                                                                                                    },
                                                                                                    child: finLeftMenuRecBy == 'ALL'
                                                                                                        ? mFinDetail.tldeposit_id == '' && mFinDetail.tlfinancial_type_group == 'DepositBank'
                                                                                                            ? Row(
                                                                                                                children: [
                                                                                                                  Text(
                                                                                                                    '${mFinDetail.tlpayment_type_detail} (${mFinDetail.tlpayment_type}) => ${mFinDetail.tlpayment_rec_by} (ไม่นำฝาก)',
                                                                                                                    style: const TextStyle(color: Colors.red),
                                                                                                                  ),
                                                                                                                  const SizedBox(
                                                                                                                    width: 8.0,
                                                                                                                  ),
                                                                                                                  SizedBox(
                                                                                                                    child: mFinDetail.tlfinancial_detail_comment == ''
                                                                                                                        ? null
                                                                                                                        : JustTheTooltip(
                                                                                                                            content: SizedBox(
                                                                                                                              child: Padding(
                                                                                                                                padding: const EdgeInsets.all(8.0),
                                                                                                                                child: Text(mFinDetail.tlfinancial_detail_comment),
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                            child: Icon(Icons.error, color: Colors.grey)),
                                                                                                                  )
                                                                                                                ],
                                                                                                              )
                                                                                                            : Row(
                                                                                                                children: [
                                                                                                                  Text(
                                                                                                                    '${mFinDetail.tlpayment_type_detail} (${mFinDetail.tlpayment_type}) => ${mFinDetail.tlpayment_rec_by} ',
                                                                                                                    style: TextStyle(color: Colors.green[900]),
                                                                                                                  ),
                                                                                                                  const SizedBox(
                                                                                                                    width: 8.0,
                                                                                                                  ),
                                                                                                                  SizedBox(
                                                                                                                    child: mFinDetail.tlfinancial_detail_comment == ''
                                                                                                                        ? null
                                                                                                                        : JustTheTooltip(
                                                                                                                            content: SizedBox(
                                                                                                                              child: Padding(
                                                                                                                                padding: const EdgeInsets.all(8.0),
                                                                                                                                child: Text(mFinDetail.tlfinancial_detail_comment),
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                            child: Icon(Icons.error, color: Colors.grey)),
                                                                                                                  )
                                                                                                                ],
                                                                                                              )
                                                                                                        : mFinDetail.tldeposit_id == '' && mFinDetail.tlfinancial_type_group == 'DepositBank'
                                                                                                            ? Row(
                                                                                                                children: [
                                                                                                                  Text(
                                                                                                                    '${mFinDetail.tlpayment_type_detail} (${mFinDetail.tlpayment_type}) => (ไม่นำฝาก)',
                                                                                                                    style: const TextStyle(color: Colors.red),
                                                                                                                  ),
                                                                                                                  const SizedBox(
                                                                                                                    width: 8.0,
                                                                                                                  ),
                                                                                                                  SizedBox(
                                                                                                                    child: mFinDetail.tlfinancial_detail_comment == ''
                                                                                                                        ? null
                                                                                                                        : JustTheTooltip(
                                                                                                                            content: SizedBox(
                                                                                                                              child: Padding(
                                                                                                                                padding: const EdgeInsets.all(8.0),
                                                                                                                                child: Text(mFinDetail.tlfinancial_detail_comment),
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                            child: Icon(Icons.error, color: Colors.grey)),
                                                                                                                  )
                                                                                                                ],
                                                                                                              )
                                                                                                            : Row(
                                                                                                                children: [
                                                                                                                  Text(
                                                                                                                    '${mFinDetail.tlpayment_type_detail} (${mFinDetail.tlpayment_type})',
                                                                                                                    style: TextStyle(color: Colors.green[900]),
                                                                                                                  ),
                                                                                                                  const SizedBox(
                                                                                                                    width: 8.0,
                                                                                                                  ),
                                                                                                                  SizedBox(
                                                                                                                    child: mFinDetail.tlfinancial_detail_comment == ''
                                                                                                                        ? null
                                                                                                                        : JustTheTooltip(
                                                                                                                            content: SizedBox(
                                                                                                                              child: Padding(
                                                                                                                                padding: const EdgeInsets.all(8.0),
                                                                                                                                child: Text(mFinDetail.tlfinancial_detail_comment),
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                            child: Icon(Icons.error, color: Colors.grey)),
                                                                                                                  )
                                                                                                                ],
                                                                                                              )),
                                                                                                const Expanded(child: SizedBox()),
                                                                                                // SizedBox(width: 200, child:
                                                                                                // Align(alignment: Alignment.centerRight, child: Text(oCcy.format(double.parse(mFinDetail.tlfinancial_detail_actual))))),
                                                                                                SizedBox(
                                                                                                    height: 40,
                                                                                                    width: 120,
                                                                                                    child: finLeftMenuRecBy == 'ALL'
                                                                                                        ? Align(alignment: Alignment.centerRight, child: Text(oCcy.format(double.parse(mFinDetail.tlfinancial_detail_actual))))
                                                                                                        : TextFormFieldActualFin(
                                                                                                            actualFin: mFinDetail.tlfinancial_detail_actual,
                                                                                                            finLeftMenuStatus: finLeftMenuStatus,
                                                                                                            callbackActualFin: (actFin) async {
                                                                                                              lFinDetail.where((element) => element.tlfinancial_detail_id == mFinDetail.tlfinancial_detail_id).first.tlfinancial_detail_actual = actFin;
                                                                                                              dTotalFinDetailActual = 0;
                                                                                                              lFinDetail.forEach((element) {
                                                                                                                dTotalFinDetailActual += double.parse(element.tlfinancial_detail_actual);
                                                                                                              });
                                                                                                              dTotalDiffFinDetail = dTotalFinDetailActual - dTotalRecActual;

                                                                                                              lFinGroup.clear();
                                                                                                              await buildFinancialGroup();
                                                                                                              lFinGroup.sort(
                                                                                                                (a, b) => a.tlfinancial_type_number.compareTo(b.tlfinancial_type_number),
                                                                                                              );

                                                                                                              setState(() {});
                                                                                                            })),
                                                                                                const SizedBox(
                                                                                                  width: 16,
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  child: lPaymentImage.where((element) => element.tlpayment_detail_id == mFinDetail.tlpayment_detail_id).isEmpty
                                                                                                      ? const Icon(
                                                                                                          Icons.add_photo_alternate_rounded,
                                                                                                          color: Colors.grey,
                                                                                                        )
                                                                                                      : InkWell(
                                                                                                          onTap: () {
                                                                                                            showDialog(
                                                                                                                barrierDismissible: false,
                                                                                                                context: context,
                                                                                                                builder: (context) {
                                                                                                                  return Dialog(
                                                                                                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                                                                                                                      child: PaymentImageScreen(
                                                                                                                        isStatusScreen: 'confirm',
                                                                                                                        lPaymentImageByType: lPaymentImage.where((e) => e.tlpayment_detail_id == mFinDetail.tlpayment_detail_id).toList(),
                                                                                                                        lPaymentImageDBByType: lPaymentImageDB.where((e) => e.tlpayment_detail_id == mFinDetail.tlpayment_detail_id).toList(),
                                                                                                                        paymentDetailId: mFinDetail.tlpayment_detail_id,
                                                                                                                        paymentId: mFinDetail.tlpayment_id,
                                                                                                                        callbackFunctions: (p0) {},
                                                                                                                        callbackRemove: (ImageReId) {},
                                                                                                                        callbackComment: (p1) {},
                                                                                                                      ));
                                                                                                                });
                                                                                                          },
                                                                                                          child: Icon(
                                                                                                            Icons.add_photo_alternate_rounded,
                                                                                                            color: Colors.green[900],
                                                                                                          ),
                                                                                                        ),
                                                                                                ),
                                                                                                const SizedBox(
                                                                                                  width: 8,
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  child: lPaymentRemark.where((element) => element.tlpayment_detail_id == mFinDetail.tlpayment_detail_id).isEmpty
                                                                                                      ? const Icon(
                                                                                                          Icons.edit_document,
                                                                                                          color: Colors.grey,
                                                                                                        )
                                                                                                      : InkWell(
                                                                                                          onTap: () {
                                                                                                            showDialog(
                                                                                                                barrierDismissible: false,
                                                                                                                context: context,
                                                                                                                builder: (context) {
                                                                                                                  return Dialog(
                                                                                                                    backgroundColor: Colors.transparent,
                                                                                                                    child: RemarkPopUp(
                                                                                                                      isStatusScreen: 'confirm',
                                                                                                                      lPaymentRemarkByType: lPaymentRemark.where((e) => e.tlpayment_detail_id == mFinDetail.tlpayment_detail_id).toList(),
                                                                                                                      paymentId: mFinDetail.tlpayment_id,
                                                                                                                      paymentDetailId: mFinDetail.tlpayment_detail_id,
                                                                                                                      callbackAdd: (lRemark) {},
                                                                                                                      callbackRemove: (remarkReId) {},
                                                                                                                    ),
                                                                                                                  );
                                                                                                                });
                                                                                                          },
                                                                                                          child: Icon(
                                                                                                            Icons.edit_document,
                                                                                                            color: Colors.green[900],
                                                                                                          ),
                                                                                                        ),
                                                                                                ),
                                                                                                const SizedBox(
                                                                                                  width: 8,
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  child: mFinDetail.tlpayment_detail_comment == ''
                                                                                                      ? const Icon(
                                                                                                          Icons.message_rounded,
                                                                                                          color: Colors.grey,
                                                                                                        )
                                                                                                      : JustTheTooltip(
                                                                                                          content: SizedBox(
                                                                                                            child: Padding(
                                                                                                              padding: const EdgeInsets.all(8.0),
                                                                                                              child: Text(mFinDetail.tlpayment_detail_comment),
                                                                                                            ),
                                                                                                          ),
                                                                                                          child: Icon(
                                                                                                            Icons.message_rounded,
                                                                                                            color: Colors.green[900],
                                                                                                          ),
                                                                                                        ),
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                          );
                                                                                        },
                                                                                      )
                                                                                    ],
                                                                                  );
                                                                                }),
                                                                      ),
                                                      ),
                                                      Padding(
                                                        padding: finLeftMenuRecBy ==
                                                                'ALL'
                                                            ? const EdgeInsets
                                                                .only(
                                                                top: 8,
                                                                bottom: 8,
                                                                right: 120)
                                                            : const EdgeInsets
                                                                .only(
                                                                top: 8,
                                                                right: 120),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            SizedBox(
                                                                child: dTotalPaidGo - double.parse(lFinLeftMenu.where((ee) => ee.rec_by == finLeftMenuRecBy).first.tlpayment_sum_paid_go) <
                                                                            1 &&
                                                                        dTotalPaidGo - double.parse(lFinLeftMenu.where((ee) => ee.rec_by == finLeftMenuRecBy).first.tlpayment_sum_paid_go) >
                                                                            -1
                                                                    ? null
                                                                    : const Tooltip(
                                                                        message:
                                                                            'กรุณากด อัพเดทข้อมูล',
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .warning_amber,
                                                                          color:
                                                                              Colors.orange,
                                                                        ))),
                                                            const SizedBox(
                                                                width: 16),
                                                            SizedBox(
                                                              child: Text(
                                                                'เงินนำส่ง (1) : ${oCcy.format(dTotalPaidGo)}',
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 16),
                                                            SizedBox(
                                                              child: Text(
                                                                'นำส่งจริง (2) : ${oCcy.format(dTotalRecActual)}',
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 16),
                                                            SizedBox(
                                                              child: Tooltip(
                                                                message:
                                                                    " (2) - (1)",
                                                                child: Text(
                                                                  'ส่วนต่าง : ${oCcy.format(dTotalDiffRec)}',
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 16),
                                                            SizedBox(
                                                              child: Text(
                                                                'ตรวจสอบ(การเงิน) (3) : ${oCcy.format(dTotalFinDetailActual)}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                            .blue[
                                                                        800]),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 16),
                                                            SizedBox(
                                                              child: Tooltip(
                                                                message:
                                                                    "(3) - (2)",
                                                                child: Text(
                                                                  'ส่วนต่าง(การเงิน) : ${oCcy.format(dTotalDiffFinDetail)}',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color: dTotalDiffFinDetail != 0
                                                                          ? Colors
                                                                              .red
                                                                          : Colors
                                                                              .blue[800]),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        child:
                                                            financialStatus ==
                                                                    'new'
                                                                ? Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      SizedBox(
                                                                          child: finLeftMenuRecBy == 'ALL' || isStatusScreen != 'New'
                                                                              ? null
                                                                              : Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: _buildSwitchStatusFinMenu(),
                                                                                )),
                                                                      SizedBox(
                                                                        child: finLeftMenuRecBy ==
                                                                                'ALL'
                                                                            ? null
                                                                            : finLeftMenuStatus == 'confirm'
                                                                                ? null
                                                                                : Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: SizedBox(
                                                                                      height: 36,
                                                                                      child: ElevatedButton(
                                                                                        onHover: (hover) {
                                                                                          isBtnUpdateHover = hover;
                                                                                          setState(() {});
                                                                                        },
                                                                                        style: ElevatedButton.styleFrom(foregroundColor: isBtnUpdateHover ? Colors.white : Colors.yellow[900], backgroundColor: isBtnUpdateHover ? Colors.yellow[900] : Colors.white, shape: RoundedRectangleBorder(side: BorderSide(width: 2, color: Colors.yellow.shade900), borderRadius: BorderRadius.circular(50))),
                                                                                        child: Text(' อัพเดทข้อมูล '),
                                                                                        onPressed: () async {
                                                                                          showDialog(
                                                                                            barrierDismissible: true,
                                                                                            context: context,
                                                                                            builder: (context) {
                                                                                              return const Center(child: CircularProgressIndicator());
                                                                                            },
                                                                                          );

                                                                                          final lFinDetailByMenuId = lFinDetail.where((element) => element.tlfinancial_menu_id == finLeftMenuId).toList();
                                                                                          lFinDetailByMenuId.sort(
                                                                                            (a, b) => a.tlpayment_id.compareTo(b.tlpayment_id),
                                                                                          );
                                                                                          String paymentIdMulti = '';
                                                                                          double dPaySumPaid = 0.0;
                                                                                          double dPaySumPaidGo = 0.0;
                                                                                          double dPaySumActual = 0.0;
                                                                                          double dSumPaidImed = 0.0;
                                                                                          for (var mFinDetail in lFinDetailByMenuId) {
                                                                                            paymentIdMulti += '${mFinDetail.tlpayment_id},';
                                                                                            dPaySumPaid += double.parse(mFinDetail.tlpayment_detail_paid);
                                                                                            dPaySumPaidGo += double.parse(mFinDetail.tlpayment_detail_paid_go);
                                                                                            dPaySumActual += double.parse(mFinDetail.tlpayment_detail_actual_paid);
                                                                                          }
                                                                                          paymentIdMulti = paymentIdMulti.substring(0, paymentIdMulti.length - 1);
                                                                                          dSumPaidImed = double.parse(lFinLeftMenu.where((element) => element.rec_by == finLeftMenuRecBy).first.rec_sum_paid_imed);

                                                                                          lFinLeftMenu.where((element) => element.rec_by == finLeftMenuRecBy).first.tlfinancial_menu_diffimedpaid = (dPaySumPaid - dSumPaidImed).toStringAsFixed(2);
                                                                                          lFinLeftMenu.where((element) => element.rec_by == finLeftMenuRecBy).first.tlpayment_sum_paid = dPaySumPaid.toStringAsFixed(2);
                                                                                          lFinLeftMenu.where((element) => element.rec_by == finLeftMenuRecBy).first.tlpayment_sum_paid_go = dPaySumPaidGo.toStringAsFixed(2);
                                                                                          lFinLeftMenu.where((element) => element.rec_by == finLeftMenuRecBy).first.tlpayment_sum_actual = dPaySumActual.toStringAsFixed(2);

                                                                                          await updateFinMenuDetail(lFinLeftMenu.where((element) => element.rec_by == finLeftMenuRecBy).first);

                                                                                          Navigator.pop(context);
                                                                                          setState(() {});
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                      ),
                                                                      SizedBox(
                                                                        child: finLeftMenuRecBy ==
                                                                                'ALL'
                                                                            ? null
                                                                            : finLeftMenuStatus == 'confirm'
                                                                                ? null
                                                                                : Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: SizedBox(
                                                                                      height: 36,
                                                                                      child: ElevatedButton(
                                                                                        onHover: (hover) {
                                                                                          isBtnAddPaymentHover = hover;
                                                                                          setState(() {});
                                                                                        },
                                                                                        style: ElevatedButton.styleFrom(foregroundColor: isBtnAddPaymentHover ? Colors.white : Colors.blue[900], backgroundColor: isBtnAddPaymentHover ? Colors.blue[900] : Colors.white, shape: RoundedRectangleBorder(side: BorderSide(width: 2, color: Colors.blue.shade900), borderRadius: BorderRadius.circular(50))),
                                                                                        child: const Padding(
                                                                                          padding: EdgeInsets.all(8.0),
                                                                                          child: Text(' เพิ่มประเภทการรับเงิน '),
                                                                                        ),
                                                                                        onPressed: () {
                                                                                          showDialog(
                                                                                              context: context,
                                                                                              builder: (context) {
                                                                                                return Dialog(
                                                                                                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                                                                                                    child: AddPaymentTypeFinancialScreen(
                                                                                                        financialId: financialId,
                                                                                                        financialMenuId: finLeftMenuId,
                                                                                                        site: recSite,
                                                                                                        empRec: finLeftMenuRecBy,
                                                                                                        lEmp: widget.lEmp,
                                                                                                        lFinTypeAndCom: lFinTypeAndCom,
                                                                                                        callbackAddFinDetail: (FinDeModel) async {
                                                                                                          lFinDetail.add(FinDeModel);
                                                                                                          lFinGroup = [];

                                                                                                          lFinDetail.sort((a, b) => a.tlfinancial_type_number.compareTo(b.tlfinancial_type_number));

                                                                                                          groupFinTypeId = '';
                                                                                                          setState(() {});
                                                                                                          Future.delayed(
                                                                                                            Duration(milliseconds: 200),
                                                                                                            () async {
                                                                                                              groupFinTypeId = groupFinancialDetail(lFinDetail);
                                                                                                              //!* -----------------
                                                                                                              //!** FinancialGroup
                                                                                                              await buildFinancialGroup();

                                                                                                              lFinGroup.sort(
                                                                                                                (a, b) => a.tlfinancial_type_number.compareTo(b.tlfinancial_type_number),
                                                                                                              );
                                                                                                              setState(() {});
                                                                                                            },
                                                                                                          );
                                                                                                        }));
                                                                                              });
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                : null,
                                                      ),
                                                    ],
                                                  )))
                                        ],
                                      ))
                                ],
                              ))),
      ]),
    );
  }

  FlutterSwitch _buildSwitchStatusFinMenu() {
    return FlutterSwitch(
      activeColor: Colors.green.shade900,
      inactiveColor: Colors.orange.shade900,
      activeIcon: Icon(Icons.check, color: Colors.green.shade900),
      inactiveIcon: Icon(
        Icons.close,
        color: Colors.orange.shade900,
      ),
      width: 90.0,
      height: 36.0,
      toggleSize: 24.0,
      valueFontSize: 14.0,
      activeText: 'confirm', //true
      activeTextColor: Colors.white,
      activeTextFontWeight: FontWeight.normal,
      inactiveText: 'waiting', // = false
      inactiveTextColor: Colors.white,
      inactiveTextFontWeight: FontWeight.normal,
      // toggleSize: 45.0,
      value: isFinMenuStatusSwitch,
      //borderRadius: 30.0,
      //padding: 8.0,
      showOnOff: true,
      onToggle: (val) async {
        showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return const Center(child: CircularProgressIndicator());
          },
        );

        isFinMenuStatusSwitch = val;
        if (isFinMenuStatusSwitch == true) {
          lFinLeftMenu
              .where((element) => element.tlfinancial_menu_id == finLeftMenuId)
              .first
              .tlfinancial_menu_status = 'confirm';
          finLeftMenuStatus = 'confirm';

          //!  update confirm to FinMenu
          await updateFinMenuStatus(finLeftMenuId, 'confirm');

          for (var ee in lFinDetail) {
            //! check FinDetail
            if (await loadIsCheckFinDetailById(ee.tlfinancial_detail_id) ==
                true) {
              //! Else ให้ Update
              await updateFinDetailByID(ee);
            } else {
              //! FinDetail == null  ให้ Create
              await createFinDetail(ee);
            }
          }
        } else if (isFinMenuStatusSwitch == false) {
          lFinLeftMenu
              .where((element) => element.tlfinancial_menu_id == finLeftMenuId)
              .first
              .tlfinancial_menu_status = 'create';
          finLeftMenuStatus = 'create';
          //!  update confirm to FinMenu
          updateFinMenuStatus(finLeftMenuId, 'create');
        }
        setState(() {
          Navigator.pop(context);
        });
      },
    );
  }

  void setStateMain() => setState(() {});

  Future createFinancialTypeCompare(
      String tlfinancial_type_compare_id,
      String tlfinancial_type_id,
      String tlpayment_type_id,
      String tlpayment_type,
      String tlpayment_type_detail) async {
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "1": tlfinancial_type_compare_id,
      "2": tlfinancial_type_id,
      "3": tlpayment_type_id,
      "4": tlpayment_type,
      "5": tlpayment_type_detail
    });
    String api = '${TlConstant.syncApi}tlFinancialTypeCompare.php?id=create';
    await Dio().post(api, data: formData);
  }

  buildFinancialGroup() {
    var gFinGroup = groupBy(lFinDetail, (p0) => p0.tlfinancial_type_id);
    int index = 0;
    double dGroupAllTotal = 0.0;
    String runId = TlConstant.runID();
    gFinGroup.forEach((key, value) {
      String tlfinancial_group_id =
          '${runId}${index.toString().padLeft(2, '0')}';

      String typeId = key;
      String group = value.first.tlfinancial_type_group;
      String name = value.first.tlfinancial_type_name;
      String num = value.first.tlfinancial_type_number;
      String tlfinancialId = value.first.tlfinancial_id;
      String tldepositId = '';
      String isCheckdepositId = '';
      double dGroupTotal = 0.0;
      if (group == 'DepositBank' && finLeftMenuRecBy == 'ALL') {
        value.sort((a, b) => a.tldeposit_id.compareTo(b.tldeposit_id));

            
        for (var ee in value) {
          if (ee.tldeposit_id.isNotEmpty) {
            if (tldepositId == '') {
              tldepositId += '${ee.tldeposit_id},';

              isCheckdepositId = ee.tldeposit_id;
              dGroupTotal += double.parse(ee.tldeposit_total_actual);
            } else if (isCheckdepositId != ee.tldeposit_id) {
              tldepositId += '${ee.tldeposit_id},';
              isCheckdepositId = ee.tldeposit_id;
              dGroupTotal += double.parse(ee.tldeposit_total_actual);
            }
          }
        }
        if (tldepositId.isNotEmpty) {
          tldepositId = tldepositId.substring(0, tldepositId.length - 1);
        }

        print('tldepositId => ${tldepositId} ');
        print('dGroupTotal => ${dGroupTotal} ');
      } else {
        for (var ee in value) {
          dGroupTotal += double.parse(ee.tlfinancial_detail_actual);
        }
      }
      dGroupAllTotal += dGroupTotal;
      FinancialGroupModel fsm = FinancialGroupModel(
          tlfinancial_group_id: tlfinancial_group_id,
          tlfinancial_type_id: typeId,
          tlfinancial_type_name: name,
          tlfinancial_type_group: group,
          tlfinancial_type_number: num,
          tlfinancial_group_sum: dGroupTotal.toStringAsFixed(2),
          tlfinancial_id: tlfinancialId,
          tldeposit_id: tldepositId);
      lFinGroup.add(fsm);
      index += 1;
    });
    FinancialGroupModel fsm = FinancialGroupModel(
        tlfinancial_group_id: '${runId}64',
        tlfinancial_type_id: 'typeId00',
        tlfinancial_type_name: 'ยอดนำส่ง(FIN)',
        tlfinancial_type_group: 'CheckByFIN',
        tlfinancial_type_number: '64',
        tlfinancial_group_sum: dGroupAllTotal.toStringAsFixed(2),
        tlfinancial_id: financialId,
        tldeposit_id: '');
    lFinGroup.add(fsm);

    final lFinLeftMenuByRec = lFinLeftMenu
        .where((element) => element.rec_by == finLeftMenuRecBy)
        .toList();
    for (var ee in lFinLeftMenuByRec) {
      FinancialGroupModel fsm = FinancialGroupModel(
          tlfinancial_group_id: '${runId}65',
          tlfinancial_type_id: 'typeId01',
          tlfinancial_type_name: 'ยอดนำส่ง(Imed)',
          tlfinancial_type_group: 'Imed',
          tlfinancial_type_number: '65',
          tlfinancial_group_sum:
              double.parse(ee.tlpayment_sum_paid_go).toStringAsFixed(2),
          tlfinancial_id: financialId,
          tldeposit_id: '');
      lFinGroup.add(fsm);
    }
  }

  //!---------ALL

  buildPaymentToFinancialDetailAll() {
    final lFinPaymentAndDetailAll = lFinPaymentAndDetail.toList();

    for (var i = 0; i < lFinPaymentAndDetailAll.length; i++) {
      String tlfinancial_detail_id =
          '${TlConstant.runID()}${i.toString().padLeft(2, '0')}';
      String tlfinancial_type_id = 'other';
      String tlfinancial_type_name = 'อื่นๆ';
      String tlfinancial_type_group = 'other';
      String tlfinancial_type_number = '63';

      final lFinType = lFinTypeAndCom
          .where((element) =>
              element.tlpayment_type_id ==
                  lFinPaymentAndDetailAll[i].tlpayment_type_id &&
              element.tlpayment_type ==
                  lFinPaymentAndDetailAll[i].tlpayment_type &&
              element.tlpayment_type_detail ==
                  lFinPaymentAndDetailAll[i].tlpayment_type_detail)
          .toList();

      if (lFinType.isNotEmpty) {
        tlfinancial_type_id = lFinType.first.tlfinancial_type_id;

        tlfinancial_type_name = lFinType.first.tlfinancial_type_name;

        tlfinancial_type_group = lFinType.first.tlfinancial_type_group;

        tlfinancial_type_number = lFinType.first.tlfinancial_type_number;
      }

      final checkFinDetail = lFinDetail
          .where((cFD) =>
              cFD.tlpayment_detail_id ==
              lFinPaymentAndDetailAll[i].tlpayment_detail_id)
          .toList();

      if (checkFinDetail.isEmpty) {
        FinancialDetailModel newFPay = FinancialDetailModel(
            tlfinancial_detail_id: tlfinancial_detail_id,
            tlpayment_detail_site_id:
                lFinPaymentAndDetailAll[i].tlpayment_detail_site_id,
            tlpayment_rec_by: lFinPaymentAndDetailAll[i].tlpayment_rec_by,
            tlpayment_rec_date: lFinPaymentAndDetailAll[i].tlpayment_rec_date,
            tlpayment_type_id: lFinPaymentAndDetailAll[i].tlpayment_type_id,
            tlpayment_type: lFinPaymentAndDetailAll[i].tlpayment_type,
            tlpayment_type_detail:
                lFinPaymentAndDetailAll[i].tlpayment_type_detail,
            tlpayment_detail_actual_paid:
                lFinPaymentAndDetailAll[i].tlpayment_detail_actual_paid,
            tlpayment_detail_id: lFinPaymentAndDetailAll[i].tlpayment_detail_id,
            tlpayment_id: lFinPaymentAndDetailAll[i].tlpayment_id,
            tlpayment_detail_paid: lFinPaymentAndDetailAll[i].paid,
            tlpayment_detail_paid_go: lFinPaymentAndDetailAll[i].paid_go,
            tlpayment_detail_diff_paid:
                lFinPaymentAndDetailAll[i].tlpayment_detail_diff_paid,
            tlpayment_detail_comment:
                lFinPaymentAndDetailAll[i].tlpayment_detail_comment,
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
            tlfinancial_type_number: tlfinancial_type_number,
            tlfinancial_detail_actual:
                lFinPaymentAndDetailAll[i].tlpayment_detail_actual_paid,
            tlfinancial_detail_comment: '',
            tlfinancial_detail_create_by: widget.lEmp.first.employee_id,
            tlfinancial_detail_create_date: '',
            tlfinancial_detail_create_time: '',
            tlfinancial_detail_modify_by: '',
            tlfinancial_detail_modify_date: '',
            tlfinancial_detail_modify_time: '',
            tlfinancial_id: financialId,
            tlfinancial_menu_id: finLeftMenuId);
        print('leftMenuIDALL : ${finLeftMenuId}');
        lFinDetail.add(newFPay);
        dTotalFinDetailActual += double.parse(
            lFinPaymentAndDetailAll[i].tlpayment_detail_actual_paid);
      }
    }
  }

  buildDepositToFinancialDetailAll() async {
    final lFinDepositAndDetailAll = lFinDepositAndDetail.toList();
    for (var finDep in lFinDepositAndDetailAll) {
      if (lFinDetail
          .where((element) =>
              element.tlpayment_detail_id == finDep.tlpayment_detail_id)
          .isNotEmpty) {
        lFinDetail
            .where((element) =>
                element.tlpayment_detail_id == finDep.tlpayment_detail_id)
            .first
            .tldeposit_id = finDep.tldeposit_id;

        lFinDetail
            .where((element) =>
                element.tlpayment_detail_id == finDep.tlpayment_detail_id)
            .first
            .tldeposit_create_by = finDep.tldeposit_create_by;

        lFinDetail
                .where((element) =>
                    element.tlpayment_detail_id == finDep.tlpayment_detail_id)
                .first
                .deposit_fullname =
            await employeeFullName(finDep.tldeposit_create_by);

        lFinDetail
            .where((element) =>
                element.tlpayment_detail_id == finDep.tlpayment_detail_id)
            .first
            .tldeposit_detail_id = finDep.tldeposit_detail_id;

        lFinDetail
            .where((element) =>
                element.tlpayment_detail_id == finDep.tlpayment_detail_id)
            .first
            .tldeposit_bank_account = finDep.tldeposit_bank_account;

        lFinDetail
            .where((element) =>
                element.tlpayment_detail_id == finDep.tlpayment_detail_id)
            .first
            .tldeposit_date = finDep.tldeposit_date;

        lFinDetail
            .where((element) =>
                element.tlpayment_detail_id == finDep.tlpayment_detail_id)
            .first
            .tldeposit_total = finDep.tldeposit_total;

        lFinDetail
            .where((element) =>
                element.tlpayment_detail_id == finDep.tlpayment_detail_id)
            .first
            .tldeposit_total_actual = finDep.tldeposit_total_actual;

        lFinDetail
            .where((element) =>
                element.tlpayment_detail_id == finDep.tlpayment_detail_id)
            .first
            .tldeposit_total_balance = finDep.tldeposit_total_balance;

        lFinDetail
            .where((element) =>
                element.tlpayment_detail_id == finDep.tlpayment_detail_id)
            .first
            .tldeposit_comment = finDep.tldeposit_comment;
      }
    }
  }

  //!---------ByEmp
  buildPaymentToFinancialDetail(String finLeftMenuRecBy) {
    final lFinPaymentAndDetailByEmp = lFinPaymentAndDetail
        .where((element) => element.tlpayment_rec_by == finLeftMenuRecBy)
        .toList();
    for (var i = 0; i < lFinPaymentAndDetailByEmp.length; i++) {
      String tlfinancial_detail_id =
          '${TlConstant.runID()}${i.toString().padLeft(2, '0')}';
      String tlfinancial_type_id = 'other';
      String tlfinancial_type_name = 'อื่นๆ';
      String tlfinancial_type_group = 'other';
      String tlfinancial_type_number = '63';

      final lFinType = lFinTypeAndCom
          .where((element) =>
              element.tlpayment_type_id ==
                  lFinPaymentAndDetailByEmp[i].tlpayment_type_id &&
              element.tlpayment_type ==
                  lFinPaymentAndDetailByEmp[i].tlpayment_type &&
              element.tlpayment_type_detail ==
                  lFinPaymentAndDetailByEmp[i].tlpayment_type_detail)
          .toList();

      if (lFinType.isNotEmpty) {
        tlfinancial_type_id = lFinType.first.tlfinancial_type_id;

        tlfinancial_type_name = lFinType.first.tlfinancial_type_name;

        tlfinancial_type_group = lFinType.first.tlfinancial_type_group;

        tlfinancial_type_number = lFinType.first.tlfinancial_type_number;
      }

      final checkFinDetail = lFinDetail
          .where((cFD) =>
              cFD.tlpayment_detail_id ==
              lFinPaymentAndDetailByEmp[i].tlpayment_detail_id)
          .toList();

      if (checkFinDetail.isEmpty) {
        FinancialDetailModel newFPay = FinancialDetailModel(
            tlfinancial_detail_id: tlfinancial_detail_id,
            tlpayment_detail_site_id:
                lFinPaymentAndDetailByEmp[i].tlpayment_detail_site_id,
            tlpayment_rec_by: lFinPaymentAndDetailByEmp[i].tlpayment_rec_by,
            tlpayment_rec_date: lFinPaymentAndDetailByEmp[i].tlpayment_rec_date,
            tlpayment_type_id: lFinPaymentAndDetailByEmp[i].tlpayment_type_id,
            tlpayment_type: lFinPaymentAndDetailByEmp[i].tlpayment_type,
            tlpayment_type_detail:
                lFinPaymentAndDetailByEmp[i].tlpayment_type_detail,
            tlpayment_detail_actual_paid:
                lFinPaymentAndDetailByEmp[i].tlpayment_detail_actual_paid,
            tlpayment_detail_id:
                lFinPaymentAndDetailByEmp[i].tlpayment_detail_id,
            tlpayment_id: lFinPaymentAndDetailByEmp[i].tlpayment_id,
            tlpayment_detail_paid: lFinPaymentAndDetailByEmp[i].paid,
            tlpayment_detail_paid_go: lFinPaymentAndDetailByEmp[i].paid_go,
            tlpayment_detail_diff_paid:
                lFinPaymentAndDetailByEmp[i].tlpayment_detail_diff_paid,
            tlpayment_detail_comment:
                lFinPaymentAndDetailByEmp[i].tlpayment_detail_comment,
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
            tlfinancial_type_number: tlfinancial_type_number,
            tlfinancial_detail_actual:
                lFinPaymentAndDetailByEmp[i].tlpayment_detail_actual_paid,
            tlfinancial_detail_comment: '',
            tlfinancial_detail_create_by: widget.lEmp.first.employee_id,
            tlfinancial_detail_create_date: '',
            tlfinancial_detail_create_time: '',
            tlfinancial_detail_modify_by: '',
            tlfinancial_detail_modify_date: '',
            tlfinancial_detail_modify_time: '',
            tlfinancial_id: financialId,
            tlfinancial_menu_id: finLeftMenuId);
        print('leftMenuIDByuser :${finLeftMenuRecBy} ${finLeftMenuId}');
        lFinDetail.add(newFPay);
        dTotalFinDetailActual += double.parse(
            lFinPaymentAndDetailByEmp[i].tlpayment_detail_actual_paid);
      }
    }
  }

  buildDepositToFinancialDetail(String finLeftMenuRecBy) async {
    final lFinDepositAndDetailByEmp = lFinDepositAndDetail
        .where((element) => element.tlpayment_rec_by == finLeftMenuRecBy)
        .toList();
    for (var finDep in lFinDepositAndDetailByEmp) {
      if (lFinDetail
          .where((element) =>
              element.tlpayment_detail_id == finDep.tlpayment_detail_id)
          .isNotEmpty) {
        lFinDetail
            .where((element) =>
                element.tlpayment_detail_id == finDep.tlpayment_detail_id)
            .first
            .tldeposit_id = finDep.tldeposit_id;

        lFinDetail
            .where((element) =>
                element.tlpayment_detail_id == finDep.tlpayment_detail_id)
            .first
            .tldeposit_create_by = finDep.tldeposit_create_by;

        lFinDetail
                .where((element) =>
                    element.tlpayment_detail_id == finDep.tlpayment_detail_id)
                .first
                .deposit_fullname =
            await employeeFullName(finDep.tldeposit_create_by);

        lFinDetail
            .where((element) =>
                element.tlpayment_detail_id == finDep.tlpayment_detail_id)
            .first
            .tldeposit_detail_id = finDep.tldeposit_detail_id;

        lFinDetail
            .where((element) =>
                element.tlpayment_detail_id == finDep.tlpayment_detail_id)
            .first
            .tldeposit_bank_account = finDep.tldeposit_bank_account;

        lFinDetail
            .where((element) =>
                element.tlpayment_detail_id == finDep.tlpayment_detail_id)
            .first
            .tldeposit_date = finDep.tldeposit_date;

        lFinDetail
            .where((element) =>
                element.tlpayment_detail_id == finDep.tlpayment_detail_id)
            .first
            .tldeposit_total = finDep.tldeposit_total;

        lFinDetail
            .where((element) =>
                element.tlpayment_detail_id == finDep.tlpayment_detail_id)
            .first
            .tldeposit_total_actual = finDep.tldeposit_total_actual;

        lFinDetail
            .where((element) =>
                element.tlpayment_detail_id == finDep.tlpayment_detail_id)
            .first
            .tldeposit_total_balance = finDep.tldeposit_total_balance;

        lFinDetail
            .where((element) =>
                element.tlpayment_detail_id == finDep.tlpayment_detail_id)
            .first
            .tldeposit_comment = finDep.tldeposit_comment;
      }
    }
  }

  void _onSelectionRec(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is DateTime) {
        selectRecDate = DateFormat('yyyy-MM-dd').format(args.value);
      }
      Navigator.pop(context);
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

  Future loadPaymentMasterBuildFinMenu(
      String siteDDValue, String dateRec) async {
    lPaymentMaster = [];
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "site_id": siteDDValue,
      "date_receipt": dateRec
    });
    String api = '${TlConstant.syncApi}tlPayment.php?id=checkPaymentConfirm';
    await Dio().post(api, data: formData).then((value) async {
      if (value.data == null) {
        print('NoData');
      } else {
        PaymentEmpFullNameModel newPaymentALL = PaymentEmpFullNameModel(
            tlpayment_id: '',
            tlpayment_imed_total: '',
            tlpayment_actual_total: '',
            tlpayment_diff_abs: '',
            tlpayment_rec_date: '',
            tlpayment_rec_time_from: '',
            tlpayment_rec_time_to: '',
            tlpayment_rec_site: '',
            tlpayment_rec_by: 'ALL',
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
        lPaymentMaster
            .sort((a, b) => a.tlpayment_rec_by.compareTo(b.tlpayment_rec_by));
        double dPMSumIncomeAll = 0.0;
        double dPMSumPaidGoAll = 0.0;
        double dPMSumActualAll = 0.0;
        var gPMRecBy = groupBy(
          lPaymentMaster,
          (gKey) => gKey.tlpayment_rec_by,
        );

        gPMRecBy.forEach((key, value) {
          if (key == 'ALL') {
          } else {
            var recById = key;
            var recFullName = value.first.emp_fullname;
            double dPMSumIncome = 0.0;
            double dPMSumPaidGo = 0.0;

            double dPMSumActual = 0.0;
            String paymentId = '';
            for (var ee in value) {
              paymentId += '${ee.tlpayment_id},';

              dPMSumIncome += double.parse(ee.tlpayment_imed_total_income);
              dPMSumPaidGo += double.parse(ee.tlpayment_imed_total);
              dPMSumActual += double.parse(ee.tlpayment_actual_total);
            }
            paymentId = paymentId.substring(0, paymentId.length - 1);
            dPMSumIncomeAll += dPMSumIncome; //รายได้ปิดผลัด
            dPMSumPaidGoAll += dPMSumPaidGo; // ยอดส่ง
            dPMSumActualAll += dPMSumActual; // ส่งจริง
            double dSumPaidImed = 0.0;

            final lCheckFinLeftMenu =
                lFinLeftMenu.where((ee) => ee.rec_by == recById).toList();
            if (lCheckFinLeftMenu.isEmpty) {
              FinancialMenuModel newEmp = FinancialMenuModel(
                  tlfinancial_menu_id:
                      '${TlConstant.runID()}${lFinLeftMenu.length.toString().padLeft(4, '0')}',
                  tlfinancial_id: financialId,
                  rec_by: recById,
                  rec_date: value.first.tlpayment_rec_date,
                  rec_site: value.first.tlpayment_rec_site,
                  rec_sum_paid_imed: '0.0',
                  tlpayment_fullname: recFullName,
                  tlpayment_sum_paid: dPMSumIncome.toStringAsFixed(2),
                  tlpayment_sum_paid_go: dPMSumPaidGo.toStringAsFixed(2),
                  tlpayment_sum_actual: dPMSumActual.toStringAsFixed(2),
                  tlpayment_id: paymentId,
                  tlfinancial_menu_diffimedpaid:
                      dPMSumActual.toStringAsFixed(2),
                  tlfinancial_menu_status: 'create');

              lFinLeftMenu.add(newEmp);
            }

            dSumPaidImed = double.parse(lFinLeftMenu
                .where((ee) => ee.rec_by == recById)
                .first
                .rec_sum_paid_imed);

            double dDiff = dPMSumIncome - dSumPaidImed;
            // ชื่อพนักงาน
            lFinLeftMenu
                .where((ee) => ee.rec_by == recById)
                .first
                .tlpayment_fullname = recFullName;
            //ยอดรายขายรวม
            lFinLeftMenu
                .where((ee) => ee.rec_by == recById)
                .first
                .tlpayment_sum_paid = dPMSumIncome.toStringAsFixed(2);

            // ยอดนำส่ง
            lFinLeftMenu
                .where((ee) => ee.rec_by == recById)
                .first
                .tlpayment_sum_paid_go = dPMSumPaidGo.toStringAsFixed(2);

            //นำส่งจริง
            lFinLeftMenu
                .where((ee) => ee.rec_by == recById)
                .first
                .tlpayment_sum_actual = dPMSumActual.toStringAsFixed(2);
            //
            lFinLeftMenu
                .where((ee) => ee.rec_by == recById)
                .first
                .tlpayment_id = paymentId;
            lFinLeftMenu
                .where((ee) => ee.rec_by == recById)
                .first
                .tlfinancial_menu_diffimedpaid = dDiff.toStringAsFixed(2);
            lFinLeftMenu
                .where((ee) => ee.rec_by == recById)
                .first
                .tlfinancial_menu_status = 'create';
          }
        });
        lFinLeftMenu
            .where((ee) => ee.rec_by == 'ALL')
            .first
            .tlpayment_sum_paid = dPMSumIncomeAll.toStringAsFixed(2);

        lFinLeftMenu
            .where((ee) => ee.rec_by == 'ALL')
            .first
            .tlpayment_sum_paid_go = dPMSumPaidGoAll.toStringAsFixed(2);

        lFinLeftMenu
            .where((ee) => ee.rec_by == 'ALL')
            .first
            .tlpayment_sum_actual = dPMSumActualAll.toStringAsFixed(2);

        double dSumPaidAllimed = double.parse(lFinLeftMenu
            .where((ee) => ee.rec_by == 'ALL')
            .first
            .rec_sum_paid_imed);

        double dSumDiffAll = dPMSumIncomeAll - dSumPaidAllimed;

        lFinLeftMenu
            .where((ee) => ee.rec_by == 'ALL')
            .first
            .tlfinancial_menu_diffimedpaid = dSumDiffAll.toStringAsFixed(2);
      }
    });
  }

  Future loadPaymentMasterBuildImage(String siteDDValue, String dateRec) async {
    lPaymentMaster = [];
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "site_id": siteDDValue,
      "date_receipt": dateRec
    });
    String api = '${TlConstant.syncApi}tlPayment.php?id=checkPaymentConfirm';
    await Dio().post(api, data: formData).then((value) async {
      if (value.data == null) {
        print('NoData');
      } else {
        PaymentEmpFullNameModel newPaymentALL = PaymentEmpFullNameModel(
            tlpayment_id: '',
            tlpayment_imed_total: '',
            tlpayment_actual_total: '',
            tlpayment_diff_abs: '',
            tlpayment_rec_date: '',
            tlpayment_rec_time_from: '',
            tlpayment_rec_time_to: '',
            tlpayment_rec_site: '',
            tlpayment_rec_by: 'ALL',
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
      }
    });
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

  Future loadPaymentDetailAll(String siteDDValue, String dateRec) async {
    lFinPaymentAndDetail = [];
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "site_id": siteDDValue,
      "rec_date": dateRec
    });
    String api =
        '${TlConstant.syncApi}tlPaymentDetail.php?id=loadPaymentAndDetail';

    await Dio().post(api, data: formData).then((value) {
      if (value.data == null) {
        print('PaymentDetail Null !');
      } else {
        for (var dPayMD in value.data) {
          FinancialPaymentAndDetailModel newPMD =
              FinancialPaymentAndDetailModel.fromMap(dPayMD);
          lFinPaymentAndDetail.add(newPMD);
        }
      }
    });
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
        lRecReview.sort((a, b) => a.rec_by.compareTo(b.rec_by));

        var financialMenuId = TlConstant.runID();
        FinancialMenuModel newFLMALL = FinancialMenuModel(
          tlfinancial_menu_id: '${financialMenuId}000',
          tlfinancial_id: financialId,
          rec_by: 'ALL',
          rec_date: date,
          rec_site: site,
          rec_sum_paid_imed: '0.0',
          tlpayment_fullname: 'รวมทั้งหมด',
          tlpayment_sum_paid: '0.0',
          tlpayment_sum_paid_go: '0.0',
          tlpayment_sum_actual: '0.0',
          tlpayment_id: '',
          tlfinancial_menu_diffimedpaid: '0.0',
          tlfinancial_menu_status: 'ALL',
        );
        lFinLeftMenu.add(newFLMALL);
        finLeftMenuId = newFLMALL.tlfinancial_menu_id;
        double dSumPaidAll = 0.0;
        var gRecBy = groupBy(
          lRecReview,
          (gKey) => gKey.rec_by,
        );
        int idexx = 0;
        gRecBy.forEach((key, value) {
          var recById = key;
          idexx += 1;
          double dSumPaid = 0.0;
          for (var ee in value) {
            dSumPaid += double.parse(ee.paid);
          }
          dSumPaidAll += dSumPaid;
          FinancialMenuModel newFLM = FinancialMenuModel(
            tlfinancial_menu_id:
                '${financialMenuId}${idexx.toString().padLeft(3, '0')}',
            tlfinancial_id: financialId,
            rec_by: recById,
            rec_date: date,
            rec_site: site,
            rec_sum_paid_imed: dSumPaid.toStringAsFixed(2),
            tlpayment_fullname: '${recById}\n(ไม่มีการปิดผลัด)',
            tlpayment_sum_paid: '0.0',
            tlpayment_sum_paid_go: '0.0',
            tlpayment_sum_actual: '0.0',
            tlpayment_id: '',
            tlfinancial_menu_diffimedpaid: (dSumPaid * -1).toStringAsFixed(2),
            tlfinancial_menu_status: 'nodata',
          );
          lFinLeftMenu.add(newFLM);
        });
        lFinLeftMenu.where((em) => em.rec_by == 'ALL').first.rec_sum_paid_imed =
            dSumPaidAll.toStringAsFixed(2);
        lFinLeftMenu
                .where((em) => em.rec_by == 'ALL')
                .first
                .tlfinancial_menu_diffimedpaid =
            (dSumPaidAll * -1).toStringAsFixed(2);
      }
    });
  }

  Future loadDepositAndDetail(String siteDDValue, String date) async {
    lFinDepositAndDetail = [];
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "site_id": siteDDValue,
      "rec_date": date,
    });
    String api = '${TlConstant.syncApi}tlDeposit.php?id=loadDepositAndDetail';

    await Dio().post(api, data: formData).then((value) {
      if (value.data == null) {
        print('NoData');
      } else {
        for (var dataDandD in value.data) {
          FinancialDepositAndDetailModel newDandD =
              FinancialDepositAndDetailModel.fromMap(dataDandD);
          lFinDepositAndDetail.add(newDandD);
        }
      }
    });
  }

  Future loadDepositImageDB() async {
    lDepositImage = [];
    lDepositImageDB = [];
    final gDeposit = groupBy(
      lFinDepositAndDetail,
      (gKey) => gKey.tldeposit_id,
    );
    for (var key in gDeposit.keys) {
      FormData formData =
          FormData.fromMap({"token": TlConstant.token, "tldeposit_id": key});
      String api = '${TlConstant.syncApi}tlDepositImage.php?id=deposit';

      await Dio().post(api, data: formData).then((value) {
        if (value.data == null) {
          print('PaymentDetailImage Null !');
        } else {
          for (var pdImage in value.data) {
            DepositImageModel newPDImage = DepositImageModel.fromMap(pdImage);
            lDepositImageDB.add(newPDImage);
          }
        }
      });
    }
    await loadDepositImage();
  }

  loadDepositImage() {
    for (var img in lDepositImageDB) {
      DepositImageTempModel imgTemp = DepositImageTempModel(
          tldeposit_image_id: img.tldeposit_image_id,
          tldeposit_image_base64: '',
          tldeposit_image_lastName: '',
          tldeposit_image_description: img.tldeposit_image_description,
          tldeposit_id: img.tldeposit_id);
      lDepositImage.add(imgTemp);
    }
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

  Future loadFinTypeAndCom() async {
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
    });
    String api = '${TlConstant.syncApi}tlFinancialType.php?id=loadTypeAndCom';
    lFinTypeAndCom = [];
    await Dio().post(api, data: formData).then((value) {
      if (value.data == null) {
        print('Site Null !');
      } else {
        for (var dataFin in value.data) {
          FinancialTypeAndComModel newFinTypeAndCom =
              FinancialTypeAndComModel.fromMap(dataFin);
          lFinTypeAndCom.add(newFinTypeAndCom);
        }
      }
    });
    setState(() {});
  }

  Future loadFinType() async {
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
    });
    String api = '${TlConstant.syncApi}tlFinancialType.php?id=1';
    lFinType = [];
    await Dio().post(api, data: formData).then((value) {
      if (value.data == null) {
        print('Site Null !');
      } else {
        for (var dataFin in value.data) {
          FinancialTypeModel newFinTypeAndCom =
              FinancialTypeModel.fromMap(dataFin);
          lFinType.add(newFinTypeAndCom);
        }
      }
    });
    setState(() {});
  }

  groupFinancialDetail(List<FinancialDetailModel> lFinDetail) {
    return groupBy(lFinDetail, (gKey) {
      var typeId = '${gKey.tlfinancial_type_id}';
      return typeId;
    });
    //=> gKey.emp_fullname);
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
          }
        });
      }
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

  Future loadPaymentDetailRemarkAll() async {
    lPaymentRemark = [];

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
          }
        });
      }
    }
  }

  loadFin(String recSite, String recDate) async {
    FormData formData = FormData.fromMap(
        {"token": TlConstant.token, "1": recSite, "2": recDate});
    String api = '${TlConstant.syncApi}tlFinancial.php?id=load';

    await Dio().post(api, data: formData).then((value) {
      if (value.data == null) {
        print('Financial Null !');
      } else {
        for (var fin in value.data) {
          FinancialModel newF = FinancialModel.fromMap(fin);
          lFin.add(newF);
        }
      }
      setState(() {});
    });
  }

  Future loadFinMenu(String siteDDValue, String dateRec) async {
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "rec_site": siteDDValue,
      "rec_date": dateRec
    });
    String api = '${TlConstant.syncApi}tlFinancialMenu.php?id=load';

    await Dio().post(api, data: formData).then((value) {
      if (value.data == null) {
        print('PaymentDetail Null !');
      } else {
        var financialMenuId = TlConstant.runID();
        FinancialMenuModel newFLMALL = FinancialMenuModel(
          tlfinancial_menu_id: '${financialMenuId}000',
          tlfinancial_id: financialId,
          rec_by: 'ALL',
          rec_date: dateRec,
          rec_site: siteDDValue,
          rec_sum_paid_imed: '0.0',
          tlpayment_fullname: 'รวมทั้งหมด',
          tlpayment_sum_paid: '0.0',
          tlpayment_sum_paid_go: '0.0',
          tlpayment_sum_actual: '0.0',
          tlpayment_id: '',
          tlfinancial_menu_diffimedpaid: '0.0',
          tlfinancial_menu_status: 'ALL',
        );
        lFinLeftMenu.add(newFLMALL);
        finLeftMenuId = newFLMALL.tlfinancial_menu_id;
        double dSumPaidImedAll = 0;
        double dSumPaidAll = 0;
        double dSumPaidGoAll = 0;
        double dSumActualAll = 0;
        double dSumDiffImedPaidAll = 0;
        for (var finLeftMenu in value.data) {
          FinancialMenuModel newFLM = FinancialMenuModel.fromMap(finLeftMenu);
          lFinLeftMenu.add(newFLM);
          dSumPaidImedAll += double.parse(newFLM.rec_sum_paid_imed);
          dSumPaidAll += double.parse(newFLM.tlpayment_sum_paid);
          dSumPaidGoAll += double.parse(newFLM.tlpayment_sum_paid_go);
          dSumActualAll += double.parse(newFLM.tlpayment_sum_actual);
          dSumDiffImedPaidAll +=
              double.parse(newFLM.tlfinancial_menu_diffimedpaid);
        }
        lFinLeftMenu.where((em) => em.rec_by == 'ALL').first.rec_sum_paid_imed =
            dSumPaidImedAll.toStringAsFixed(2);

        lFinLeftMenu
            .where((em) => em.rec_by == 'ALL')
            .first
            .tlpayment_sum_paid = dSumPaidAll.toStringAsFixed(2);

        lFinLeftMenu
            .where((em) => em.rec_by == 'ALL')
            .first
            .tlpayment_sum_paid_go = dSumPaidGoAll.toStringAsFixed(2);

        lFinLeftMenu
            .where((em) => em.rec_by == 'ALL')
            .first
            .tlpayment_sum_actual = dSumActualAll.toStringAsFixed(2);

        lFinLeftMenu
                .where((em) => em.rec_by == 'ALL')
                .first
                .tlfinancial_menu_diffimedpaid =
            dSumDiffImedPaidAll.toStringAsFixed(2);
      }
    });
  }

  Future<bool> loadIsCheckFinDetailById(String tlfinancial_detail_id) async {
    // ใช้ในการCheckว่ามีข้อมูล ใน db Table FinDetail หรือยัง
    bool isCheck = false;
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      '1': tlfinancial_detail_id,
    });
    String api = '${TlConstant.syncApi}tlFinancialDetail.php?id=loadId';
    await Dio().post(api, data: formData).then((value) {
      if (value.data == null) {
      } else {
        isCheck = true;
      }
    });
    return isCheck;
  }

  loadFinDetailByFinId(String financialId) async {
    lFinDetail = [];
    // dTotalFinDetailActual = 0.0;
    FormData formData =
        FormData.fromMap({"token": TlConstant.token, "1": financialId});
    String api = '${TlConstant.syncApi}tlFinancialDetail.php?id=loadFin';
    await Dio().post(api, data: formData).then((value) {
      if (value.data == null) {
        print('FinDetail Null !');
      } else {
        for (var fd in value.data) {
          FinancialDetailModel newFD = FinancialDetailModel.fromMap(fd);
          lFinDetail.add(newFD);
          dTotalFinDetailActual +=
              double.parse(newFD.tlfinancial_detail_actual);
        }
      }
    });
  }

  loadFinDetailByFinMenu() async {
    // lFinDetail = [];
    // dTotalFinDetailActual = 0.0;
    FormData formData =
        FormData.fromMap({"token": TlConstant.token, "1": finLeftMenuId});
    String api = '${TlConstant.syncApi}tlFinancialDetail.php?id=loadFinMenu';
    await Dio().post(api, data: formData).then((value) {
      if (value.data == null) {
        print('FinDetail Null !');
      } else {
        for (var fd in value.data) {
          FinancialDetailModel newFD = FinancialDetailModel.fromMap(fd);
          lFinDetail.add(newFD);
          dTotalFinDetailActual +=
              double.parse(newFD.tlfinancial_detail_actual);
        }
      }
    });
  }

  //!-------------Create
  Future createFinancialMenu() async {
    for (var cr in lFinLeftMenu) {
      if (cr.rec_by != 'ALL') {
        FormData formData = FormData.fromMap({
          "token": TlConstant.token,
          "1": cr.tlfinancial_menu_id,
          "2": cr.tlfinancial_id,
          "3": cr.rec_by,
          "4": cr.rec_date,
          "5": cr.rec_site,
          "6": cr.rec_sum_paid_imed,
          "7": cr.tlpayment_fullname,
          "8": cr.tlpayment_sum_paid,
          "9": cr.tlpayment_sum_paid_go,
          "10": cr.tlpayment_sum_actual,
          "11": cr.tlpayment_id,
          "12": cr.tlfinancial_menu_diffimedpaid,
          "13": cr.tlfinancial_menu_status
        });
        String api = '${TlConstant.syncApi}tlFinancialMenu.php?id=create';

        await Dio().post(api, data: formData);
      }
    }
  }

  Future createFinDetail(FinancialDetailModel ee) async {
    final dateNow = DateTime.now();
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      '1': ee.tlfinancial_detail_id,
      '2': ee.tlpayment_detail_site_id,
      '3': ee.tlpayment_rec_by,
      '4': ee.tlpayment_rec_date,
      '5': ee.tlpayment_type_id,
      '6': ee.tlpayment_type,
      '7': ee.tlpayment_type_detail,
      '8': ee.tlpayment_detail_actual_paid,
      '9': ee.tlpayment_detail_id,
      '10': ee.tlpayment_id,
      '11': ee.tlpayment_detail_paid,
      '12': ee.tlpayment_detail_paid_go,
      '13': ee.tlpayment_detail_diff_paid,
      '14': ee.tlpayment_detail_comment,
      '15': ee.tldeposit_id,
      '16': ee.tldeposit_create_by,
      '17': ee.deposit_fullname,
      '18': ee.tldeposit_detail_id,
      '19': ee.tldeposit_bank_account,
      '20': ee.tldeposit_date,
      '21': ee.tldeposit_total,
      '22': ee.tldeposit_total_actual,
      '23': ee.tldeposit_total_balance,
      '24': ee.tldeposit_comment,
      '25': ee.tlfinancial_type_id,
      '26': ee.tlfinancial_type_name,
      '27': ee.tlfinancial_type_group,
      '28': ee.tlfinancial_type_number,
      '29': ee.tlfinancial_detail_actual,
      '30': ee.tlfinancial_detail_comment,
      '31': ee.tlfinancial_detail_create_by,
      '32': DateFormat('yyyy-MM-dd').format(dateNow),
      '33': DateFormat('HH:mm:ss').format(dateNow),
      '34': ee.tlfinancial_detail_modify_by,
      '35': ee.tlfinancial_detail_modify_date,
      '36': ee.tlfinancial_detail_modify_time,
      '37': ee.tlfinancial_id,
      '38': ee.tlfinancial_menu_id
    });
    String api = '${TlConstant.syncApi}tlFinancialDetail.php?id=create';

    await Dio().post(api, data: formData);
  }

  Future createFinancial(FinancialModel fin) async {
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      '1': fin.tlfinancial_id,
      '2': fin.tlfinancial_rec_date,
      '3': fin.tlfinancial_rec_site,
      '4': fin.tlfinancial_create_by,
      '5': fin.tlfinancial_create_date,
      '6': fin.tlfinancial_create_time,
      '7': fin.tlfin_imed_paid,
      '8': fin.tlfin_payment_paid,
      '9': fin.tlfin_payment_paid_go,
      '10': fin.tlfin_payment_paid_actual,
      '11': fin.tlfinancial_actual,
      '12': fin.tlfinancial_diff,
      '13': fin.tlfinancial_status,
      '14': fin.tlfinancial_comment,
      '15': fin.tlfinancial_modify_by,
      '16': fin.tlfinancial_modify_date,
      '17': fin.tlfinancial_modify_time
    });
    String api = '${TlConstant.syncApi}tlFinancial.php?id=create';

    await Dio().post(api, data: formData);
  }

  Future createFinancialGroup(FinancialGroupModel fg) async {
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      '1': fg.tlfinancial_group_id,
      '2': fg.tlfinancial_type_id,
      '3': fg.tlfinancial_type_name,
      '4': fg.tlfinancial_type_group,
      '5': fg.tlfinancial_type_number,
      '6': fg.tlfinancial_group_sum,
      '7': fg.tlfinancial_id,
      '8': fg.tldeposit_id
    });
    String api = '${TlConstant.syncApi}tlFinancialGroup.php?id=create';

    await Dio().post(api, data: formData);
  }

  //!-------------Update

  Future updateFinMenuStatus(String finMenuId, String status) async {
    FormData formData = FormData.fromMap(
        {"token": TlConstant.token, '1': finMenuId, '2': status});
    String api = '${TlConstant.syncApi}tlFinancialMenu.php?id=uStatus';

    await Dio().post(api, data: formData);
  }

  updateFinDetailByID(FinancialDetailModel ee) async {
    final dateNow = DateTime.now();
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      '1': ee.tlfinancial_detail_id,
      '2': widget.lEmp.first.employee_id,
      '3': DateFormat('yyyy-MM-dd').format(dateNow),
      '4': DateFormat('HH:mm:ss').format(dateNow),
      '5': ee.tlfinancial_type_id,
      '6': ee.tlfinancial_type_name,
      '7': ee.tlfinancial_type_group,
      '8': ee.tlfinancial_type_number,
      '9': ee.tlfinancial_detail_actual,
      '10': ee.tlfinancial_detail_comment
    });
    String api = '${TlConstant.syncApi}tlFinancialDetail.php?id=uId';

    await Dio().post(api, data: formData);
  }

  updateFinMenuDetail(FinancialMenuModel mFinMenu) async {
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      '1': mFinMenu.tlfinancial_menu_id,
      '2': mFinMenu.tlfinancial_menu_diffimedpaid,
      '3': mFinMenu.tlpayment_sum_paid,
      '4': mFinMenu.tlpayment_sum_paid_go,
      '5': mFinMenu.tlpayment_sum_actual
    });
    String api = '${TlConstant.syncApi}tlFinancialMenu.php?id=uDetail';
    await Dio().post(api, data: formData);
  }
}
