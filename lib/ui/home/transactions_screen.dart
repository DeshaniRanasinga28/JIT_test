import 'package:flutter/material.dart';
import 'package:jit_test/ui/home/widget/transaction_list_view.dart';
import 'package:jit_test/ui/transactions/view_transactions.dart';
import 'package:provider/provider.dart';

import '../../const/app_constants.dart';
import '../../const/string_const.dart';
import '../../model/transaction_model.dart';
import '../../provider/transaction_provider.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final transactionProvider = Provider.of<TransactionProvider>(
      AppConstants.globalNavKey.currentContext!);

  @override
  void initState() {
    transactionProvider.loadTransaction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Consumer<TransactionProvider>(
          builder: (context, transactionProvider, _) {
        return transactionProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : transactionProvider.users.isEmpty
                ? const Center(
                    child: Text(
                    StringConst.dataNotFoundLabel,
                    style: TextStyle(fontSize: 18),
                  ))
                : Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: w,
                          height: 20.0,
                          child: Text(
                              "${StringConst.noOfTransactionsLabel} : ${transactionProvider.users.length}"),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 20.0, bottom: 10.0),
                          child: ListView.builder(
                            itemCount: transactionProvider.users.length,
                            itemBuilder: (context, index) {
                              final transaction =
                                  transactionProvider.users[index];
                              return TransactionListView(
                                onTap: () => _viewDetails(context, transaction),
                                transaction: transaction,
                              );
                            },
                          ),
                        ),
                      ],
                    ));
      }),
    );
  }

  void _viewDetails(BuildContext context, TransactionModel transaction) async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ViewTransactionScreen(user: transaction)),
    );
  }
}
