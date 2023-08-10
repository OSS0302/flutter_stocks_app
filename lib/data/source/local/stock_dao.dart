import 'package:flutter_stocks_app/data/source/local/company_listing_entity.dart';
import 'package:hive/hive.dart';
class StockDao {
  //dao 객체는 db를 접근하는 그런기능을 모아놓는 클래스 다.
  static const companyListing = 'companyListing'; // 상수로 선언해서 사용하면 오타를 줄일수있다.
  // 데이터를 다루는 함수
  // 추가
  Future<void> insertCompanyListings(
      List<CompanyListingEntity> companyListingEntities) async {
    final box = await Hive.openBox<CompanyListingEntity>(
        'stock.db'); // 박스 이름을 stock.db라고 한다. 상수로 지정해야한다.
    await box.addAll(
        companyListingEntities); // key같은경우에는 상수로 정의하는게 사용하는게 안전하다.addAll 리터어블 키가 필요없다.
  }
  //클리어
  Future<void> clearCompanyListing() async {
    final box = await Hive.openBox<CompanyListingEntity>('stock.db');
    await box.clear(); // 박스 초기화
  }
  //검색
  Future<List<CompanyListingEntity>> searchCompanyListing(String query) async {
    final box = await Hive.openBox<CompanyListingEntity>('stock.db');
    final List<CompanyListingEntity> companyListing = box.values.toList();
    return companyListing // 검색어 를 가지고 이름하고 상징 하고 비교해서 겹치는 게있으면 겹치는걸 리턴한다.
        .where((e) =>
            e.name.toLowerCase().contains(query.toLowerCase()) ||
            query.toUpperCase() == e.symbol)
        .toList();
  }
}
