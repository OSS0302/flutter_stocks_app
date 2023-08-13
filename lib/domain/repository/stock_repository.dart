import 'package:flutter_stocks_app/domain/model/company_info.dart';
import 'package:flutter_stocks_app/domain/model/company_listing.dart';
import 'package:flutter_stocks_app/domain/model/intraday_info.dart';
import 'package:flutter_stocks_app/util/result.dart';

abstract class StockRepository{
  Future<Result<List<CompanyListing>>> getCompanyListings(
    bool fetchFromRemote,
    String query,
  );
  // symbol 주어지면  그거에대한CompanyInfo를 리턴한다..
  Future<Result<CompanyInfo>> getCompanyInfo(String symbol);
  // 하루 주식 정보 추가
  Future<Result<List<IntradayInfo>>>getIntradayInfo(String symbol);
 }