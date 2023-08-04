import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_listing.freezed.dart';

part 'company_listing.g.dart';

@freezed
class CompanyListing with _$CompanyListing {
  factory CompanyListing({
    required String symbol,
    required String name,
    required String exchange,
    required String ipoDate,

  }) = _CompanyListing;
  
  factory CompanyListing.fromJson(Map<String, dynamic> json) => _$CompanyListingFromJson(json); 
}