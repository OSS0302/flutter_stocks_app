import 'package:flutter/material.dart';
import 'package:flutter_stocks_app/domain/repository/stock_repository.dart';
import 'package:flutter_stocks_app/presentation/company_listings/company_listings_action.dart';
import 'package:flutter_stocks_app/presentation/company_listings/company_listings_state.dart';

import 'dart:async';
class CompanyListingsViewModel with ChangeNotifier {
  final StockRepository _repository;
  var _state =   CompanyListingsState(); //디폴트 값을 넣어줘서 아무것도 세팅을 안해도되며

  Timer? _debounce; //불필요한 동작 을 줄이기위해서 시간을 준다.

  CompanyListingsState get state => _state; //  getter 를 통해서 외부에서 조작할 수있도록 한다.

  CompanyListingsViewModel(this._repository) {
    // 이부분에 유스 케이스 가 들어가도 되지만 이 프로젝트에서 기능이 적어서 레포지토리를 가져온다.
    // 데이터를 로드 하겠따.그래서 _state를 채우겠다.
    _getCompanyListing();
  }

  void onAction(CompanyListingsAction action) {
    // 새로고침과 검색 두가지 기능을 사용자가 하게된다.
    action.when(
      refresh: ()=> _getCompanyListing(fetchFromRemote: true),// 리모트 해서 강제 콜해서 리스트를 불러온다.
      onSearchQueryChange: (query) {
        _debounce?.cancel();
        _debounce= Timer(const Duration (milliseconds: 500), (){
          // db에서 동작한다.
          _getCompanyListing(query: query); // 위애 쿼리를 가져와서   _getCompanyListing(query: query)로 들어간다.
        });
      },
    );
  }

  Future _getCompanyListing({
    bool fetchFromRemote = false, // 리모트값을 가지오지 않는게 디폴트이고
    String query = '', // 쿼리는 디폴트가 '' 입니다.
  }) async {
    // 데이터를 읽어오는 로직 // _getCompanyListing({}): named parameter 주면 됩니다.
    _state = state.copyWith(
      // copyWith해서 isLoading: true값만 변경하고
      isLoading: true,
    );
    notifyListeners(); // 이벤트 감지
    // 실제 데이터 가져오는 로직
    final reuslt = await _repository.getCompanyListings(fetchFromRemote, query);
    reuslt.when(
      success: (listings) {
        // 성공시 내용물 변경
        _state = state.copyWith(
          companies: listings,
        );
      },
      error: (e) {
        //TODO: 에러처리
         print('리모트 에러 $e');
      },
    );

    // 끝나면 fale 로 변경
    _state = state.copyWith(
      isLoading: false,
    );
    notifyListeners(); // 이벤트 감지
  }
}
