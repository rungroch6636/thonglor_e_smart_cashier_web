// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SumRecReview {
  String emp;
  String sumOpd;
  String sumIpd;
  String sumPaid;
  String sumPaidGo;
  String sumCash;
  String detailSumCash;
  String countStatusCreate;
  String countStatusWaiting;
  String countStatusConfirm;
  String countStatusReject;
  String countStatusCancel;
  String countStatusNoData;
  SumRecReview({
    required this.emp,
    required this.sumOpd,
    required this.sumIpd,
    required this.sumPaid,
    required this.sumPaidGo,
    required this.sumCash,
    required this.detailSumCash,
    required this.countStatusCreate,
    required this.countStatusWaiting,
    required this.countStatusConfirm,
    required this.countStatusReject,
    required this.countStatusCancel,
    required this.countStatusNoData,
  });

  SumRecReview copyWith({
    String? emp,
    String? sumOpd,
    String? sumIpd,
    String? sumPaid,
    String? sumPaidGo,
    String? sumCash,
    String? detailSumCash,
    String? countStatusCreate,
    String? countStatusWaiting,
    String? countStatusConfirm,
    String? countStatusReject,
    String? countStatusCancel,
    String? countStatusNoData,
  }) {
    return SumRecReview(
      emp: emp ?? this.emp,
      sumOpd: sumOpd ?? this.sumOpd,
      sumIpd: sumIpd ?? this.sumIpd,
      sumPaid: sumPaid ?? this.sumPaid,
      sumPaidGo: sumPaidGo ?? this.sumPaidGo,
      sumCash: sumCash ?? this.sumCash,
      detailSumCash: detailSumCash ?? this.detailSumCash,
      countStatusCreate: countStatusCreate ?? this.countStatusCreate,
      countStatusWaiting: countStatusWaiting ?? this.countStatusWaiting,
      countStatusConfirm: countStatusConfirm ?? this.countStatusConfirm,
      countStatusReject: countStatusReject ?? this.countStatusReject,
      countStatusCancel: countStatusCancel ?? this.countStatusCancel,
      countStatusNoData: countStatusNoData ?? this.countStatusNoData,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'emp': emp,
      'sumOpd': sumOpd,
      'sumIpd': sumIpd,
      'sumPaid': sumPaid,
      'sumPaidGo': sumPaidGo,
      'sumCash': sumCash,
      'detailSumCash': detailSumCash,
      'countStatusCreate': countStatusCreate,
      'countStatusWaiting': countStatusWaiting,
      'countStatusConfirm': countStatusConfirm,
      'countStatusReject': countStatusReject,
      'countStatusCancel': countStatusCancel,
      'countStatusNoData': countStatusNoData,
    };
  }

  factory SumRecReview.fromMap(Map<String, dynamic> map) {
    return SumRecReview(
      emp: map['emp'] as String,
      sumOpd: map['sumOpd'] as String,
      sumIpd: map['sumIpd'] as String,
      sumPaid: map['sumPaid'] as String,
      sumPaidGo: map['sumPaidGo'] as String,
      sumCash: map['sumCash'] as String,
      detailSumCash: map['detailSumCash'] as String,
      countStatusCreate: map['countStatusCreate'] as String,
      countStatusWaiting: map['countStatusWaiting'] as String,
      countStatusConfirm: map['countStatusConfirm'] as String,
      countStatusReject: map['countStatusReject'] as String,
      countStatusCancel: map['countStatusCancel'] as String,
      countStatusNoData: map['countStatusNoData'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SumRecReview.fromJson(String source) => SumRecReview.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SumRecReview(emp: $emp, sumOpd: $sumOpd, sumIpd: $sumIpd, sumPaid: $sumPaid, sumPaidGo: $sumPaidGo, sumCash: $sumCash, detailSumCash: $detailSumCash, countStatusCreate: $countStatusCreate, countStatusWaiting: $countStatusWaiting, countStatusConfirm: $countStatusConfirm, countStatusReject: $countStatusReject, countStatusCancel: $countStatusCancel, countStatusNoData: $countStatusNoData)';
  }

  @override
  bool operator ==(covariant SumRecReview other) {
    if (identical(this, other)) return true;
  
    return 
      other.emp == emp &&
      other.sumOpd == sumOpd &&
      other.sumIpd == sumIpd &&
      other.sumPaid == sumPaid &&
      other.sumPaidGo == sumPaidGo &&
      other.sumCash == sumCash &&
      other.detailSumCash == detailSumCash &&
      other.countStatusCreate == countStatusCreate &&
      other.countStatusWaiting == countStatusWaiting &&
      other.countStatusConfirm == countStatusConfirm &&
      other.countStatusReject == countStatusReject &&
      other.countStatusCancel == countStatusCancel &&
      other.countStatusNoData == countStatusNoData;
  }

  @override
  int get hashCode {
    return emp.hashCode ^
      sumOpd.hashCode ^
      sumIpd.hashCode ^
      sumPaid.hashCode ^
      sumPaidGo.hashCode ^
      sumCash.hashCode ^
      detailSumCash.hashCode ^
      countStatusCreate.hashCode ^
      countStatusWaiting.hashCode ^
      countStatusConfirm.hashCode ^
      countStatusReject.hashCode ^
      countStatusCancel.hashCode ^
      countStatusNoData.hashCode;
  }
}
