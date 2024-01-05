// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../models/employee_model.dart';

class ExamScreen extends StatefulWidget {
  List<EmployeeModel> lEmp;
  ExamScreen({required this.lEmp, super.key});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
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
              child: Container(
                child: const Center(
                  child: Text('ExamScreen'),
                ),
              )),
          Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(36))),
                child: const Center(
                  child: Text('ExamScreen'),
                ),
              )),
        ]),
      ),
    );
  }
}
