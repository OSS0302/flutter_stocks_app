import 'package:hive_flutter/adapters.dart';

part 'company_listing_entity.g.dart';
@HiveType(typeId: 0)
class CompanyListingEntity extends HiveObject{
  @HiveField(0)
  String symbol;
  @HiveField(1)
  String name;
  @HiveField(2)
  String exchange;
  @HiveField(3)
  String ipoDate;

  CompanyListingEntity({ // 생성자 추가
   required this.symbol,
   required this.name,
   required this.exchange,
   required this.ipoDate,
  });
}
