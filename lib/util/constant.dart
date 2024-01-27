import 'dart:math';

class TlConstant {
  //workstepupdate
  //static const String syncApi = 'http://localhost:80/apiTLSmartCashier/';
  static const String syncApi =
      'https://e-cashier.thonglorpet.com/apiTLSmartCashier/';

  static final String version = 'TL670127V007';
  static final String token = 'epyTtnemyaPegnahCipa';

  //r แก้ connect.php เป็น .5
  //r แก้ API getDF Collection
  //r แก้ version
  //r แก้ syncApi to dfreport

  static String runID() => DateTime.now().millisecondsSinceEpoch.toString();
  static String random() => Random().nextInt(999).toString().padLeft(3, '0');
}
