import 'package:flutter_stocks_app/data/source/local/company_listing_entity.dart';
import 'package:flutter_stocks_app/data/source/remote/dto/company_info_dto.dart';
import 'package:flutter_stocks_app/domain/model/company_info.dart';
import 'package:flutter_stocks_app/domain/model/company_listing.dart';

extension ToCompanyListing on CompanyListingEntity {
  //CompanyListingEntity 에다가 기능을  추가한다.
  CompanyListing toCompanyListing() {
    return CompanyListing(
      symbol: symbol,
      name: name,
      exchange: exchange,
      assetType: assetType,
      ipoDate: ipoDate,
    );
  }
}
// 반대의경우
extension ToCompanyListingEntity on CompanyListing {
  //CompanyListingEntity 에다가 기능을  추가한다.
  CompanyListingEntity toCompanyListingEntity() {
    return CompanyListingEntity(
      symbol: symbol,
      name: name,
      exchange: exchange,
      assetType: assetType,
      ipoDate: ipoDate,
    );
  }
}

extension ToCompanyInfo on CompanyInfoDto{
  CompanyInfo toCompanyInfo() {
    return CompanyInfo(symbol: symbol ?? '',
      description: description?? '',
      name: name?? '',
      country: country?? '',
      industry: industry?? '',);
  }
}