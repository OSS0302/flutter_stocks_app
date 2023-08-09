import 'package:flutter_stocks_app/data/csv/company_listings_parser.dart';
import 'package:flutter_stocks_app/data/mapper/company_mapper.dart';
import 'package:flutter_stocks_app/data/source/local/stock_dao.dart';
import 'package:flutter_stocks_app/data/source/remote/stock_api.dart';
import 'package:flutter_stocks_app/domain/model/company_listing.dart';
import 'package:flutter_stocks_app/domain/repository/stock_repository.dart';
import 'package:flutter_stocks_app/util/result.dart';

class StockRepositoryImpl implements StockRepository{
  final StockApi _api;
  final StockDao _dao;
  final _parser = CompanyListingsParser();

  StockRepositoryImpl(this._api, this._dao);

  @override
  Future<Result<List<CompanyListing>>> getCompanyListings(
      bool fetchFromRemote, String query) async{
    // 1. 캐시를 찾는다//쿼리는 위에 선언 된 쿼리를  전달해서 받는다.
  final localListings = await _dao.searchCompanyListing(query);

  //없다면 리모트에서 찾는다.
  final isDbEmpty = localListings.isEmpty&& query.isEmpty;
  final shouldJustLoadFromCache = !isDbEmpty && !fetchFromRemote;

  // 캐시
  if(shouldJustLoadFromCache){
    return Result.success(
      localListings.map((e) => e.toCompanyListing()).toList());
  }
  // 리모트 인  경우에는 에러 에 빠질 수있으므로
  try {
    final response = await _api.getListings();
    final remoteListings = await _parser.parse(response.body);
    // 캐시를 비우기
    await _dao.clearCompanyListing();

     // 캐시를 추가
    await _dao.insertCompanyListings(
      remoteListings.map((e) => e.toCompanyListingEntity()).toList() //toCompanyListingEntity 로변환해서 db에 저장했다.
    );
    // TODO :CSV 파싱 변환
    return Result.success(remoteListings);
  }catch (e){
    return Result.error(Exception('데이터 로드 실패 !!'));
  }
  }
}