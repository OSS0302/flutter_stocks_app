import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_listings_action.freezed.dart';

@freezed
abstract class CompanyListingsAction with _$CompanyListingsAction {
  const factory CompanyListingsAction.refresh() = Refresh; // 새로고침
  const factory CompanyListingsAction.onSearchQueryChange(String query) = onSearchQueryChange; // 검색
 }