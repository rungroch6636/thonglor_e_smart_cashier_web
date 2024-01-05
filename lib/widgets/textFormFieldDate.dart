import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldDate extends StatefulWidget {
  String formatDate;
String isStatusScreen;
  Function callbackDate;
  Function callbackIsClose;

  TextFormFieldDate(
      {required this.formatDate,

       required this.isStatusScreen,
      required this.callbackDate,
      required this.callbackIsClose,
      super.key});

  @override
  State<TextFormFieldDate> createState() => _TextFormFieldDateState();
}

class _TextFormFieldDateState extends State<TextFormFieldDate> {
  TextEditingController dd = TextEditingController();
  TextEditingController MM = TextEditingController();
  TextEditingController yyyy = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.formatDate != '') {
      final splittedTime = widget.formatDate.split('-');
      yyyy.text = splittedTime[0];
      MM.text = splittedTime[1];
      dd.text = splittedTime[2];
    } else {
      yyyy.text = DateTime.now().year.toString();
      MM.text = DateTime.now().month.toString();
      dd.text = DateTime.now().day.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150,
         color: widget.isStatusScreen ==
                                                              'waiting' ||
                                                          widget.isStatusScreen ==
                                                              'confirm'
                                                      ? Colors.grey[300] 
                                                      : null, 
        child: Row(
          children: [
            SizedBox(
              width: 60,
              child: TextFormField(
                 readOnly: widget.isStatusScreen ==
                                                                'waiting' ||
                                                            widget.isStatusScreen ==
                                                                'confirm'
                                                        ? true
                                                        : false,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d{1,4}$'),
                  ),
                ],
                textAlign: TextAlign.center,
                controller: yyyy,
                onChanged: (vv) {
                  if (vv.isEmpty) {
                    vv = DateTime.now().year.toString();
                    yyyy.text = DateTime.now().year.toString();
                  }
                  if (vv == '0') {
                    vv = DateTime.now().year.toString();
                    yyyy.text = DateTime.now().year.toString();
                  }
                  if (vv.length < 4) {
                    widget.callbackIsClose(false);
                  }
                  if (int.parse(vv) > 2500) {
                    vv = DateTime.now().year.toString();
                    yyyy.text = DateTime.now().year.toString();
                  }
                  if (yyyy.text.isEmpty || MM.text.isEmpty || dd.text.isEmpty) {
                    widget.callbackIsClose(false);
                  } else {
                    final fMM = MM.text.toString().padLeft(2, '0');
                    final fDD = dd.text.toString().padLeft(2, '0');
                    widget.callbackDate('${yyyy.text}-${fMM}-${fDD}');
                    widget.callbackIsClose(true);
                  }
                },
              ),
            ),
            const Text('-'),
            Expanded(
              child: TextFormField(
                 readOnly: widget.isStatusScreen ==
                                                                'waiting' ||
                                                            widget.isStatusScreen ==
                                                                'confirm'
                                                        ? true
                                                        : false,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d{1,2}$'),
                  ),
                ],
                textAlign: TextAlign.center,
                controller: MM,
                onChanged: (vv) {
                  if (vv.isEmpty || vv == '00') {
                    vv = DateTime.now().month.toString();
                    MM.text = DateTime.now().month.toString();
                  }
                  if (vv == '0') {
                    widget.callbackIsClose(false);
                  }

                  if (int.parse(vv) > 12) {
                    vv = DateTime.now().month.toString();
                    MM.text = DateTime.now().month.toString();
                  }
                  if (yyyy.text.isEmpty || MM.text.isEmpty || dd.text.isEmpty) {
                    widget.callbackIsClose(false);
                  } else {
                    final fMM = MM.text.toString().padLeft(2, '0');
                    final fDD = dd.text.toString().padLeft(2, '0');
                    widget.callbackDate('${yyyy.text}-${fMM}-${fDD}');
                    widget.callbackIsClose(true);
                  }
                },
              ),
            ),
            const Text('-'),
            Expanded(
              child: TextFormField(
                 readOnly: widget.isStatusScreen ==
                                                                'waiting' ||
                                                            widget.isStatusScreen ==
                                                                'confirm'
                                                        ? true
                                                        : false,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d{1,2}$'),
                  ),
                ],
                textAlign: TextAlign.center,
                controller: dd,
                onChanged: (vv) {
                  if (vv.isEmpty || vv == '00') {
                    vv = DateTime.now().day.toString();
                    dd.text = DateTime.now().day.toString();
                  }
                  if (vv == '0') {
                    widget.callbackIsClose(false);
                  }
                  String lastday = new DateTime(
                          int.parse(yyyy.text), int.parse(MM.text) + 1, 0)
                      .day
                      .toString();

                  if (int.parse(vv) > int.parse(lastday)) {
                    vv = DateTime.now().day.toString();
                    dd.text = DateTime.now().day.toString();
                  }
                  if (yyyy.text.isEmpty || MM.text.isEmpty || dd.text.isEmpty) {
                    widget.callbackIsClose(false);
                  } else {
                    final fMM = MM.text.toString().padLeft(2, '0');
                    final fDD = dd.text.toString().padLeft(2, '0');
                    widget.callbackDate('${yyyy.text}-${fMM}-${fDD}');
                    widget.callbackIsClose(true);
                  }
                },
              ),
            ),
          ],
        ));
  }
}
