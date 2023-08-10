import 'package:flutter_stocks_app/domain/model/company_listing.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_listings_state.freezed.dart';

part 'company_listings_state.g.dart';

@freezed
class CompanyListingsState with _$CompanyListingsState {
  factory CompanyListingsState({
    @Default([])List<CompanyListing> companies, // 내용
    @Default(false)bool isLoading, // 로딩
    @Default(false)bool isRefreshing,// 리모트 리프레쉬
    @Default('')String searchQuery, // 쿼리
  }) = _CompanyListingsState;
  
  factory CompanyListingsState.fromJson(Map<String, dynamic> json) => _$CompanyListingsStateFromJson(json);
}