import 'package:flutter_stocks_app/data/source/remote/dto/intraday_info_dto.dart';
import 'package:flutter_stocks_app/domain/model/intraday_info.dart';
import 'package:intl/intl.dart';

extension ToIntradayInfo on IntradayInfoDto {
  IntradayInfo toIntradayInfo() {
    // 2022-06-27 19:15:00
    final formatter = DateFormat('yyyy-mm-dd HH:mm:ss');
    return IntradayInfo(
      date: formatter.parse(timestamp),
      close: close,
    );
  }
}
