import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TextFormFieldTime extends StatefulWidget {
  String formatTime;
  String isStatusScreen;
  Function callbackTime;
  Function callbackIsClose;

  TextFormFieldTime(
      {required this.formatTime,
      required this.isStatusScreen,
      required this.callbackTime,
      required this.callbackIsClose,
      super.key});

  @override
  State<TextFormFieldTime> createState() => _TextFormFieldTimeState();
}

class _TextFormFieldTimeState extends State<TextFormFieldTime> {
  TextEditingController hh = TextEditingController();
  TextEditingController mm = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.formatTime != '') {
      final splittedTime = widget.formatTime.split(':');
      hh.text = splittedTime[0];
      mm.text = splittedTime[1];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        color: widget.isStatusScreen == 'waiting' ||
                widget.isStatusScreen == 'confirm'
            ? Colors.grey[300]
            : null,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                readOnly: widget.isStatusScreen == 'waiting' ||
                        widget.isStatusScreen == 'confirm'
                    ? true
                    : false,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^[0-9]{0,3}$'),
                  ),
                ],
                textAlign: TextAlign.center,
                controller: hh,
                onChanged: (vv) {
                  if (vv.isEmpty) {
                    vv = '';
                    hh.text = '';
                    widget.callbackTime('');
                    widget.callbackIsClose(false);
                  } else if (int.parse(vv) > 23) {
                    vv = '00';
                    hh.text = '00';
                  }
                  if (vv.length > 2) {
                    vv = '00';
                    hh.text = '00';
                  }

                  if (hh.text.isEmpty || mm.text.isEmpty || vv.isEmpty) {
                    widget.callbackIsClose(false);
                    widget.callbackTime('');
                  } else {
                    final fHh = hh.text.toString().padLeft(2, '0');
                    final fmm = mm.text.toString().padLeft(2, '0');
                    widget.callbackTime('${fHh}:${fmm}:00');
                    widget.callbackIsClose(true);
                  }
                },
              ),
            ),
            const Text(':'),
            Expanded(
              child: TextFormField(
                readOnly: widget.isStatusScreen == 'waiting' ||
                        widget.isStatusScreen == 'confirm'
                    ? true
                    : false,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^[0-9]{0,3}$'),
                  ),
                ],
                textAlign: TextAlign.center,
                controller: mm,
                onChanged: (vv) {
                  if (vv.isEmpty) {
                    vv = '';
                    mm.text = '';
                    widget.callbackTime('');
                    widget.callbackIsClose(false);
                  } else if (int.parse(vv) > 60) {
                    vv = '00';
                    mm.text = '00';
                  }
                  if (vv.length > 2) {
                    vv = '00';
                    mm.text = '00';
                  }

                  if (hh.text.isEmpty || mm.text.isEmpty) {
                    widget.callbackTime('');
                    widget.callbackIsClose(false);
                  } else {
                    final fHh = hh.text.toString().padLeft(2, '0');
                    final fmm = mm.text.toString().padLeft(2, '0');
                    widget.callbackTime('${fHh}:${fmm}:00');
                    widget.callbackIsClose(true);
                  }
                },
              ),
            ),
          ],
        ));
  }
}
