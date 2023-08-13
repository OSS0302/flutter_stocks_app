import 'package:csv/csv.dart';
import 'package:flutter_stocks_app/data/csv/csv_parser.dart';
import 'package:flutter_stocks_app/data/mapper/intraday_info_mapper.dart';
import 'package:flutter_stocks_app/data/source/remote/dto/intraday_info_dto.dart';
import 'package:flutter_stocks_app/domain/model/intraday_info.dart';

class IntradayInfoParser implements CsvParser<IntradayInfo>{
  @override
  Future<List<IntradayInfo>> parse(String csvString) async {
    List<List<dynamic>> csvValues =
    const CsvToListConverter().convert(csvString);

    //원하는 데이터를 조작해서 사용하기
    csvValues.removeAt(0); // csv 파일의 0번 파일이 삭제 되었다.
  
    return csvValues.map((e) {
      final timestamp = e[0] ?? '';
      final close =e[4]?? 0.0;
      final dto = IntradayInfoDto(timestamp: timestamp, close: close);
      return dto.toIntradayInfo();
    }).toList();
  }
}