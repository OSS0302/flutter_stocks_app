import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_info_dto.freezed.dart';

part 'company_info_dto.g.dart';

@freezed
class CompanyInfoDto with _$CompanyInfoDto {
  factory CompanyInfoDto({
   @JsonKey(name: 'Symbol')String? symbol, // 상징
   @JsonKey(name: 'Description') String? description, //설명
   @JsonKey(name: 'Name')String? name,//이름
   @JsonKey(name: 'Country')String? country, //나라
   @JsonKey(name: 'Industry')String? industry, // 오늘 주식정보
    
  }) = _CompanyInfoDto;
  
  factory CompanyInfoDto.fromJson(Map<String, dynamic> json) => _$CompanyInfoDtoFromJson(json); 
}