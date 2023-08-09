import 'package:flutter_stocks_app/domain/model/company_listing.dart';
import 'package:flutter_stocks_app/util/result.dart';

abstract class StockRepository{
  Future<Result<List<CompanyListing>>> getCompanyListings(
    bool fetchFromRemote,
    String query,
  );
}