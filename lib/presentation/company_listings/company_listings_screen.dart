import 'package:flutter/material.dart';
import 'package:flutter_stocks_app/domain/repository/stock_repository.dart';
import 'package:flutter_stocks_app/presentation/company_info/company_info_screen.dart';
import 'package:flutter_stocks_app/presentation/company_info/company_info_view_model.dart';
import 'package:flutter_stocks_app/presentation/company_listings/company_listings_action.dart';
import 'package:flutter_stocks_app/presentation/company_listings/company_listings_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class CompanyListingsScreen extends StatelessWidget {
  const CompanyListingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CompanyListingsViewModel>();
    final state = viewModel.state;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: TextField(
                onChanged: (query) {
                  viewModel.onAction(
                      CompanyListingsAction.onSearchQueryChange(query));
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2.0,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2.0,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  ),
                  labelText: '검색...',
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  viewModel.onAction(const CompanyListingsAction.refresh());
                },
                child: ListView.builder(
                    itemCount: state.companies.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(state.companies[index].name),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  // 뷰모델 세팅
                                  final repository = GetIt.instance<StockRepository>();// 블럭 스톡 레포지토리
                                  final symbol = state.companies[index].symbol;
                                  return ChangeNotifierProvider(
                                    create: (_) =>
                                        CompanyInfoViewModel(repository, symbol),
                                    child: const CompanyInfoScreen(),
                                  );
                                }),
                              );
                            },
                          ),
                          Divider(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
