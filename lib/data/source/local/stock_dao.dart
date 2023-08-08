import 'package:flutter_stocks_app/data/source/local/company_listing_entity.dart';
import 'package:hive/hive.dart';

class StockDao {
  //dao 객체는 db를 접근하는 그런기능을 모아놓는 클래스 다.

  static const companyListing = 'companyListing'; // 상수로 선언해서 사용하면 오타를 줄일수있다.

  final box = Hive.box('stock.db'); // 박스 이름을 stock.db라고 한다.

  // 데이터를 다루는 함수
  // 추가
  Future<void> insertCompanyListings(
      List<CompanyListingEntity> companyListingEntity) async {
    await box.put(StockDao.companyListing,
        companyListingEntity); // key같은경우에는 상수로 정의하는게 사용하는게 안전하다.
  }

  //클리어
  Future<void> clearCompanyListing() async {
    await box.clear(); // 박스 초기화
  }

  //검색
  Future<List<CompanyListingEntity>> searchCompanyListing(String query) async {
    final List<CompanyListingEntity> companyListing = box.get(
        StockDao.companyListing,
        defaultValue: <CompanyListingEntity>[]); // key 를 던지면 dynmic으로 반환한다.
    return companyListing;
  }
}