import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import '../../const/app_constants.dart';
import '../../provider/transaction_provider.dart';
import '../../const/variables.dart';

class StatisticalDataScreen extends StatefulWidget {
  const StatisticalDataScreen({super.key});

  @override
  State<StatisticalDataScreen> createState() => _StatisticalDataScreenState();
}

class _StatisticalDataScreenState extends State<StatisticalDataScreen> {
  final transactionProvider = Provider.of<TransactionProvider>(
      AppConstants.globalNavKey.currentContext!);

  List<_Data> replenishmentDataSet = [];
  List<_Data> transferDataSet = [];
  List<_Data> withdrawalDataSet = [];
  List<_OverviewData> overviewDataSet = [];

  @override
  void initState() {
    transactionProvider.loadTransaction();
    getReplenishmentList();
    getTransferList();
    getWithdrawalList();
    getOverviewList();
    super.initState();
  }

  getReplenishmentList() {
    transactionProvider.users.forEach((element) {
      if (element.operationType == replenishmentOperation) {
        replenishmentDataSet.add(_Data(element.date, element.total));
        return replenishmentDataSet.sort((a, b) => a.month.compareTo(b.month));
      }
    });
  }

  getTransferList() {
    transactionProvider.users.forEach((element) {
      if (element.operationType == transferOperation) {
        transferDataSet.add(_Data(element.date, element.total));
        return transferDataSet.sort((a, b) => a.month.compareTo(b.month));
      }
    });
  }

  getWithdrawalList() {
    transactionProvider.users.forEach((element) {
      if (element.operationType == withdrawalOperation) {
        withdrawalDataSet.add(_Data(element.date, element.total));
        return withdrawalDataSet.sort((a, b) => a.month.compareTo(b.month));
      }
    });
  }

  getOverviewList() {
    transactionProvider.users.forEach((element) {
      return overviewDataSet
          .add(_OverviewData(element.operationType, element.total));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        const SizedBox(
          height: 20.0,
        ),
        SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            title: ChartTitle(
                text: 'Yearly Replenishment Analysis',
                textStyle: const TextStyle(
                    fontSize: 14.0, fontWeight: FontWeight.w800)),
            legend: const Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<_Data, String>>[
              LineSeries<_Data, String>(
                  dataSource: replenishmentDataSet,
                  xValueMapper: (_Data sales, _) => sales.month,
                  yValueMapper: (_Data sales, _) => sales.amount,
                  name: 'Replenishment',
                  dataLabelSettings: const DataLabelSettings(isVisible: true))
            ]),
        const SizedBox(
          height: 20.0,
        ),
        SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            title: ChartTitle(
                text: 'Yearly Transfer Analysis',
                textStyle: const TextStyle(
                    fontSize: 14.0, fontWeight: FontWeight.w800)),
            legend: const Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<_Data, String>>[
              LineSeries<_Data, String>(
                  dataSource: transferDataSet,
                  xValueMapper: (_Data sales, _) => sales.month,
                  yValueMapper: (_Data sales, _) => sales.amount,
                  name: 'Transfer',
                  // Enable data label
                  dataLabelSettings: const DataLabelSettings(isVisible: true))
            ]),
        const SizedBox(
          height: 20.0,
        ),
        SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            title: ChartTitle(
                text: 'Yearly Withdrawal Analysis',
                textStyle: const TextStyle(
                    fontSize: 14.0, fontWeight: FontWeight.w800)),
            legend: const Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<_Data, String>>[
              LineSeries<_Data, String>(
                  dataSource: withdrawalDataSet,
                  xValueMapper: (_Data sales, _) => sales.month,
                  yValueMapper: (_Data sales, _) => sales.amount,
                  name: 'Withdrawal',
                  dataLabelSettings: const DataLabelSettings(isVisible: true))
            ]),
        const SizedBox(
          height: 20.0,
        ),
        SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            title: ChartTitle(
                text: 'Yearly Operations Analysis',
                textStyle: const TextStyle(
                    fontSize: 14.0, fontWeight: FontWeight.w800)),
            legend: const Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<_OverviewData, String>>[
              LineSeries<_OverviewData, String>(
                  dataSource: overviewDataSet,
                  xValueMapper: (_OverviewData sales, _) => sales.type,
                  yValueMapper: (_OverviewData sales, _) => sales.amount,
                  name: 'Operations',
                  dataLabelSettings: const DataLabelSettings(isVisible: true))
            ]),
        const SizedBox(
          height: 1000.0,
        ),
      ]),
    ));
  }
}

class _Data {
  _Data(this.month, this.amount);

  final String month;
  final double amount;
}

class _OverviewData {
  _OverviewData(this.type, this.amount);

  final String type;
  final double amount;
}
