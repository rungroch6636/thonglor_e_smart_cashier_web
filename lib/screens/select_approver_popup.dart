import 'package:action_slider/action_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:thonglor_e_smart_cashier_web/models/employee_model.dart';

import 'package:thonglor_e_smart_cashier_web/util/constant.dart';
import 'package:intl/intl.dart';

class SelectApproverPopup extends StatefulWidget {
  String paymentId;
  String empid;
  String siteId;
  Function callbackUpdate;
  Function callbackClear;
  SelectApproverPopup(
      {required this.paymentId,
      required this.empid,
      required this.siteId,
      required this.callbackUpdate,
      required this.callbackClear,
      super.key});

  @override
  State<SelectApproverPopup> createState() => _SelectApproverPopupState();
}

class _SelectApproverPopupState extends State<SelectApproverPopup> {
  List<EmployeeModel> lEmpApprover = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          height: 300,
          width: 600,
          child: Column(
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
                      'ยืนยันการส่งตรวจสอบตรวจสอบ',
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
                padding: const EdgeInsets.all(20.0),
                child: ActionSlider.standard(
                  height: 50,
                  child: const Text('เลื่อน Slider เพื่อยืนยัน '),
                  action: (controller) async {
                    controller.loading(); //starts loading animation
                    await Future.delayed(const Duration(milliseconds: 1200),
                        () async {
                      await createPaymentApproval();
                      widget.callbackUpdate();
                    }); //starts success animation
                    controller.success();
                    await Future.delayed(const Duration(milliseconds: 1200),
                        () {
                      widget.callbackClear();
                      Navigator.pop(context);
                    });
                    //starts success animation
                  },
                  backgroundColor: Colors.green[100],
                  toggleColor: Colors.green,
                ),
              ),
              SizedBox()
            ],
          ),
        ));
  }

  Future createPaymentApproval() async {
    String dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String timeNow = DateFormat('HH:mm:ss').format(DateTime.now());
    String tlpayment_approval_id =
        '${TlConstant.runID()}${TlConstant.random()}';

    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "tlpayment_approval_id": tlpayment_approval_id,
      "tlpayment_id": widget.paymentId,
      "tlpayment_approve_by": '',
      "emp_id_request": widget.empid,
      "tlpayment_approve_date": '',
      "tlpayment_approve_time": '',
      "tlpayment_request_date": dateNow,
      "tlpayment_request_time": timeNow,
      "tlpayment_approve_status": 'waiting',
    });
    String api = '${TlConstant.syncApi}tlPaymentApproval.php?id=create';

    await Dio().post(api, data: formData);
  }
}
