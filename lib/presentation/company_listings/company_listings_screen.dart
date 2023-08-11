import 'package:flutter/material.dart';
import 'package:flutter_stocks_app/presentation/company_listings/company_listings_view_model.dart';
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
                onChanged:(query){
                  //TODO: 쿼리를 이용해서 검색
                } ,
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
                  // TODO:  새로고침
                },
                child: ListView.builder(
                    itemCount: state.companies.length,
                    itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(state.companies[index].name),
                      ),
                      Divider(color: Theme.of(context).colorScheme.secondary,),
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
