// ignore_for_file: must_be_immutable, unused_field, use_build_context_synchronously

import 'package:action_slider/action_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:badges/badges.dart' as badges;
import 'package:thonglor_e_smart_cashier_web/models/bank_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/depositImageTemp_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/depositImage_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/paymentMDAndDepositMDAndFullName_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/paymentDetail_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/payment_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/receipt_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/site_model.dart';
import 'package:thonglor_e_smart_cashier_web/screens/deposit_image_screen.dart';

import 'package:thonglor_e_smart_cashier_web/util/constant.dart';
import 'package:collection/collection.dart';

import '../models/deposit_model.dart';
import '../models/employee_model.dart';
import '../models/paymentMDAndDepositMD_model.dart';

class DepositScreen extends StatefulWidget {
  List<EmployeeModel> lEmp;
  DepositScreen({required this.lEmp, super.key});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

//emp nipaporn  0635644228 2023-11-15  two Site (หลี)
//emp arunrat_b 2023-06-01 one Site
class _DepositScreenState extends State<DepositScreen> {
  List<DepositImageTempModel> lDepositImage = [];
  List<DepositImageModel> lDepositImageDB = [];
  List<SiteModel> lSite = [];
  List<String> lSiteId = []; //['All Site'];
  String siteDDValue = 'R9';
  String siteToAddPaymentType = '';
  List<String> lPaymentName = [];
  String dateRec = '';
  String depositId = '';

  String selectDateFrom =
      '2023-11-15'; //DateFormat('yyyy-MM-dd').format(DateTime.now());
  String selectDateTo =
      '2023-11-15'; //DateFormat('yyyy-MM-dd').format(DateTime.now());
  String selectedDate =
      ''; //'${DateFormat('yyyy-MM-dd').format(DateTime.now())} - ${DateFormat('yyyy-MM-dd').format(DateTime.now())}';

  String depositDate = '';

  bool isCheckRun = false;
  bool isCheckClickOii = false;
  bool isHover = false;
  bool isNew = false;

  String checkTypeDate = '';

  List<ReceiptModel> lReceiptImed = [];
  List<TextEditingController> lActualControllers = [];
  List<double> lBalance = [];
  bool isHoverImage = false;
  bool isEditImage = false;
  String runProcess = 'start';
  final oCcy = NumberFormat(
    "#,##0.00",
  );
  double dTotalPaid = 0;
  double dTotalActual = 0;
  double dTotalBalance = 0;
  double dTotalDeposit = 0;
  List<PaymentDetailModel> lPaymentDetail = [];
  List<PaymentModel> lPayment = [];

  List<PaymentMDAndDepositMDAndFullNameModel>
      lPaymentMDAndDepositMDAndFullName = [];
  List<EmployeeModel> lEmployeeDeposit = [];
  String isStatusScreen = '';
  TextEditingController depositCommentController = TextEditingController();
  TextEditingController depositActualController = TextEditingController();
  TextEditingController depositBankAccountController = TextEditingController();

  var groupName;

  String siteRec = '';

  List<DepositModel> lDepositChoice = [];

  List<String> lBankNumber = [];
  List<BankModel> lBank = [];
  String bankNumber = '';

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    // '2023-11-07'; //DateFormat('yyyy-MM-dd').format(DateTime.now());
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
                              child: Text(' เลือก วันที่ และ สาขา '),
                            ),
                          )
                        : SizedBox(
                            child: Row(children: [
                              Expanded(
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
                                                            BorderRadius
                                                                .circular(16)),
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 8),
                                                          child: lPaymentMDAndDepositMDAndFullName
                                                                  .isEmpty
                                                              ? const SizedBox(
                                                                  height: 40,
                                                                  child: Center(
                                                                    child: Text(
                                                                        'No Data'),
                                                                  ),
                                                                )
                                                              : SizedBox(
                                                                  height: MediaQuery.of(context)
                                                                          .size
                                                                          .height /
                                                                      2,
                                                                  child: ListView
                                                                      .builder(
                                                                          itemCount: groupName
                                                                              .length,
                                                                          itemBuilder:
                                                                              (context, index) {
                                                                            String
                                                                                fullName =
                                                                                groupName.keys.elementAt(index);
                                                                            List<PaymentMDAndDepositMDAndFullNameModel>
                                                                                data =
                                                                                groupName.values.elementAt(index);
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
                                                                                    physics: const ClampingScrollPhysics(),
                                                                                    itemCount: data.length,
                                                                                    itemBuilder: (context, index) {
                                                                                      PaymentMDAndDepositMDAndFullNameModel mPayment = data[index];
                                                                                      return Row(
                                                                                        children: [
                                                                                          SizedBox(
                                                                                            height: 40,
                                                                                            width: 60,
                                                                                            child: Align(
                                                                                                alignment: Alignment.center,
                                                                                                child: Checkbox(
                                                                                                    activeColor: mPayment.tldeposit_detail_id.isNotEmpty ? Colors.grey : null,
                                                                                                    value: mPayment.ischeck == 'inactive' ? false : true,
                                                                                                    onChanged: (value) {
                                                                                                      if (mPayment.tldeposit_detail_id.isEmpty) {
                                                                                                        if (value == true) {
                                                                                                          mPayment.ischeck = 'active';
                                                                                                          dTotalDeposit += double.parse(mPayment.tlpayment_detail_actual_paid);
                                                                                                        } else {
                                                                                                          mPayment.ischeck = 'inactive';
                                                                                                          dTotalDeposit -= double.parse(mPayment.tlpayment_detail_actual_paid);
                                                                                                        }
                                                                                                        setState(() {
                                                                                                          depositActualController.text = dTotalDeposit.toStringAsFixed(2);
                                                                                                        });
                                                                                                      }
                                                                                                    })),
                                                                                          ),
                                                                                          SizedBox(child: Text('${mPayment.tlpayment_type} (${mPayment.tlpayment_type_detail})', style: const TextStyle(fontSize: 14))),
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.only(left: 20),
                                                                                            child: SizedBox(child: mPayment.tldeposit_detail_id.isNotEmpty ? Text(' นำฝากโดย :: ${mPayment.tldeposit_create_by_fullname}', style: const TextStyle(fontSize: 12)) : null),
                                                                                          ),
                                                                                          Expanded(child: SizedBox()),
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                                                                            child: SizedBox(child: Text(oCcy.format(double.parse(mPayment.tlpayment_detail_actual_paid)), style: const TextStyle(fontSize: 14))),
                                                                                          )
                                                                                        ],
                                                                                      );
                                                                                    })
                                                                              ],
                                                                            );
                                                                          })),
                                                        ),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .green[100],
                                                              borderRadius: const BorderRadius
                                                                  .vertical(
                                                                  bottom: Radius
                                                                      .circular(
                                                                          16))),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        16,
                                                                    vertical:
                                                                        4.0),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    const Expanded(
                                                                        child:
                                                                            SizedBox()),
                                                                    const SizedBox(
                                                                      width:
                                                                          150,
                                                                      child:
                                                                          Text(
                                                                        'เลขบัญชีนำฝาก ::',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16),
                                                                      ),
                                                                    ),
                                                                    Center(
                                                                      child: Container(
                                                                          color: isStatusScreen != 'New' ? Colors.grey[300] : null,
                                                                          width: 150,
                                                                          child: lBankNumber.isEmpty
                                                                              ? Text('ไม่มีข้อมูลBank')
                                                                              : lBankNumber.length == 1
                                                                                  ? Text(bankNumber)
                                                                                  : _buildDropdownBank(bankNumber)),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 20,
                                                                    ),
                                                                    const SizedBox(
                                                                      width:
                                                                          100,
                                                                      child:
                                                                          Text(
                                                                        'วันที่นำฝาก ::',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          100,
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () {
                                                                          if (isStatusScreen !=
                                                                              'New') {
                                                                          } else {
                                                                            showDialog(
                                                                                context: context,
                                                                                builder: (context) {
                                                                                  return Dialog(
                                                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                                                                                    child: SizedBox(
                                                                                      height: 300,
                                                                                      width: 300,
                                                                                      child: Center(
                                                                                        child: SfDateRangePicker(
                                                                                          onSelectionChanged: _onSelectionChangedDeposit,
                                                                                          selectionMode: DateRangePickerSelectionMode.single,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                });
                                                                          }
                                                                        },
                                                                        onHover:
                                                                            (select) {},
                                                                        child:
                                                                            Text(
                                                                          depositDate,
                                                                          style: TextStyle(
                                                                              fontSize: 16,
                                                                              color: Colors.blue[900]),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              8.0),
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            150,
                                                                        child:
                                                                            Text(
                                                                          'ยอดนำฝากจริง ::',
                                                                          textAlign:
                                                                              TextAlign.end,
                                                                          style:
                                                                              TextStyle(fontSize: 16),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                        color: isStatusScreen !=
                                                                                'New'
                                                                            ? Colors.grey[
                                                                                300]
                                                                            : null,
                                                                        width:
                                                                            150,
                                                                        child:
                                                                            TextFormField(
                                                                          readOnly: isStatusScreen != 'New'
                                                                              ? true
                                                                              : false,
                                                                          textAlign:
                                                                              TextAlign.end,
                                                                          controller:
                                                                              depositActualController,
                                                                          inputFormatters: [
                                                                            FilteringTextInputFormatter.allow(
                                                                              RegExp(r'^-?\d*\.?\d{0,2}$'),
                                                                            ),
                                                                          ],
                                                                          onChanged:
                                                                              (v) {
                                                                            if (v.isEmpty) {
                                                                              v = '0.00';
                                                                              depositActualController.text = '0.00';
                                                                            }
                                                                          },
                                                                        )),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    SizedBox(
                                                                        height:
                                                                            40,
                                                                        width:
                                                                            60,
                                                                        child: Align(
                                                                            alignment: Alignment.center,
                                                                            child: InkWell(
                                                                                onTap: () {
                                                                                  showDialog(
                                                                                      barrierDismissible: false,
                                                                                      context: context,
                                                                                      builder: (context) {
                                                                                        return Dialog(
                                                                                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                                                                                            child: DepositImageScreen(
                                                                                              lDepositImage: lDepositImage,
                                                                                              lDepositImageDB: lDepositImageDB,
                                                                                              isStatusScreen: isStatusScreen,
                                                                                              depositId: depositId,
                                                                                              callbackFunctions: (p0) {
                                                                                                lDepositImage.clear();
                                                                                                lDepositImage.addAll(p0);

                                                                                                if (isStatusScreen != 'New') {
                                                                                                  isEditImage = true;
                                                                                                }

                                                                                                setState(() {});
                                                                                              },
                                                                                              callbackRemove: (reId) {
                                                                                                lDepositImage.removeWhere((re) => re.tldeposit_image_id == reId);

                                                                                                if (isStatusScreen != 'New') {
                                                                                                  isEditImage = true;
                                                                                                }

                                                                                                setState(() {});
                                                                                              },
                                                                                              callbackChangeComment: (i) {
                                                                                                isEditImage = i;
                                                                                              },
                                                                                            ));
                                                                                      });
                                                                                },
                                                                                onHover: (value) {
                                                                                  isHoverImage = value;

                                                                                  setState(() {});
                                                                                },
                                                                                child: lDepositImage.isNotEmpty
                                                                                    ? badges.Badge(
                                                                                        badgeContent: Text(
                                                                                          '${lDepositImage.length}',
                                                                                          style: const TextStyle(color: Colors.white),
                                                                                        ),
                                                                                        showBadge: lDepositImage.isNotEmpty,
                                                                                        badgeAnimation: const badges.BadgeAnimation.scale(),
                                                                                        child: Icon(
                                                                                          Icons.add_photo_alternate_rounded,
                                                                                          color: isHoverImage ? Colors.green[900] : Colors.grey,
                                                                                        ),
                                                                                      )
                                                                                    : Icon(
                                                                                        Icons.add_photo_alternate_rounded,
                                                                                        color: isHoverImage ? Colors.green[900] : Colors.grey,
                                                                                      )))),
                                                                    const Expanded(
                                                                        child:
                                                                            SizedBox()),
                                                                    const Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              8.0),
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            150,
                                                                        child:
                                                                            Text(
                                                                          'ยอดเงินจากระบบ ::',
                                                                          textAlign:
                                                                              TextAlign.end,
                                                                          style:
                                                                              TextStyle(fontSize: 16),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          150,
                                                                      child:
                                                                          Text(
                                                                        oCcy.format(
                                                                            dTotalDeposit),
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
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                              Center(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  child: Container(
                                                    color:
                                                        isStatusScreen != 'New'
                                                            ? Colors.grey[300]
                                                            : null,
                                                    height: 42,
                                                    child: TextFormField(
                                                      readOnly:
                                                          isStatusScreen !=
                                                                  'New'
                                                              ? true
                                                              : false,
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  "หมายเหตุ : "),
                                                      controller:
                                                          depositCommentController,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Expanded(child: SizedBox()),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  child: isEditImage
                                                      ? ActionSlider.standard(
                                                          height: 40,
                                                          action:
                                                              (controller) async {
                                                            controller
                                                                .loading(); //starts loading animation
                                                            await Future.delayed(
                                                                const Duration(
                                                                    milliseconds:
                                                                        1200),
                                                                () async {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return Dialog(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            80,
                                                                        height:
                                                                            80,
                                                                        decoration: const BoxDecoration(
                                                                            color:
                                                                                Colors.white,
                                                                            borderRadius: BorderRadius.all(Radius.circular(8))),
                                                                        child:
                                                                            const Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
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

                                                              for (var ldi
                                                                  in lDepositImage) {
                                                                var ldidb = lDepositImageDB
                                                                    .where((em) =>
                                                                        em.tldeposit_image_id ==
                                                                        ldi.tldeposit_image_id)
                                                                    .toList();

                                                                if (ldidb
                                                                    .isEmpty) {
                                                                  await createDepositImageDBById(
                                                                      ldi);
                                                                  await createDepositImageFolderById(
                                                                      ldi);
                                                                } else {
                                                                  await updateDepositImageDBById(
                                                                      ldidb
                                                                          .first);
                                                                }
                                                              }
                                                              //is Check Add Image Create Deposit Image
                                                            }); //starts success animation
                                                            controller
                                                                .success();
                                                            await Future.delayed(
                                                                const Duration(
                                                                    milliseconds:
                                                                        1200),
                                                                () async {
                                                              // //! loadPaymentDetail
                                                              await loadDepositDetailByDepositId(
                                                                  depositId);

                                                              if (isNew ==
                                                                  false) {
                                                                setState(() {
                                                                  Navigator.pop(
                                                                      context);
                                                                  runProcess =
                                                                      'loadData';
                                                                  isCheckRun =
                                                                      true;
                                                                  isNew = true;
                                                                });
                                                                //! loadPaymentDetail
                                                                setState(() {
                                                                  isNew = false;
                                                                  isEditImage =
                                                                      false;
                                                                  isCheckRun =
                                                                      false;
                                                                  controller
                                                                      .reset();
                                                                });
                                                              }
                                                            });

                                                            //starts success animation
                                                          },
                                                          backgroundColor:
                                                              Colors
                                                                  .orange[100],
                                                          toggleColor:
                                                              Colors.orange,
                                                          child: const Text(
                                                              'เลื่อน Slider เพื่อยืนยัน การแก้ไขข้อมูล'),
                                                        )
                                                      : ActionSlider.standard(
                                                          height: 40,
                                                          action:
                                                              (controller) async {
                                                            if (dTotalDeposit ==
                                                                    0 ||
                                                                isStatusScreen !=
                                                                    'New') {
                                                            } else {
                                                              controller
                                                                  .loading(); //starts loading animation
                                                              await Future.delayed(
                                                                  const Duration(
                                                                      milliseconds:
                                                                          1200),
                                                                  () async {
                                                                //! Deposit
                                                                createDeposit();
                                                                //! DepositDetail
                                                                createDepositDetail();
                                                                //await createPaymentDetail();
                                                                if (lDepositImage
                                                                    .isEmpty) {
                                                                } else {
                                                                  //! DepositImageDB
                                                                  await createDepositImageDB();
                                                                  //! DepositImageFolder
                                                                  await createDepositImageFolder();
                                                                  // //! loadPaymentDetail.Image
                                                                  await loadPaymentDetailImage(
                                                                      depositId);
                                                                }

                                                                setState(() {});
                                                              }); //starts success animation
                                                              controller
                                                                  .success();
                                                              await Future.delayed(
                                                                  const Duration(
                                                                      milliseconds:
                                                                          1200),
                                                                  () async {
                                                                await loadPaymentDetailDeposit(
                                                                    siteDDValue,
                                                                    selectedDate);

                                                                if (isNew ==
                                                                    false) {
                                                                  setState(() {
                                                                    runProcess =
                                                                        'loadData';
                                                                    isCheckRun =
                                                                        true;
                                                                    isNew =
                                                                        true;
                                                                  });
                                                                  //! loadPaymentDetail
                                                                  setState(() {
                                                                    isNew =
                                                                        false;
                                                                    isEditImage =
                                                                        false;
                                                                    isCheckRun =
                                                                        false;
                                                                    controller
                                                                        .reset();
                                                                  });
                                                                }
                                                              });
                                                            }
                                                            //starts success animation
                                                          },
                                                          backgroundColor:
                                                              isStatusScreen !=
                                                                          'New' ||
                                                                      dTotalDeposit ==
                                                                          0
                                                                  ? Colors
                                                                      .grey[300]
                                                                  : Colors.green[
                                                                      100],
                                                          toggleColor:
                                                              isStatusScreen !=
                                                                          'New' ||
                                                                      dTotalDeposit ==
                                                                          0
                                                                  ? Colors.grey
                                                                  : Colors
                                                                      .green,
                                                          child: dTotalDeposit ==
                                                                  0
                                                              ? const Text(
                                                                  'เลือกรายการที่จะนำฝาก')
                                                              : isStatusScreen !=
                                                                      'New'
                                                                  ? const Text(
                                                                      'ท่านได้ทำรายการเสร็จสมบรูณ์แล้ว')
                                                                  : const Text(
                                                                      'เลื่อน Slider เพื่อยืนยัน การนำฝาก'),
                                                        ),
                                                ),
                                              ),
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
                              depositId =
                                  '${TlConstant.runID()}${TlConstant.random()}';
                              depositDate = DateFormat('yyyy-MM-dd')
                                  .format(DateTime.now());
                              dateRec = selectedDate;
                              print('Event Btn Run');
                              print(widget.lEmp.first.employee_id);
                              print(selectedDate);
                              print(siteDDValue);

                              isStatusScreen = 'New';
                              siteRec = siteDDValue;

                              isEditImage = false;

                              await loadDeposit(siteDDValue, dateRec);
                              await loadBank(siteDDValue);
                              if (lDepositChoice.isNotEmpty) {
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
                                                        height: 40,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                  'รายการนำฝากเงิน'),
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
                                                              lDepositChoice
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
                                                                  depositId = lDepositChoice[
                                                                          index]
                                                                      .tldeposit_id;

                                                                  isStatusScreen =
                                                                      lDepositChoice[
                                                                              index]
                                                                          .tldeposit_status;

                                                                  lDepositImage =
                                                                      [];

                                                                  depositActualController
                                                                      .text = lDepositChoice[
                                                                          index]
                                                                      .tldeposit_total_actual;
                                                                  dTotalDeposit =
                                                                      double.parse(
                                                                          lDepositChoice[index]
                                                                              .tldeposit_total);
                                                                  depositDate =
                                                                      lDepositChoice[
                                                                              index]
                                                                          .tldeposit_date;
                                                                  depositBankAccountController
                                                                      .text = lDepositChoice[
                                                                          index]
                                                                      .tldeposit_bank_account;

                                                                  depositCommentController
                                                                      .text = lDepositChoice[
                                                                          index]
                                                                      .tldeposit_comment;
                                                                  setState(() {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    runProcess =
                                                                        'loadData';
                                                                    isCheckRun =
                                                                        true;
                                                                    isNew =
                                                                        true;
                                                                  });

                                                                  // //! loadPaymentDetail
                                                                  await loadDepositDetailByDepositId(
                                                                      depositId);

                                                                  // //! loadPaymentDetail.Image
                                                                  await loadPaymentDetailImage(
                                                                      depositId);

                                                                  setState(() {
                                                                    isNew =
                                                                        false;
                                                                    isCheckRun =
                                                                        false;
                                                                  });
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
                                                                                style: TextStyle(fontSize: 16),
                                                                                'สาขา : ${lDepositChoice[index].site_id}'),
                                                                            Text(
                                                                                style: const TextStyle(fontSize: 16),
                                                                                'วันที่ปิดผลัด : ${lDepositChoice[index].tlpayment_rec_date}'),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            vertical:
                                                                                4.0),
                                                                        child: Text(
                                                                            style:
                                                                                const TextStyle(fontSize: 14),
                                                                            'วันที่นำฝาก : ${lDepositChoice[index].tldeposit_date}'),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            vertical:
                                                                                4.0),
                                                                        child: Text(
                                                                            style:
                                                                                const TextStyle(fontSize: 14),
                                                                            'จำนวนเงินนำฝาก : ${lDepositChoice[index].tldeposit_total_actual}'),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            vertical:
                                                                                4.0),
                                                                        child: Text(
                                                                            style:
                                                                                const TextStyle(fontSize: 14),
                                                                            'เลขบัญชี : ${lDepositChoice[index].tldeposit_bank_account}'),
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
                                                                              lDepositChoice[index].tldeposit_status,
                                                                              style: const TextStyle(color: Colors.blue),
                                                                            ),
                                                                            Text(
                                                                                style: const TextStyle(fontSize: 14),
                                                                                'ผู้สร้าง : ${lDepositChoice[index].tldeposit_create_by}'),
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
                                                    message: 'New Deposit',
                                                    child: IconButton(
                                                      iconSize: 32,
                                                      color: Colors.green[900],
                                                      icon: const Icon(
                                                        Icons.note_add_rounded,
                                                      ),
                                                      onPressed: () async {
                                                        setState(() {
                                                          Navigator.of(context)
                                                              .pop();
                                                          runProcess =
                                                              'loadData';
                                                          isCheckRun = true;
                                                          isNew = true;
                                                        });
                                                        lDepositImage = [];
                                                        depositDate = DateFormat(
                                                                'yyyy-MM-dd')
                                                            .format(
                                                                DateTime.now());
                                                        depositBankAccountController
                                                            .clear();
                                                        depositCommentController
                                                            .clear();
                                                        depositActualController
                                                            .clear();
                                                        dTotalDeposit = 0;

                                                        await loadPaymentDetailDeposit(
                                                            siteDDValue,
                                                            selectedDate);

                                                        setState(() {
                                                          isNew = false;
                                                          isCheckRun = false;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ));
                                    });
                              } else {
                                setState(() {
                                  runProcess = 'loadData';
                                  isCheckRun = true;
                                  isNew = true;
                                });

                                lDepositImage = [];
                                depositDate = DateFormat('yyyy-MM-dd')
                                    .format(DateTime.now());
                                depositBankAccountController.clear();
                                depositCommentController.clear();
                                depositActualController.clear();
                                dTotalDeposit = 0;
                                await loadPaymentDetailDeposit(
                                    siteDDValue, selectedDate);

                                setState(() {
                                  isNew = false;
                                  isCheckRun = false;
                                });

                                // if (isNew == false) {
                                //   setState(() {
                                //     runProcess = 'loadData';
                                //     isCheckRun = true;
                                //     isNew = true;
                                //   });
                                //   //! loadPaymentDetail
                                //   setState(() {
                                //     isNew = false;
                                //     isCheckRun = false;
                                //   });
                                // }
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

  void _onSelectionChangedDeposit(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is DateTime) {
        depositDate = DateFormat('yyyy-MM-dd').format(args.value);
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

  //! siteToAddPaymentType = ค่าว่าง

  loadDeposit(String siteDDValue, String date) async {
    lDepositChoice = [];
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "site_id": siteDDValue,
      "rec_date": date,
    });
    String api = '${TlConstant.syncApi}tlDeposit.php?id=load';

    await Dio().post(api, data: formData).then((value) {
      if (value.data == null) {
        print('NoData');
      } else {
        for (var d in value.data) {
          DepositModel newDeposit = DepositModel.fromMap(d);
          lDepositChoice.add(newDeposit);
        }
      }
    });
  }

  Future loadPaymentDetailDeposit(String siteDDValue, String date) async {
    lPaymentMDAndDepositMDAndFullName = [];
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "site_id": siteDDValue,
      "rec_date": date,
    });
    String api = '${TlConstant.syncApi}tlPaymentDetail.php?id=deposit';

    await Dio().post(api, data: formData).then((value) async {
      if (value.data == null) {
        print('NoData');
      } else {
        for (var pdd in value.data) {
          PaymentMDAndDepositMDModel ee =
              PaymentMDAndDepositMDModel.fromMap(pdd);
          PaymentMDAndDepositMDAndFullNameModel newPaymentDD =
              PaymentMDAndDepositMDAndFullNameModel(
                  emp_fullname: await employeeFullName(ee.tlpayment_rec_by),
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
                  tlpayment_detail_id: ee.tlpayment_detail_id,
                  tlpayment_type_id: ee.tlpayment_type_id,
                  tlpayment_type: ee.tlpayment_type,
                  tlpayment_type_detail_id: ee.tlpayment_type_detail_id,
                  tlpayment_type_detail: ee.tlpayment_type_detail,
                  paid_go: ee.paid_go,
                  tlpayment_detail_site_id: ee.tlpayment_detail_site_id,
                  tlpayment_detail_actual_paid: ee.tlpayment_detail_actual_paid,
                  tlpayment_detail_diff_paid: ee.tlpayment_detail_diff_paid,
                  tlpayment_detail_comment: ee.tlpayment_detail_comment,
                  ischeck: ee.ischeck,
                  tldeposit_id: ee.tldeposit_id,
                  tldeposit_detail_id: ee.tldeposit_detail_id,
                  tldeposit_create_by: ee.tldeposit_create_by,
                  tldeposit_create_by_fullname:
                      await employeeFullName(ee.tldeposit_create_by),
                  tldeposit_create_date: ee.tldeposit_create_date);

          lPaymentMDAndDepositMDAndFullName.add(newPaymentDD);
        }
        groupName = groupPaymentDeposit(lPaymentMDAndDepositMDAndFullName);
      }
    });
  }

  Future loadDepositDetailByDepositId(String depositId) async {
    lPaymentMDAndDepositMDAndFullName = [];
    FormData formData =
        FormData.fromMap({"token": TlConstant.token, "deposit_id": depositId});
    String api = '${TlConstant.syncApi}tlPaymentDetail.php?id=depositid';
    await Dio().post(api, data: formData).then((value) async {
      if (value.data == null) {
        print('NoData');
      } else {
        for (var pdd in value.data) {
          PaymentMDAndDepositMDModel ee =
              PaymentMDAndDepositMDModel.fromMap(pdd);
          PaymentMDAndDepositMDAndFullNameModel newPaymentDD =
              PaymentMDAndDepositMDAndFullNameModel(
                  emp_fullname: await employeeFullName(ee.tlpayment_rec_by),
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
                  tlpayment_detail_id: ee.tlpayment_detail_id,
                  tlpayment_type_id: ee.tlpayment_type_id,
                  tlpayment_type: ee.tlpayment_type,
                  tlpayment_type_detail_id: ee.tlpayment_type_detail_id,
                  tlpayment_type_detail: ee.tlpayment_type_detail,
                  paid_go: ee.paid_go,
                  tlpayment_detail_site_id: ee.tlpayment_detail_site_id,
                  tlpayment_detail_actual_paid: ee.tlpayment_detail_actual_paid,
                  tlpayment_detail_diff_paid: ee.tlpayment_detail_diff_paid,
                  tlpayment_detail_comment: ee.tlpayment_detail_comment,
                  ischeck: ee.ischeck,
                  tldeposit_id: ee.tldeposit_id,
                  tldeposit_detail_id: ee.tldeposit_detail_id,
                  tldeposit_create_by: ee.tldeposit_create_by,
                  tldeposit_create_by_fullname:
                      await employeeFullName(ee.tldeposit_create_by),
                  tldeposit_create_date: ee.tldeposit_create_date);

          lPaymentMDAndDepositMDAndFullName.add(newPaymentDD);
        }
        groupName = groupPaymentDeposit(lPaymentMDAndDepositMDAndFullName);
      }
    });
  }

  Future<String> employeeFullName(String emp_id) async {
    lEmployeeDeposit = [];
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
          lEmployeeDeposit.add(newEmp);
        }
        emp_fullname = lEmployeeDeposit.first.emp_fullname;
      }
    });

    return emp_fullname;
  }

  loadBank(String site_id) async {
    lBank = [];
    lBankNumber = [];
    bankNumber = '';
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "siteid": site_id,
    });
    String api = '${TlConstant.syncApi}tlPaymentBank.php?id=siteid';

    await Dio().post(api, data: formData).then((value) {
      if (value.data == null) {
        print('NoData');
      } else {
        for (var b in value.data) {
          BankModel newBank = BankModel.fromMap(b);
          lBankNumber.add(newBank.tlpayment_bank_number);
          lBank.add(newBank);
        }

        bankNumber = lBankNumber.first;
        print(bankNumber);
      }
    });
  }

  Future loadPaymentDetailImage(String depositId) async {
    lDepositImage = [];
    lDepositImageDB = [];
    FormData formData = FormData.fromMap(
        {"token": TlConstant.token, "tldeposit_id": depositId});
    String api = '${TlConstant.syncApi}tlDepositImage.php?id=deposit';

    await Dio().post(api, data: formData).then((value) {
      if (value.data == null) {
        print('PaymentDetailImage Null !');
      } else {
        for (var pdImage in value.data) {
          DepositImageModel newPDImage = DepositImageModel.fromMap(pdImage);
          lDepositImageDB.add(newPDImage);
        }
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
    });
  }

  //! Deposit
  Future createDeposit() async {
    String dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String timeNow = DateFormat('HH:mm:ss').format(DateTime.now());
    String status = 'success';
    dTotalBalance = double.parse(depositActualController.text) - dTotalDeposit;

    String bankCode = lBank
        .where((element) => element.tlpayment_bank_number == bankNumber)
        .first
        .tlpayment_bank_code;

    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "tldeposit_id": depositId,
      "site_id": siteRec,
      "tldeposit_create_date": dateNow,
      "tldeposit_create_time": timeNow,
      "tldeposit_bank": bankCode,
      "tldeposit_bank_account": bankNumber,
      "tldeposit_date": depositDate,
      "tldeposit_total": dTotalDeposit.toStringAsFixed(2),
      "tldeposit_total_actual": depositActualController.text,
      "tldeposit_total_balance": dTotalBalance.toStringAsFixed(2),
      "tldeposit_comment": depositCommentController.text,
      "tldeposit_status": status,
      "tldeposit_create_by": widget.lEmp.first.employee_id,
      "tlpayment_rec_date": dateRec
    });
    String api = '${TlConstant.syncApi}tlDeposit.php?id=create';

    await Dio().post(api, data: formData);

    isStatusScreen = status;
  }

  //! DepositDetail
  Future createDepositDetail() async {
    var depositDetailId = '${TlConstant.runID()}${TlConstant.random()}';
    for (var i = 0; i < lPaymentMDAndDepositMDAndFullName.length; i++) {
      if (lPaymentMDAndDepositMDAndFullName[i].ischeck == 'active' &&
          lPaymentMDAndDepositMDAndFullName[i].tldeposit_detail_id.isEmpty) {
        FormData formData = FormData.fromMap({
          "token": TlConstant.token,
          "tldeposit_detail_id":
              '${depositDetailId}${i.toString().padLeft(3, '0')}',
          "tldeposit_id": depositId,
          "tlpayment_id": lPaymentMDAndDepositMDAndFullName[i].tlpayment_id,
          "tlpayment_detail_id":
              lPaymentMDAndDepositMDAndFullName[i].tlpayment_detail_id,
          "tlpayment_type_id":
              lPaymentMDAndDepositMDAndFullName[i].tlpayment_type_id,
          "tlpayment_type": lPaymentMDAndDepositMDAndFullName[i].tlpayment_type,
          "tlpayment_type_detail_id":
              lPaymentMDAndDepositMDAndFullName[i].tlpayment_type_detail_id,
          "tlpayment_type_detail":
              lPaymentMDAndDepositMDAndFullName[i].tlpayment_type_detail,
          "tlpayment_detail_actual_paid":
              lPaymentMDAndDepositMDAndFullName[i].tlpayment_detail_actual_paid,
        });
        String api = '${TlConstant.syncApi}tlDepositDetail.php?id=create';

        await Dio().post(api, data: formData);
      }
    }
  }

  //! DepositImageDB
  Future createDepositImageDB() async {
    for (var img in lDepositImage) {
      var image_path =
          '${TlConstant.syncApi}UploadImages/Deposit/${widget.lEmp.first.employee_id}/$depositDate/$siteRec/$depositId/${img.tldeposit_image_id}.${img.tldeposit_image_lastName}';
      //! ToDB
      FormData formData = FormData.fromMap({
        "token": TlConstant.token,
        "tldeposit_image_id": img.tldeposit_image_id,
        "tldeposit_id": depositId,
        "tldeposit_image_path": image_path,
        "tldeposit_image_description": img.tldeposit_image_description,
      });

      String api = '${TlConstant.syncApi}tlDepositImage.php?id=create';
      await Dio().post(api, data: formData);
    }
  }

  //! DepositImageFolder
  Future createDepositImageFolder() async {
    for (var img in lDepositImage) {
      // //!upload/Name/Date/Site/type_id/iMageName= type_id_ImageId
      FormData formDataImg = FormData.fromMap({
        "base64data": img.tldeposit_image_base64,
        "typeFolder": 'Deposit',
        "name": widget.lEmp.first.employee_id,
        "date": depositDate,
        "site": siteRec,
        "type_id": img.tldeposit_id,
        "lastname": img.tldeposit_image_lastName,
        "imageId": img.tldeposit_image_id,
      });
      await Dio()
          .post('${TlConstant.syncApi}uploadFile.php', data: formDataImg);
    }
  }

//! DepositImageDB
  Future createDepositImageDBById(DepositImageTempModel img) async {
    var image_path =
        '${TlConstant.syncApi}UploadImages/Deposit/${widget.lEmp.first.employee_id}/$depositDate/$siteRec/$depositId/${img.tldeposit_image_id}.${img.tldeposit_image_lastName}';
    //! ToDB
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "tldeposit_image_id": img.tldeposit_image_id,
      "tldeposit_id": depositId,
      "tldeposit_image_path": image_path,
      "tldeposit_image_description": img.tldeposit_image_description,
    });

    String api = '${TlConstant.syncApi}tlDepositImage.php?id=create';
    await Dio().post(api, data: formData);
  }

  //! DepositImageFolder
  Future createDepositImageFolderById(DepositImageTempModel img) async {
    // //!upload/Name/Date/Site/type_id/iMageName= type_id_ImageId
    FormData formDataImg = FormData.fromMap({
      "base64data": img.tldeposit_image_base64,
      "typeFolder": 'Deposit',
      "name": widget.lEmp.first.employee_id,
      "date": depositDate,
      "site": siteRec,
      "type_id": img.tldeposit_id,
      "lastname": img.tldeposit_image_lastName,
      "imageId": img.tldeposit_image_id,
    });
    await Dio().post('${TlConstant.syncApi}uploadFile.php', data: formDataImg);
  }

  Future updateDepositImageDBById(DepositImageModel img) async {
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "id": img.tldeposit_image_id,
      "description": img.tldeposit_image_description,
    });
    String api = '${TlConstant.syncApi}tlDepositImage.php?id=update';
    await Dio().post(api, data: formData);
  }

  groupPaymentDeposit(
      List<PaymentMDAndDepositMDAndFullNameModel>
          lPaymentMDAndDepositMDAndFullName) {
    return groupBy(lPaymentMDAndDepositMDAndFullName, (gKey) {
      var nameAndDate = '${gKey.emp_fullname}  [ ${gKey.tlpayment_rec_date} ]';
      return nameAndDate;
    });
    //=> gKey.emp_fullname);
  }

  _buildDropdownBank(String bankValue) {
    return StatefulBuilder(
      builder: (context, setState) {
        return DropdownButton<String>(
          isExpanded: true,
          value: bankValue,
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
              bankValue = value!;
              print(bankValue);
            });
          },
          items: lBankNumber.map<DropdownMenuItem<String>>((String value) {
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
}
