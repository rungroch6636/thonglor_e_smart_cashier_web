import 'dart:math';

class TlConstant {
  //workstepupdate
  //static const String syncApi = 'http://localhost:80/apiTLSmartCashier/';
  static const String syncApi =
      'https://e-cashier.thonglorpet.com/apiTLSmartCashier/';

  static final String version = 'TL670317V022';
  static final String token = 'epyTtnemyaPegnahCipa';

  static String runID() => DateTime.now().millisecondsSinceEpoch.toString();
  static String random() => Random().nextInt(999).toString().padLeft(3, '0');
}

/*
  flutter build web --web-renderer canvaskit
  flutter pub get
  flutter clean
*/