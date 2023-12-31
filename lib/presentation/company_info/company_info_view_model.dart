import 'package:flutter/material.dart';
import 'package:flutter_stocks_app/domain/repository/stock_repository.dart';
import 'package:flutter_stocks_app/presentation/company_info/company_info_state.dart';

class  CompanyInfoViewModel with ChangeNotifier {
  final StockRepository _repository;
  var _state = CompanyInfoState();

  CompanyInfoState get state => _state;

  CompanyInfoViewModel(this._repository, String symbol){
    loadCompanyInfo(symbol);
  }

  Future<void> loadCompanyInfo(String symbol) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners(); // 이벤트 감지
    // 실제 데이터 가져오기
    final result = await _repository.getCompanyInfo(symbol);
    result.when(
      success: (info) {
        _state = state.copyWith(
          companyInfo: info,
          isLoading: false,
          errorMessage: null,
        );
      },
      error: (e) {
        _state = state.copyWith(
          companyInfo: null,
          isLoading: false,
          errorMessage: e.toString(),
        );
      } ,
    );
    notifyListeners(); // 이벤트 감지
    // 주식 그래프 정보
  final intradayInfo = await _repository.getIntradayInfo(symbol);
  intradayInfo.when(
    success: (infos) {
      _state = state.copyWith(
        stockInfos: infos,
        isLoading: false,
        errorMessage: null,
      );
    },
    error: (e) {
      _state = state.copyWith(
          stockInfos: [],
          isLoading: false,
          errorMessage: e.toString(),
      );
    },
  );
  }
}
