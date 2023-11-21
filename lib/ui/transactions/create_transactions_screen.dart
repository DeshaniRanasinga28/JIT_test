import 'package:flutter/material.dart';
import 'package:jit_test/ui/home/home_screen.dart';
import 'package:jit_test/ui/home/transactions_screen.dart';
import 'package:provider/provider.dart';

import '../../commen_widget/custom_elevated_button.dart';
import '../../commen_widget/custom_text_form_field.dart';
import '../../const/color_const.dart';
import '../../const/string_const.dart';
import '../../model/transaction_model.dart';
import '../../provider/transaction_provider.dart';

class CreateTransactionScreen extends StatefulWidget {
  const CreateTransactionScreen({super.key});

  @override
  State<CreateTransactionScreen> createState() =>
      _CreateTransactionScreenState();
}

class _CreateTransactionScreenState extends State<CreateTransactionScreen> {
  final TextEditingController typeController = TextEditingController();
  final TextEditingController transactionNumberController =
      TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController commissionController = TextEditingController();
  final TextEditingController totalController = TextEditingController();
  final TextEditingController operationTypeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.black,
        title: const Text(
          StringConst.createTransactionLabel,
          style: TextStyle(color: ColorPalette.white),
        ),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                CustomTextFormField(
                  controller: typeController,
                  labelText: StringConst.typeOfTransactionLabel,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                CustomTextFormField(
                  controller: transactionNumberController,
                  labelText: StringConst.transactionNumberLabel,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                CustomTextFormField(
                  controller: amountController,
                  labelText: StringConst.amountLabel,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                CustomTextFormField(
                  controller: dateController,
                  labelText: StringConst.transactionDateLabel,
                ),
                // const SizedBox(
                //   height: 20.0,
                // ),
                // CustomTextFormField(
                //   controller: commissionController,
                //   labelText: StringConst.commissionLabel,
                // ),
                // const SizedBox(
                //   height: 20.0,
                // ),
                // CustomTextFormField(
                //   controller: totalController,
                //   labelText: StringConst.totalLabel,
                // ),
                const SizedBox(
                  height: 20.0,
                ),
                CustomTextFormField(
                  controller: operationTypeController,
                  labelText: StringConst.typeOfOperationLabel,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: CustomElevatedButton(
          onPressed: () => _submitForm(context),
          label: StringConst.saveLabel,
        ),
      ),
    );
  }

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final transaction = TransactionModel(
          type: typeController.text,
          transactionNumber: transactionNumberController.text,
          amount: double.parse(amountController.text),
          date: dateController.text,
          commission: double.parse(amountController.text) * 10 / 100,
          total: double.parse(amountController.text) +
              (double.parse(amountController.text) * 10 / 100),
          operationType: operationTypeController.text,
          status: 'active');

      Provider.of<TransactionProvider>(context, listen: false)
          .addTransaction(transaction);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
      clearControllers();
    }
  }

  clearControllers() {
    typeController.clear();
    transactionNumberController.clear();
    amountController.clear();
    dateController.clear();
    commissionController.clear();
    totalController.clear();
    operationTypeController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    typeController.dispose();
    transactionNumberController.dispose();
    amountController.dispose();
    dateController.dispose();
    commissionController.dispose();
    totalController.dispose();
    operationTypeController.dispose();
  }
}
