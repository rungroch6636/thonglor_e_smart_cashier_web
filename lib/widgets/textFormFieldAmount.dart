import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TextFormFieldAmount extends StatefulWidget {
  String formatAmount;
  String isStatusScreen;
  Function callbackAmount;
  Function callbackIsClose;

  TextFormFieldAmount(
      {required this.formatAmount,
      required this.isStatusScreen,
      required this.callbackAmount,
      required this.callbackIsClose,
      super.key});

  @override
  State<TextFormFieldAmount> createState() => _TextFormFieldAmountState();
}

class _TextFormFieldAmountState extends State<TextFormFieldAmount> {
  TextEditingController amount = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.formatAmount != '') {
      amount.text = widget.formatAmount;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 120,
          color: widget.isStatusScreen ==
                                                              'waiting' ||
                                                          widget.isStatusScreen ==
                                                              'confirm'
                                                      ? Colors.grey[300] 
                                                      : null, 
        child: TextFormField(
          readOnly: widget.isStatusScreen ==
                                                                'waiting' ||
                                                            widget.isStatusScreen ==
                                                                'confirm'
                                                        ? true
                                                        : false, // 'New'  'create' 'reject'
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'^\d*\.?\d{0,2}$'),
            ),
          ],
          textAlign: TextAlign.right,
          controller: amount,
          onChanged: (vv) {
            if (vv.isEmpty || double.parse(vv) == 0) {
              widget.callbackIsClose(false);
            }
            if (amount.text.isEmpty) {
              widget.callbackIsClose(false);
            } else {
              widget.callbackAmount(amount.text);
              widget.callbackIsClose(true);
            }
          },
        ));
  }
}
