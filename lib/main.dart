import 'package:flutter/material.dart';
import 'package:flutter_stocks_app/data/source/local/company_listing_entity.dart';
import 'package:flutter_stocks_app/data/source/local/stock_dao.dart';
import 'package:flutter_stocks_app/data/source/remote/stock_api.dart';
import 'package:flutter_stocks_app/data/repository/stock_repository_impl.dart';
import 'package:flutter_stocks_app/domain/repository/stock_repository.dart';
import 'package:flutter_stocks_app/presentation/company_listings/company_listings_screen.dart';
import 'package:flutter_stocks_app/presentation/company_listings/company_listings_view_model.dart';
import 'package:flutter_stocks_app/util/color_schemes.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CompanyListingEntityAdapter());
  final repository = StockRepositoryImpl(
    StockApi(),
    StockDao(),
  );
    // get it
  GetIt.instance.registerSingleton<StockRepository> (repository);// 사용하면 어디서나 쉽게 쓸수있다

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CompanyListingsViewModel(
              repository,
            ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 밝은 모드
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      //타크모드
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      themeMode: ThemeMode.system,

      // 시스템의 테마를 따라간다. 본인의 스마트폰이 타크모드이면 타크모드가된다.
      home: const CompanyListingsScreen(),
    );
  }
}
