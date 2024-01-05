import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:thonglor_e_smart_cashier_web/models/paymentDetailRemark_model.dart';
import 'package:intl/intl.dart';
import 'package:thonglor_e_smart_cashier_web/widgets/textFormFieldAmount.dart';
import 'package:thonglor_e_smart_cashier_web/widgets/textFormFieldComment.dart';
import 'package:thonglor_e_smart_cashier_web/widgets/textFormFieldTime.dart';

import '../util/constant.dart';
import 'textFormFieldDate.dart';

class RemarkPopUp extends StatefulWidget {
  List<PaymentDetailRemarkModel> lPaymentRemarkByType;

  String paymentDetailId;
  String paymentId;
  String isStatusScreen;

  Function callbackAdd;
  Function callbackRemove;

  RemarkPopUp(
      {required this.lPaymentRemarkByType,
      required this.paymentDetailId,
      required this.paymentId,
      required this.isStatusScreen,
      required this.callbackAdd,
      required this.callbackRemove,
      super.key});

  @override
  State<RemarkPopUp> createState() => _RemarkPopUpState();
}

class _RemarkPopUpState extends State<RemarkPopUp> {
  List<PaymentDetailRemarkModel> lPaymentRemark = [];
  List<String> lBank = ['KBANK', 'SCB'];
  String bankValue = 'KBANK';

  bool isClose = true;
  bool isHover = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.lPaymentRemarkByType.isNotEmpty) {
      lPaymentRemark.addAll(widget.lPaymentRemarkByType);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
            height: 600,
            width: 800,
            child: Stack(
              children: [
                Positioned(
                  top: 2,
                  left: 2,
                  right: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 40,
                      ),
                      const Text('REMARK'),
                      Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: 40,
                          child: IconButton(
                            icon: Icon(
                              Icons.cancel,
                              color: isClose ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              isClose ? Navigator.pop(context) : null;
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 2,
                  right: 2,
                  bottom: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        //color: Color.fromARGB(255, 183, 191, 219),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 162, 162, 167),
                            //offset: Offset(-2, -2),
                          ),
                          BoxShadow(
                            color: Color.fromARGB(238, 211, 213, 218),
                            spreadRadius: -1.0,
                            offset: Offset(1, 1),
                            blurRadius: 1.0,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 40,
                              child: Card(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                        width: 40,
                                        child: Center(child: Text('No.'))),
                                    SizedBox(
                                        width: 100,
                                        child: Center(child: Text('Bank'))),
                                    SizedBox(
                                        width: 150,
                                        child: Center(child: Text('วันที่'))),
                                    SizedBox(
                                        width: 100,
                                        child: Center(child: Text('เวลา'))),
                                    SizedBox(
                                        width: 120,
                                        child:
                                            Center(child: Text('จำนวนเงิน'))),
                                    SizedBox(
                                        width: 120,
                                        child: Center(child: Text('หมายเหตุ'))),
                                    SizedBox(
                                        width: 40,
                                        child: Center(child: Text('ลบ'))),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          lPaymentRemark.isEmpty
                              ? const Center(
                                  child: Text('Select Remark'),
                                )
                              : Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListView.builder(
                                        itemCount: lPaymentRemark.length,
                                        itemBuilder: (context, index) {
                                          return Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  SizedBox(
                                                    width: 40,
                                                    child: Center(
                                                        child: Text(
                                                            '${index + 1}')),
                                                  ),
                                                  //! DropDown
                                                  SizedBox(
                                                      width: 100,
                                                      child: _buildDropdownBank(
                                                          lPaymentRemark[index]
                                                              .tlpayment_d_remark_bank,
                                                          index)),
                                                  //! Text DateNow (InkWall =>Calendar)
                                                  TextFormFieldDate(
                                                      formatDate: lPaymentRemark[
                                                              index]
                                                          .tlpayment_d_remark_date,
                                                      isStatusScreen:
                                                          widget.isStatusScreen,
                                                      callbackDate: (re_Date) {
                                                        lPaymentRemark[index]
                                                                .tlpayment_d_remark_date =
                                                            re_Date;
                                                        setState(() {});
                                                      },
                                                      callbackIsClose: (isc) {
                                                        isClose = isc;

                                                        isCheckClosePopUp();
                                                        setState(() {});
                                                      }),
                                                  //! Text Time
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8.0),
                                                    child: TextFormFieldTime(
                                                        formatTime: lPaymentRemark[
                                                                index]
                                                            .tlpayment_d_remark_time,
                                                        isStatusScreen: widget
                                                            .isStatusScreen,
                                                        callbackTime:
                                                            (re_Time) {
                                                          lPaymentRemark[index]
                                                                  .tlpayment_d_remark_time =
                                                              re_Time;

                                                          print('object');
                                                          print(lPaymentRemark[
                                                                      index]
                                                                  .tlpayment_d_remark_time =
                                                              re_Time);
                                                          setState(() {});
                                                        },
                                                        callbackIsClose: (isc) {
                                                          isClose = isc;
                                                          isCheckClosePopUp();
                                                          setState(() {});
                                                        }),
                                                  ),
                                                  //! Text Amount
                                                  TextFormFieldAmount(
                                                      formatAmount: lPaymentRemark[
                                                              index]
                                                          .tlpayment_d_remark_amount,
                                                      isStatusScreen:
                                                          widget.isStatusScreen,
                                                      callbackAmount: (amount) {
                                                        lPaymentRemark[index]
                                                                .tlpayment_d_remark_amount =
                                                            amount;
                                                        setState(() {});
                                                      },
                                                      callbackIsClose: (isc) {
                                                        isClose = isc;
                                                        isCheckClosePopUp();
                                                        setState(() {});
                                                      }),
                                                  //! Comment
                                                  TextFormFieldComment(
                                                      comment: lPaymentRemark[
                                                              index]
                                                          .tlpayment_d_remark_comment,
                                                      isStatusScreen:
                                                          widget.isStatusScreen,
                                                      callbackComment:
                                                          (cComment) {
                                                        lPaymentRemark[index]
                                                                .tlpayment_d_remark_comment =
                                                            cComment;
                                                        setState(() {});
                                                      }),
                                                  //! icon Delete
                                                  IconButton(
                                                      focusNode: FocusNode(
                                                          onKey: (node, event) {
                                                        if (event.isKeyPressed(
                                                            LogicalKeyboardKey
                                                                .tab)) {
                                                          if (widget.isStatusScreen ==
                                                                  'New' ||
                                                              widget.isStatusScreen ==
                                                                  'create' ||
                                                              widget.isStatusScreen ==
                                                                  'reject') {
                                                            newRemark();
                                                          }
                                                        }
                                                        return KeyEventResult
                                                            .ignored;
                                                      }),
                                                      icon: Icon(
                                                        Icons.delete_forever,
                                                        color: widget.isStatusScreen ==
                                                                    'waiting' ||
                                                                widget.isStatusScreen ==
                                                                    'confirm'
                                                            ? Colors.grey[400]
                                                            : Colors.red[200],
                                                      ),
                                                      onPressed: () {
                                                        if (widget.isStatusScreen ==
                                                                'New' ||
                                                            widget.isStatusScreen ==
                                                                'create' ||
                                                            widget.isStatusScreen ==
                                                                'reject') {
                                                          widget.callbackRemove(
                                                              lPaymentRemark[
                                                                      index]
                                                                  .tlpayment_d_remark_id);

                                                          lPaymentRemark
                                                              .removeAt(index);

                                                          print(lPaymentRemark);
                                                          List<PaymentDetailRemarkModel>
                                                              lPaymentRemarkTemp =
                                                              [];

                                                          lPaymentRemarkTemp
                                                              .addAll(
                                                                  lPaymentRemark);
                                                          lPaymentRemark = [];
                                                          setState(() {});

                                                          Future.delayed(
                                                              const Duration(
                                                                  milliseconds:
                                                                      20), () {
                                                            setState(() {
                                                              lPaymentRemark =
                                                                  lPaymentRemarkTemp;
                                                              isClose = true;
                                                              isCheckClosePopUp();
                                                            });
                                                          });
                                                        }
                                                      })
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 24,
                  bottom: 24,
                  child: InkWell(
                    onHover: (hover) {
                      setState(() {
                        isHover = hover;
                      });
                    },
                    onTap: () {
                      if (widget.isStatusScreen == 'New' ||
                          widget.isStatusScreen == 'create' ||
                          widget.isStatusScreen == 'reject') {
                        newRemark();
                      }
                    },
                    child: Icon(
                      Icons.add_circle,
                      color: widget.isStatusScreen == 'waiting' ||
                              widget.isStatusScreen == 'confirm'
                          ? Colors.grey[400]
                          : isHover
                              ? Colors.green[600]
                              : Colors.green,
                      size: 42,
                      shadows: [
                        Shadow(
                            offset: const Offset(1, 1),
                            color: widget.isStatusScreen == 'waiting' ||
                                    widget.isStatusScreen == 'confirm'
                                ? Colors.grey
                                : Color.fromARGB(255, 56, 129, 58),
                            blurRadius: 1)
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }

  void isCheckClosePopUp() {
    for (var ee in lPaymentRemark) {
      if (ee.tlpayment_d_remark_date.isEmpty ||
          ee.tlpayment_d_remark_time.isEmpty ||
          ee.tlpayment_d_remark_amount.isEmpty) {
        isClose = false;
      }
    }
  }

  void newRemark() {
    String tlpayment_d_remark_id =
        '${TlConstant.runID()}${lPaymentRemark.length.toString().padLeft(3, '0')}';

    var newDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    PaymentDetailRemarkModel newPDRM = PaymentDetailRemarkModel(
        tlpayment_d_remark_id: tlpayment_d_remark_id,
        tlpayment_detail_id: widget.paymentDetailId,
        tlpayment_id: widget.paymentId,
        tlpayment_d_remark_bank: 'KBANK',
        tlpayment_d_remark_date: DateFormat('yyyy-MM-dd').format(newDate),
        tlpayment_d_remark_time: '',
        tlpayment_d_remark_amount: '',
        tlpayment_d_remark_comment: '');
    lPaymentRemark.add(newPDRM);

    widget.callbackAdd(lPaymentRemark);
    setState(() {
      isClose = false;
    });
  }

  DropdownButton _buildDropdownBank(String tlpayment_d_remark_bank, int index) {
    return DropdownButton<String>(
      isExpanded: true,
      value: tlpayment_d_remark_bank,
      icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.blueGrey),
      elevation: 16,
      style: const TextStyle(color: Colors.blueGrey),
      underline: Container(
        height: 0,
        //color: Colors.blueGrey,
      ),
      onChanged: (String? value) {
        if (widget.isStatusScreen == 'New' ||
            widget.isStatusScreen == 'create' ||
            widget.isStatusScreen == 'reject') {
          setState(() {
            tlpayment_d_remark_bank = value!;
            print('siteDDValue :: $tlpayment_d_remark_bank');
            lPaymentRemark[index].tlpayment_d_remark_bank =
                tlpayment_d_remark_bank;
          });
        }
      },
      items: lBank.map<DropdownMenuItem<String>>((String value) {
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
}
