import 'dart:convert';

import 'package:flutter_stocks_app/data/source/remote/dto/company_info_dto.dart';
import 'package:http/http.dart' as http;

class StockApi {
  //http
  static const baseUrl = 'https://www.alphavantage.co/'; // 홈이페지 주소
  static const apiKey = 'U80NMMGLBQOFOAJL'; // 키 넣기

  final http.Client _client; //통신하기 위해서 클라이언트 정의해야한다
  StockApi({http.Client? client}) : _client=(client ?? http.Client()); // 생성자 추가

  Future<http.Response> getListings({String apiKey = apiKey}) async {
    // 주식 이름 리스트
    // Response 객체 로 이제 데이터가 들어간다.
    return await _client.get(
        Uri.parse('$baseUrl/query?function=LISTING_STATUS&apikey=$apiKey'));
  }

  Future<CompanyInfoDto> getCompanyInfo({ // 주식 정보 가져오기
    required String symbol,
    String apiKey = apiKey,}) async {
    // Response 객체 로 이제 데이터가 들어간다.
    final response = await _client.get(Uri.parse(
        '$baseUrl/query?function=OVERVIEW&symbol=$symbol&apikey=$apiKey'));
     return CompanyInfoDto.fromJson(jsonDecode(response.body));
  }
  // 하루 주식 정보 추가
  Future<http.Response> getIntradayInfo({
    required String symbol,
    String apiKey =apiKey,
    }) async {
    return await _client.get(
        Uri.parse('$baseUrl/query?function=TIME_SERIES_INTRADAY&symbol=$symbol&interval=60min&apikey=$apiKey&datatype=csv'));
  }
}
