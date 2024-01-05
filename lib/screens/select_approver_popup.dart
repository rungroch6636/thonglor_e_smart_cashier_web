import 'package:action_slider/action_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:thonglor_e_smart_cashier_web/models/employeeFullName_model.dart';
import 'package:thonglor_e_smart_cashier_web/models/paymentApproval_model.dart';
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
  List<EmployeeFullNameModel> lEmpApprover = [];

  List<String> lEmpApproverShow = ['-- เลือกผู้ตรวจสอบ --'];
  String empApproverValue = '-- เลือกผู้ตรวจสอบ --';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(milliseconds: 1000), () async {
      await loadEmpApprover();
      empApproverValue = lEmpApproverShow.first;
    });
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
                      'เลือกผู้ตรวจเอกสารปิดเวร',
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
                    child: lEmpApproverShow.isEmpty
                        ? Text('Loading..')
                        : Row(
                            children: [
                              Expanded(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: _buildDropdownEmpApprover(),
                              )),
                            ],
                          )),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ActionSlider.standard(
                  height: 50,
                  child: empApproverValue == '-- เลือกผู้ตรวจสอบ --'
                      ? const Text('เลือก ผู้ตรวจสอบ ก่อนทำการยืนยัน ')
                      : const Text('เลื่อน Slider เพื่อยืนยัน ผู้ตรวจสอบ'),
                  action: (controller) async {
                    if (empApproverValue == '-- เลือกผู้ตรวจสอบ --') {
                    } else {
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
                    }
                    //starts success animation
                  },
                  backgroundColor: Colors.green[100],
                  toggleColor: Colors.green,
                ),
              )
            ],
          ),
        ));
  }

  DropdownButton _buildDropdownEmpApprover() {
    return DropdownButton<String>(
      isExpanded: true,
      value: empApproverValue,
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
          empApproverValue = value!;
        });
      },
      items: lEmpApproverShow.map<DropdownMenuItem<String>>((String value) {
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

  Future loadEmpApprover() async {
    FormData formData =
        FormData.fromMap({"token": TlConstant.token, "site_id": widget.siteId});
    String api = '${TlConstant.syncApi}employee.php?id=approver';
    lEmpApprover = [];
    await Dio().post(api, data: formData).then((value) {
      if (value.data == null) {
        print('Employee Null !');
      } else {
        for (var empApp in value.data) {
          EmployeeFullNameModel newEmpApp =
              EmployeeFullNameModel.fromMap(empApp);
          lEmpApprover.add(newEmpApp);
        }
        for (var e in lEmpApprover) {
          lEmpApproverShow.add("${e.emp_fullname}:${e.employee_id}");
        }
      }
    });
    setState(() {});
  }

  Future createPaymentApproval() async {
    String dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String timeNow = DateFormat('HH:mm:ss').format(DateTime.now());

    var splitEmp = empApproverValue.split(':');
    var appEmp = splitEmp[1];

    String tlpayment_approval_id =
        '${TlConstant.runID()}${TlConstant.random()}';

    FormData formData = FormData.fromMap({
      "token": TlConstant.token,
      "tlpayment_approval_id": tlpayment_approval_id,
      "tlpayment_id": widget.paymentId,
      "emp_id_approver": appEmp,
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
