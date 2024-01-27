import 'dart:convert';
import 'dart:html';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:thonglor_e_smart_cashier_web/models/employee_model.dart';
import 'package:thonglor_e_smart_cashier_web/util/constant.dart';

import 'main_menu_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<EmployeeModel> lEmployee = [];

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isCheckLogin = false; //false;
  bool isHover = false;
  bool _passwordVisible = false;

  @override
  void initState() {
    //userController.text = 'rungroch_k'; //'arunrat_b'; //'nipaporn';
    //passwordController.text = '8888'; //'0635644228';
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Width : ${MediaQuery.of(context).size.width}');
    print('Height : ${MediaQuery.of(context).size.height}');
    return Material(
      child: Container(
          color: Colors.grey[100],
          child: Stack(
            children: [
              Positioned(
                left: (MediaQuery.of(context).size.width / 2) -
                    ((MediaQuery.of(context).size.width / 3) / 2),
                bottom: 2.0,
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 3,
                  child: Tooltip(
                      message: 'version : ${TlConstant.version}',
                      child: Image.asset('images/bg_login.png')),
                ),
              ),
              Positioned(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 36),
                        child: Text(
                          TlConstant.syncApi ==
                                  'xhttp://localhost:80/apiTLSmartCashier/'
                              ? 'e-SMART CASHIER TEST'
                              : 'e-SMART CASHIER',
                          style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: TlConstant.syncApi ==
                                      'xhttp://localhost:80/apiTLSmartCashier/'
                                  ? Colors.red
                                  : Colors.green[800]),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: TextFormField(
                            autofocus: true,
                            controller: userController,
                            onChanged: (value) {
                              if (isCheckLogin == true) {
                                isCheckLogin = false;
                                setState(() {});
                              }
                            },
                            onFieldSubmitted: (value) {
                              processConfirmLogin(context);
                            },
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'User',
                            )),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: TextFormField(
                            textInputAction: TextInputAction.go,
                            onFieldSubmitted: (value) {
                              processConfirmLogin(context);
                            },
                            onChanged: (value) {
                              if (isCheckLogin == true) {
                                isCheckLogin = false;
                                setState(() {});
                              }
                            },
                            controller: passwordController,
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 20,
                        child: isCheckLogin
                            ? const Center(
                                child: Text(
                                  'Please Check User Password',
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            : null,
                      ),
                      SizedBox(
                        height: 60,
                        width: MediaQuery.of(context).size.width / 5,
                        child: Card(
                          elevation: 4,
                          shadowColor: Color.fromARGB(99, 143, 144, 145),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1.0,
                                color: isHover
                                    ? const Color.fromARGB(199, 27, 94, 31)
                                    : Color.fromARGB(100, 156, 157, 160),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          color: Color.fromARGB(230, 255, 255, 255),
                          child: InkWell(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                            hoverColor:
                                const Color.fromARGB(171, 200, 230, 201),
                            onHover: (select) {
                              isHover = select;
                              setState(() {});
                            },
                            onTap: () {
                              processConfirmLogin(context);
                            },
                            child: Center(
                                child: Text(
                              ' LOG IN ',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: isHover
                                      ? Colors.green[900]
                                      : Colors.green),
                            )),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Future<void> processConfirmLogin(BuildContext context) async {
    lEmployee.clear();
    var token = TlConstant.token;
    var userLogin = userController.text;
    var passwordConvert = generateMd5(passwordController.text);

    FormData formData = FormData.fromMap({
      "token": token,
      "employee_id": userLogin,
      "password": passwordConvert,
    });
    await Dio()
        .post("${TlConstant.syncApi}employee.php?id=imedprofile",
            data: formData)
        .then((value) {
      if (value.data == null) {
        setState(() {
          isCheckLogin = true;
        });
      } else {
        for (var emp in value.data) {
          EmployeeModel newEmp = EmployeeModel.fromMap(emp);
          lEmployee.add(newEmp);
        }
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MainMenuScreen(
                        lEmp: lEmployee,
                      )));
        });
      }
    });
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }
}
