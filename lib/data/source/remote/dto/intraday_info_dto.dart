import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'intraday_info_dto.freezed.dart';

part 'intraday_info_dto.g.dart';

@freezed
class IntradayInfoDto with _$IntradayInfoDto {
  factory IntradayInfoDto({
    required String timestamp, // 시간
    required double close, // 종각

  }) = _IntradayInfoDto;

  factory IntradayInfoDto.fromJson(Map<String, dynamic> json) => _$IntradayInfoDtoFromJson(json);
}