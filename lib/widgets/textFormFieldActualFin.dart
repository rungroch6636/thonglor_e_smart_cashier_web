import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TextFormFieldActualFin extends StatefulWidget {
  String actualFin;
  String finLeftMenuStatus;
  Function callbackActualFin;

  TextFormFieldActualFin(
      {required this.actualFin,
      required this.finLeftMenuStatus,
      required this.callbackActualFin,
      super.key});

  @override
  State<TextFormFieldActualFin> createState() => _TextFormFieldActualFinState();
}

class _TextFormFieldActualFinState extends State<TextFormFieldActualFin> {
  double dTotalActual = 0.0;
  TextEditingController tActualFinController = TextEditingController();
  final oCcy = NumberFormat(
    "#,##0.00",
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tActualFinController.text = widget.actualFin;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.finLeftMenuStatus == 'create' ||
              widget.finLeftMenuStatus == 'nodata'
          ? Colors.transparent
          : Colors.grey[300],
      child: TextFormField(
        style: TextStyle(fontSize: 14),
        readOnly: widget.finLeftMenuStatus == 'create' ||
                widget.finLeftMenuStatus == 'nodata'
            ? false // 'New'
            : true,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 15),
        ),
        textAlign: TextAlign.end,
        controller: tActualFinController,
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            RegExp(r'^-?\d*\.?\d{0,2}$'),
          ),
        ],
        onChanged: (value) {
          if (value.isEmpty) {
            value = '0';
            tActualFinController.text = '0';
          }
          widget.callbackActualFin(tActualFinController.text);
          setState(() {});
        },
      ),
    );
  }
}
