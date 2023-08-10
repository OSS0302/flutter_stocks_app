import 'package:flutter_stocks_app/data/source/local/company_listing_entity.dart';
import 'package:flutter_stocks_app/data/source/local/stock_dao.dart';
import 'package:flutter_stocks_app/data/source/remote/stock_api.dart';
import 'package:flutter_stocks_app/data/source/stock_repository_impl.dart';
import 'package:flutter_stocks_app/presentation/company_listings/compnay_listings_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

void main(){
  Hive.init(null);
  Hive.registerAdapter(CompanyListingEntityAdapter());
  test('company_listings_view_model 생성시 데이터를 잘 가져와야한다', () async{
    //StockRepositoryImpl
    final _api = StockApi();
    final _Dao = StockDao();
    final viewModel =CompanyListingsViewMdoel(StockRepositoryImpl(_api, _Dao));

    // 데이터 오는 시간이 필요해서 3초 딜레이 주겠습니다'
    await Future.delayed(const Duration(seconds: 3));

    expect(viewModel.state.companies.isNotEmpty, true);
  });
}