import 'package:flutter/material.dart';
import 'package:jit_test/model/transaction_model.dart';
import 'package:jit_test/ui/home/home_screen.dart';
import 'package:provider/provider.dart';

import '../../commen_widget/custom_dialog_box.dart';
import '../../commen_widget/custom_elevated_button.dart';
import '../../commen_widget/custom_snack_bar.dart';
import '../../const/color_const.dart';
import '../../const/string_const.dart';
import '../../provider/transaction_provider.dart';

class ViewTransactionScreen extends StatefulWidget {
  final TransactionModel user;

  const ViewTransactionScreen({super.key, required this.user});

  @override
  State<ViewTransactionScreen> createState() => _ViewTransactionScreenState();
}

class _ViewTransactionScreenState extends State<ViewTransactionScreen> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColorPalette.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SizedBox(
        width: w,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: w,
                alignment: Alignment.center,
                child: Container(
                  alignment: Alignment.center,
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Text(
                    widget.user.type.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                        fontFamily: "Lora",
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: 28.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                width: w,
                alignment: Alignment.center,
                child: const Text(
                  StringConst.transactionSummaryLabel,
                  style: TextStyle(
                      fontFamily: "Lora",
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      fontSize: 20.0),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              const Text(
                StringConst.transactionDateLabel,
                style: TextStyle(
                    fontFamily: "FiraSans",
                    fontWeight: FontWeight.w800,
                    color: Colors.black45,
                    fontSize: 14.0),
              ),
              Text(widget.user.date),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                StringConst.amountLabel,
                style: TextStyle(
                    fontFamily: "FiraSans",
                    fontWeight: FontWeight.w800,
                    color: Colors.black45,
                    fontSize: 14.0),
              ),
              Text(widget.user.amount.toStringAsFixed(2).toString()),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                StringConst.commissionLabel,
                style: TextStyle(
                    fontFamily: "FiraSans",
                    fontWeight: FontWeight.w800,
                    color: Colors.black45,
                    fontSize: 14.0),
              ),
              Text(widget.user.commission.toStringAsFixed(2).toString()),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                StringConst.totalLabel,
                style: TextStyle(
                    fontFamily: "FiraSans",
                    fontWeight: FontWeight.w800,
                    color: Colors.black45,
                    fontSize: 14.0),
              ),
              Text(widget.user.total.toStringAsFixed(2).toString()),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                StringConst.transactionNumberLabel,
                style: TextStyle(
                    fontFamily: "FiraSans",
                    fontWeight: FontWeight.w800,
                    color: Colors.black45,
                    fontSize: 14.0),
              ),
              Text(widget.user.transactionNumber.toString()),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                StringConst.typeOfOperationLabel,
                style: TextStyle(
                    fontFamily: "FiraSans",
                    fontWeight: FontWeight.w800,
                    color: Colors.black45,
                    fontSize: 14.0),
              ),
              Text(widget.user.operationType.toString()),
              const SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: CustomElevatedButton(
          // onPressed: () => transactionCancel(context),
          onPressed: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return CustomDialogBox(
                    height: 292.0,
                    description: StringConst.cancelTransactionLabel,
                    onPressed: () => transactionCancel(context),
                  );
                });
          },
          label: StringConst.cancelLabel,
        ),
      ),
    );
  }

  transactionCancel(BuildContext context) {
    final transactionModel = TransactionModel(
        id: widget.user.id,
        type: widget.user.type,
        transactionNumber: widget.user.transactionNumber,
        amount: widget.user.amount,
        date: widget.user.date,
        commission: widget.user.commission,
        total: widget.user.total,
        operationType: widget.user.operationType,
        status: "cancel");
    Provider.of<TransactionProvider>(context, listen: false)
        .updateTransaction(transactionModel);
    navigateToHome(context);
    CustomSnackBar.showSnackBar(
        "The ${widget.user.transactionNumber} ${StringConst.cancelTransactionLabel2}");
  }

  navigateToHome(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }
}
