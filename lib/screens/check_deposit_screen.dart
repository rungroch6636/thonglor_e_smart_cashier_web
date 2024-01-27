// ignore_for_file: must_be_immutable, unused_field, use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:badges/badges.dart' as badges;
import 'package:thonglor_e_smart_cashier_web/models/depositImageTemp_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/paymentMDAndDepositMDAndFullName_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/paymentDetail_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/payment_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/receipt_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/site_model.dart';
import 'package:thonglor_e_smart_cashier_web/screens/deposit_image_screen.dart';

import 'package:thonglor_e_smart_cashier_web/util/constant.dart';
import 'package:collection/collection.dart';

import '../models/employee_model.dart';
import '../models/paymentMDAndDepositMD_model.dart';

class CheckDepositScreen extends StatefulWidget {
  List<EmployeeModel> lEmp;
  CheckDepositScreen({required this.lEmp, super.key});

  @override
  State<CheckDepositScreen> createState() => _CheckDepositScreenState();
}

//emp nipaporn  0635644228 2023-11-15  two Site (หลี)
//emp arunrat_b 2023-06-01 one Site
class _CheckDepositScreenState extends State<CheckDepositScreen> {
  List<DepositImageTempModel> lDepositImage = [];
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

   List<PaymentMDAndDepositMDModel> lPaymentMDAndDepositMD = [];
  List<PaymentMDAndDepositMDAndFullNameModel>
      lPaymentMDAndDepositMDAndFullName = [];
  List<EmployeeModel> lEmployeeDeposit = [];

  TextEditingController depositCommentController = TextEditingController();
  var groupName;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    selectedDate = '${selectDateFrom} - ${selectDateTo}';
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
                                                            BorderRadius
                                                                .circular(16)),
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 24),
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
                                                                                                    value: mPayment.ischeck == 'inactive' ? false : true,
                                                                                                    onChanged: (value) {
                                                                                                      if (value == true) {
                                                                                                        mPayment.ischeck = 'active';
                                                                                                        dTotalDeposit += double.parse(mPayment.tlpayment_detail_actual_paid);
                                                                                                      } else {
                                                                                                        mPayment.ischeck = 'inactive';
                                                                                                        dTotalDeposit -= double.parse(mPayment.tlpayment_detail_actual_paid);

                                                                                                        if (dTotalDeposit < 0) {
                                                                                                          dTotalDeposit = 0;
                                                                                                        }
                                                                                                      }
                                                                                                      setState(() {});
                                                                                                    })),
                                                                                          ),
                                                                                          SizedBox(child: Text('${mPayment.tlpayment_type} (${mPayment.tlpayment_type_detail})', style: const TextStyle(fontSize: 14))),
                                                                                          Expanded(child: SizedBox()),
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                                                                            child: SizedBox(child: Text(mPayment.tlpayment_detail_actual_paid, style: const TextStyle(fontSize: 14))),
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
                                                                    .all(8),
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                    height: 40,
                                                                    width: 60,
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
                                                                                          lDepositImage: [],
                                                                                          lDepositImageDB: [],
                                                                                          isStatusScreen: '',
                                                                                          depositId: 'depositId',
                                                                                          callbackFunctions: (p0) {
                                                                                            // for (var ee in p0) {
                                                                                            //   var isCheckImage = lDepositImage.where((e0) => e0.tlpayment_detail_image_id == ee.tlpayment_detail_image_id).toList();
                                                                                            //   if (isCheckImage.isEmpty) {
                                                                                            //     lDepositImage.add(ee);
                                                                                            //   }
                                                                                            // }

                                                                                            setState(() {});
                                                                                          },
                                                                                          callbackRemove: (reId) {
                                                                                            // lDepositImage.removeWhere((re) => re.tlpayment_detail_image_id == reId);
                                                                                            setState(() {});
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
                                                                const SizedBox(
                                                                  width: 150,
                                                                  child: Text(
                                                                    'เลขบัญชีนำฝาก ::',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                ),
                                                                Center(
                                                                  child: SizedBox(
                                                                      width: 160,
                                                                      height: 32,
                                                                      child: TextFormField(
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          contentPadding:
                                                                              EdgeInsets.only(bottom: 20),
                                                                        ),
                                                                      )),
                                                                ),
                                                                const SizedBox(
                                                                  width: 40,
                                                                ),
                                                                const SizedBox(
                                                                  width: 120,
                                                                  child: Text(
                                                                    'วันที่นำฝาก ::',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 120,
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (context) {
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
                                                                    },
                                                                    onHover:
                                                                        (select) {},
                                                                    child: Text(
                                                                      depositDate,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              Colors.blue[900]),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 150,
                                                                  child: Text(
                                                                    'ยอดเงินนำฝาก รวม ::',
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
                                                                        dTotalDeposit),
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
                                              const Expanded(child: SizedBox()),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        dTotalDeposit == 0
                                                            ? Colors.grey
                                                            : null,
                                                  ),
                                                  child: const Text(' Save '),
                                                  onPressed: () async {
                                                    if (lPaymentDetail
                                                        .isEmpty) {
                                                    } else {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return const Center(
                                                              child: SizedBox(
                                                                height: 100,
                                                                width: 100,
                                                                child: Center(
                                                                  child:
                                                                      CircularProgressIndicator(),
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                      Future.delayed(
                                                          Duration(seconds: 1),
                                                          () async {
                                                        //! Deposit
                                                        //! DepositDetail
                                                        //await createPaymentDetail();
                                                        if (lDepositImage
                                                            .isEmpty) {
                                                        } else {
                                                          //! DepositImageDB
                                                          //await createPaymentDetailImageDB();
                                                          //! DepositImageFolder
                                                          //await createPaymentDetailImageFolder();
                                                        }
                                                        Navigator.pop(context);
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return const Center(
                                                              child: Card(
                                                                elevation: 0,
                                                                color: Color
                                                                    .fromARGB(
                                                                        0,
                                                                        255,
                                                                        255,
                                                                        255),
                                                                child: Text(
                                                                  'Save Success..',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .green,
                                                                      fontSize:
                                                                          24),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                        Future.delayed(
                                                            const Duration(
                                                                milliseconds:
                                                                    500), () {
                                                          Navigator.pop(
                                                              context);
                                                        });
                                                        setState(() {});
                                                      });
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
                        selectionMode: DateRangePickerSelectionMode.range,
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

                              dTotalDeposit = 0;
                              await loadPaymentDetailDeposit(
                                siteDDValue,
                                selectDateFrom,
                                selectDateTo,
                              );
                              if (isNew == false) {
                                setState(() {
                                  runProcess = 'loadData';
                                  isCheckRun = true;
                                  isNew = true;
                                });
                                //! loadPaymentDetail
                                setState(() {
                                  isNew = false;
                                  isCheckRun = false;
                                });
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
        selectedDate = '${selectDateFrom} - ${selectDateTo}';
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

  Future loadPaymentByDate(
      String employee_id, String siteDDValue, String selectedDate) async {
    lPayment = [];
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
          lPayment.add(newPayment);
        }
      }
    });
  }

  Future loadPaymentDetailDeposit(
      String siteDDValue, String dateFrom, String dateTo) async {
    lPaymentMDAndDepositMDAndFullName = [];
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "site_id": siteDDValue,
      "rec_date_from": dateFrom,
      "rec_date_to": dateTo
    });
    String api = '${TlConstant.syncApi}tlPaymentDetail.php?id=deposit';

    await Dio().post(api, data: formData).then((value) {
      if (value.data == null) {
        print('NoData');
      } else {
        for (var pdd in value.data) {
          PaymentMDAndDepositMDAndFullNameModel newPaymentDD =
              PaymentMDAndDepositMDAndFullNameModel.fromMap(pdd);
          lPaymentMDAndDepositMDAndFullName.add(newPaymentDD);
        }

        groupName = groupPaymentDeposit(lPaymentMDAndDepositMDAndFullName);
      }
    });
  }

  

  //! Deposit
  Future createDeposit() async {
    String dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String timeNow = DateFormat('HH:mm:ss').format(DateTime.now());
    String status = 'create';

    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "tlpayment_id": depositId,
      "tlpayment_imed_total": dTotalPaid.toStringAsFixed(2),
      "tlpayment_actual_total": dTotalActual.toStringAsFixed(2),
      "tlpayment_diff_abs": dTotalBalance.toStringAsFixed(2),
      "tlpayment_rec_date": dateRec,
      // "tlpayment_rec_time_from": startTime,
      // "tlpayment_rec_time_to": endTime,
      "tlpayment_rec_site": siteToAddPaymentType,
      "tlpayment_rec_by": widget.lEmp.first.employee_id,
      "tlpayment_create_date": dateNow,
      "tlpayment_create_time": timeNow,
      "tlpayment_modify_date": '',
      "tlpayment_modify_time": '',
      "tlpayment_status": status,
      "tlpayment_merge_id": '',
    });
    String api = '${TlConstant.syncApi}tlPayment.php?id=create';

    await Dio().post(api, data: formData);
  }

  //! DepositDetail
  Future createDepositDetail() async {
    for (var PD in lPaymentDetail) {
      //! EditColumnInPaymentDetail
      // FormData formData = FormData.fromMap({
      //   "token": token,
      //   "tlpayment_detail_id": PD.tlpayment_detail_id,
      //   "tlpayment_id": PD.tlpayment_id,
      //   "tlpayment_detail_type_name": PD.tlpayment_detail_type_name,
      //   "imed_receip_paid": PD.imed_receip_paid,
      //   "tlpayment_detail_actual_paid": PD.tlpayment_detail_actual_paid,
      //   "tlpayment_detail_diff_paid": PD.tlpayment_detail_diff_paid,
      //   "tlpayment_detail_site_id": PD.tlpayment_detail_site_id,
      //   "tlpayment_detail_type_id": PD.tlpayment_detail_type_id,
      // });
      // String api = '${TlConstant.syncApi}tlPaymentDetail.php?id=create';

      // await Dio().post(api, data: formData);
    }
  }

  //! DepositImageDB
  Future createDepositImageDB() async {
    for (var img in lDepositImage) {
      // var image_path =
      //     '${TlConstant.syncApi}UploadImages/PaymentType/${widget.lEmp.first.employee_id}/$dateRec/$siteToAddPaymentType/${img.tlpayment_detail_type_id}/${img.tlpayment_detail_image_id}.${img.tlpayment_image_last_Name}';
      // //! ToDB
      // FormData formData = FormData.fromMap({
      //   "token": token,
      //   "tlpayment_detail_image_id": img.tlpayment_detail_image_id,
      //   "tlpayment_detail_id": img.tlpayment_detail_id,
      //   "tlpayment_image_path": image_path,
      //   "tlpayment_image_description": img.tlpayment_image_description,
      //   "tlpayment_detail_type_id": img.tlpayment_detail_type_id,
      //   "tlpayment_id": img.tlpayment_id,
      // });

      // String api = '${TlConstant.syncApi}tlPaymentDetailImage.php?id=create';
      // await Dio().post(api, data: formData);
    }
  }

  groupPaymentDeposit(List<PaymentMDAndDepositMDAndFullNameModel> lPaymentMDAndDepositMDAndFullName) {
    return groupBy(lPaymentMDAndDepositMDAndFullName, (gKey) {
      var nameAndDate = '${gKey.emp_fullname}  [ ${gKey.tlpayment_rec_date} ]';
      return nameAndDate;
    });
    //=> gKey.emp_fullname);
  }
}
