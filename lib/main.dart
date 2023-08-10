import 'package:flutter/material.dart';
import 'package:flutter_stocks_app/data/source/local/company_listing_entity.dart';
import 'package:flutter_stocks_app/util/color_schemes.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(CompanyListingEntityAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: CompanyList
    );
  }
}

