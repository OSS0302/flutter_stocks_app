import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_listing.freezed.dart';

part 'company_listing.g.dart';

@freezed
class CompanyListing with _$CompanyListing {
  factory CompanyListing({
    required String symbol, // 상징
    required String name, // 이름
    required String exchange, // 교환
    required String ipoDate, // 날짜

  }) = _CompanyListing;
  
  factory CompanyListing.fromJson(Map<String, dynamic> json) => _$CompanyListingFromJson(json); 
}