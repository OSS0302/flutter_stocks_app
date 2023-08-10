import 'package:flutter_stocks_app/data/csv/company_listings_parser.dart';
import 'package:flutter_stocks_app/data/source/remote/stock_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test('네트워크 통신',()async{
    final response = await StockApi().getListings();
    final _parser = CompanyListingsParser();
    final remoteListings= await _parser.parse(response.body);

    expect(remoteListings[1].symbol, 'A');
    expect(remoteListings[1].name,'Agilent Technologies Inc');
    expect(remoteListings[1].exchange,'NYSE');
    expect(remoteListings[1].assetType,'Stock');
    expect(remoteListings[1].ipoDate,'1999-11-18');
  });
}