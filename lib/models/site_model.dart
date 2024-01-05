// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class SiteModel {
  String site_id;
  String site_name;
  SiteModel({
    required this.site_id,
    required this.site_name,
  });

  SiteModel copyWith({
    String? site_id,
    String? site_name,
  }) {
    return SiteModel(
      site_id: site_id ?? this.site_id,
      site_name: site_name ?? this.site_name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'site_id': site_id,
      'site_name': site_name,
    };
  }

  factory SiteModel.fromMap(Map<String, dynamic> map) {
    return SiteModel(
      site_id: map['site_id'] as String,
      site_name: map['site_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SiteModel.fromJson(String source) => SiteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SiteModel(site_id: $site_id, site_name: $site_name)';

  @override
  bool operator ==(covariant SiteModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.site_id == site_id &&
      other.site_name == site_name;
  }

  @override
  int get hashCode => site_id.hashCode ^ site_name.hashCode;
}
