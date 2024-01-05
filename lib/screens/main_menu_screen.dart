// ignore_for_file: must_be_immutable

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:thonglor_e_smart_cashier_web/models/employee_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/paymentApproval_model.dart';
import 'package:thonglor_e_smart_cashier_web/screens/check_deposit_screen.dart';
import 'package:thonglor_e_smart_cashier_web/screens/check_payment_screen.dart';
import 'package:thonglor_e_smart_cashier_web/screens/deposit_screen.dart';
import 'package:thonglor_e_smart_cashier_web/screens/exam_screen.dart';
import 'package:thonglor_e_smart_cashier_web/screens/payment_type_screen.dart';

import 'package:badges/badges.dart' as badges;
import '../util/constant.dart';

class MainMenuScreen extends StatefulWidget {
  List<EmployeeModel> lEmp;
  MainMenuScreen({required this.lEmp, super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  String isHoverIcon = '0';
  bool isMenuApprover = false;
  bool isMenuAdmin = false;
  String labelMainMenu = 'รายงานปิดเวร ประจำวัน';
  String isSwitchMenu = '0'; //()

  String status = 'request';
  bool isReady = true; // false;

  List<EmployeeModel> lEmpPeeOill = [];

  List<PaymentApprovalModel> lPaymentApproval = [];
  String empId = 'wijittra';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () async {
      await loadPaymentApproval();
    });
  }

  @override
  Widget build(BuildContext context) {
    // EmployeeModel PeeOill = EmployeeModel(
    //     employee_id: 'wijittra',
    //     emp_fullname: 'คุณ วิจิตรา สักขวา',
    //     password: 'f29b38f160f87ae86df31cee1982066f',
    //     site_id: 'R9',
    //     bsp_id: '99107',
    //     bsp_name: 'test',
    //     fix_employee_type_id: '4');

    // lEmpPeeOill.add(PeeOill);

    print('Width : ${MediaQuery.of(context).size.width}');
    print('Height : ${MediaQuery.of(context).size.height}');
    return Material(
      child: Container(
        color: Colors.grey[300],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 16,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36)),
            ),
            child: SizedBox(
              child: Column(
                children: [
                  SizedBox(
                    child: Card(
                      elevation: 4,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(36),
                            bottomRight: Radius.circular(8)),
                      ),
                      color: Colors.green[200],
                      child: Padding(
                        padding: MediaQuery.of(context).size.height <= 661
                            ? EdgeInsets.all(4.0)
                            : EdgeInsets.all(8.0),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 200,
                                child: Tooltip(
                                  message: 'Log Out',
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: IconButton(
                                      icon: const Icon(
                                          Icons.arrow_back_ios_new_rounded,
                                          color: Colors.red),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                child: Text(
                                  '${labelMainMenu}',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.green[900]),
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Tooltip(
                                      message: 'รายงานปิดเวร ประจำวัน',
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.currency_exchange_rounded,
                                          color: isSwitchMenu == '0'
                                              ? Colors.green[900]
                                              : Colors.green,
                                        ),
                                        onPressed: () {
                                          isSwitchMenu = '0';
                                          labelMainMenu =
                                              'รายงานปิดเวร ประจำวัน';
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                        child: Tooltip(
                                      message: 'ตรวจสอบการปิดเวร',
                                      child: IconButton(
                                        icon: badges.Badge(
                                          badgeContent: Text(
                                            '${lPaymentApproval.length}',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          showBadge:
                                              lPaymentApproval.isNotEmpty,
                                          badgeAnimation: const badges
                                              .BadgeAnimation.scale(),
                                          child: Icon(
                                            Icons.price_check_outlined,
                                            color: isSwitchMenu == '1'
                                                ? Colors.green[900]
                                                : Colors.green,
                                          ),
                                        ),
                                        onPressed: () {
                                          isSwitchMenu = '1';
                                          labelMainMenu = 'ตรวจสอบการปิดเวร';
                                          setState(() {});
                                        },
                                      ),
                                    )),
                                    SizedBox(
                                        child: Tooltip(
                                      message: 'นำฝาก',
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.savings_rounded,
                                          color: isSwitchMenu == '2'
                                              ? Colors.green[900]
                                              : Colors.green,
                                        ),
                                        onPressed: () {
                                          isSwitchMenu = '2';
                                          labelMainMenu = 'นำฝาก';
                                          setState(() {});
                                        },
                                      ),
                                    )),

                                    SizedBox(
                                        child: Tooltip(
                                      message: 'ตรวจสอบเงินนำฝาก',
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.account_balance_rounded,
                                          color: isSwitchMenu == '3'
                                              ? Colors.green[900]
                                              : Colors.green,
                                        ),
                                        onPressed: () {
                                          isSwitchMenu = '3';
                                          labelMainMenu = 'ตรวจสอบเงินนำฝาก';
                                          setState(() {});
                                        },
                                      ),
                                    )),
                                    SizedBox(
                                        child: Tooltip(
                                      message: 'ตรวจสอบรายงาน ณ สิ้นวัน',
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.currency_bitcoin_rounded,
                                          color: isSwitchMenu == '4'
                                              ? Colors.green[900]
                                              : Colors.green,
                                        ),
                                        onPressed: () {
                                          isSwitchMenu = '4';
                                          labelMainMenu =
                                              'ตรวจสอบรายงาน ณ สิ้นวัน';
                                          setState(() {});
                                        },
                                      ),
                                    )),
                                    // SizedBox(
                                    //   child: Tooltip(
                                    //           message: 'Admin',
                                    //           child: IconButton(
                                    //             icon: Icon(
                                    //                 Icons
                                    //                     .workspace_premium_sharp,
                                    //                 color: isSwitchMenu == '2'
                                    //                    ? Colors.green[900]
                                    //           : Colors.green,
                                    //                       ),
                                    //             onPressed: () {
                                    //               isSwitchMenu = '2';
                                    //               labelMainMenu = 'Admin';
                                    //               setState(() {});
                                    //             },
                                    //           ),
                                    //         )
                                    // ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: isReady
                          ? isSwitchMenu == '0' //ListProcessScreen
                              ? PaymentTypeScreen(
                                  lEmp: widget.lEmp, // lEmpPeeOill,
                                )
                              : isSwitchMenu == '1'
                                  ? CheckPaymentScreen(
                                      lPaymentApproval: lPaymentApproval,
                                      lEmp: widget.lEmp, // lEmpPeeOill,

                                      callbackUpdate: () {
                                        loadPaymentApproval();
                                      },
                                    )
                                  : isSwitchMenu == '2'
                                      ? DepositScreen(
                                          lEmp: widget.lEmp, // lEmpPeeOill,
                                        )
                                      : isSwitchMenu == '3'
                                          ? CheckDepositScreen(
                                              lEmp: widget.lEmp, // lEmpPeeOill,
                                            )
                                          : isSwitchMenu == '4'
                                              ? CheckPaymentScreen(
                                                  lPaymentApproval:
                                                      lPaymentApproval,
                                                  lEmp: widget
                                                      .lEmp, // lEmpPeeOill,
                                                  callbackUpdate: () {},
                                                )
                                              /*  //สำหรับ แสดง Menu อื่นๆ              
                                  // : isSwitchMenu == '2'
                                  //     ? ListProcessScreen(
                                  //         hr_id: widget.hr_id,
                                  //         callbackFunctions: () async {
                                  //           setState(() {});
                                  //         })
                                  //     : isSwitchMenu == '3'
                                  //         ? ListAllRequestScreen()
                                  //         : isSwitchMenu == '4'
                                  //             ? ProfileScreen(
                                  //                 hr_id: widget.hr_id,
                                  //                 lprofile: lprofile,
                                  //                 callbackFunctions:
                                  //                     () async {
                                  //                   setState(() {});
                                  //                 })
                                  */
                                              : const SizedBox()
                          : const SizedBox(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  loadPaymentApproval() async {
    lPaymentApproval = [];
    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "emp_id": widget.lEmp.first.employee_id //lEmpPeeOill.first.employee_id
    }); //widget.lEmp.first.employee_id});
    String api = '${TlConstant.syncApi}tlPaymentApproval.php?id=emp';
    await Dio().post(api, data: formData).then((value) {
      if (value.data == null) {
        print('PaymentDetailRemark Null !');
      } else {
        for (var pdRemark in value.data) {
          PaymentApprovalModel newPDRemark =
              PaymentApprovalModel.fromMap(pdRemark);
          lPaymentApproval.add(newPDRemark);
        }
      }
    });
    setState(() {});
  }
}
