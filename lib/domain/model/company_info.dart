
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_info.freezed.dart';

part 'company_info.g.dart';

@freezed
class CompanyInfo with _$CompanyInfo {
  factory CompanyInfo({
    required String symbol, // 상징
    required String description,//설명
    required String name, //이름
    required String country, //나라
    required String industry, // 오늘 주식정보

  }) = _CompanyInfo;
  
  factory CompanyInfo.fromJson(Map<String, dynamic> json) => _$CompanyInfoFromJson(json); 
}