import 'package:csv/csv.dart';
import 'package:flutter_stocks_app/data/csv/csv_parser.dart';
import 'package:flutter_stocks_app/domain/model/company_listing.dart';

class CompanyListingsParser implements CsvParser<CompanyListing>{
  // 데이터 전체 불러오기
  @override
  Future<List<CompanyListing>> parse(String csvString) async{
    List<List<dynamic>> csvValues = const CsvToListConverter().convert(csvString);

    //원하는 데이터를 조작해서 사용하기
    csvValues.remove(0); // csv 파일의 0번쨰 파일이 삭제 되었다.

    return csvValues.map((e) {
      final symbol = e[0] ?? '';
      final name = e[1] ?? '';
      final exchange= e[2] ?? '';
      final assetType= e[3] ?? '';
      final ipoDate= e[4] ?? '';
      return CompanyListing(symbol: symbol, name: name, exchange: exchange,assetType:assetType,
          ipoDate: ipoDate);
    }).where((e) => e.symbol.isNotEmpty&& e.name.isNotEmpty &&e.exchange.isNotEmpty &&
        e.assetType.isNotEmpty&&e.ipoDate.isNotEmpty)
    // 상징 이름 교환 날짜등 원하는 null 아닌 데이터만
        .toList(); // 상징 이름 교환 날짜등 원하는 데이터를 리스트로 변환하기
  }
}