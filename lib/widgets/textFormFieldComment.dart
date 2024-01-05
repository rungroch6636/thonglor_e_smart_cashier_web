import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TextFormFieldComment extends StatefulWidget {
  String comment;
  String isStatusScreen;
  Function callbackComment;

  TextFormFieldComment(
      {required this.comment, 
      
       required this.isStatusScreen,
      required this.callbackComment, super.key});

  @override
  State<TextFormFieldComment> createState() => _TextFormFieldCommentState();
}

class _TextFormFieldCommentState extends State<TextFormFieldComment> {
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.comment != '') {
      commentController.text = widget.comment;
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

      child:  TextFormField(
        readOnly: widget.isStatusScreen ==
                                                                'waiting' ||
                                                            widget.isStatusScreen ==
                                                                'confirm'
                                                        ? true
                                                        : false, // 'New'  'create' 'reject'
        controller: commentController,
        onChanged: (vv) {
        widget.callbackComment(commentController.text);
        },
      ),
    );

   
  }
}
