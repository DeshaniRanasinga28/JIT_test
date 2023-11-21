import 'package:flutter/material.dart';
import 'package:jit_test/const/color_const.dart';
import 'package:jit_test/ui/home/statistics_data_screen.dart';
import 'package:jit_test/ui/home/transactions_screen.dart';
import 'package:provider/provider.dart';

import '../../commen_widget/custom_dialog_box.dart';
import '../../const/string_const.dart';
import '../../provider/auth_provider.dart';
import '../login/login_screen.dart';
import '../transactions/create_transactions_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: ColorPalette.black,
          actions: [
            IconButton(
              onPressed: () => _addTransaction(context),
              icon: const Icon(
                Icons.add,
                color: ColorPalette.white,
              ),
            ),
            IconButton(
              // onPressed: () => _logout(context),
              onPressed: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialogBox(
                          height: 292.0,
                          description: StringConst.logoutMsgLabel,
                          onPressed: () => _logout(context));
                    });
              },
              icon: const Icon(
                Icons.logout,
                color: ColorPalette.white,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              TabBar(
                unselectedLabelColor: Colors.black,
                labelColor: Colors.blue,
                indicatorColor: Colors.black,
                indicatorWeight: 5,
                labelStyle: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: "FiraSans"),
                tabs: const [
                  Tab(
                    text: StringConst.transactionsLabel,
                  ),
                  Tab(
                    text: StringConst.statisticsLabel,
                  )
                ],
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
              ),
              SizedBox(
                width: w,
                height: h + 350.0,
                child: TabBarView(
                  controller: _tabController,
                  children: const <Widget>[
                    Expanded(child: TransactionScreen()),
                    Expanded(child: StatisticalDataScreen()),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _logout(BuildContext context) async {
    await Provider.of<AuthProvider>(context, listen: false).logout();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void _addTransaction(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateTransactionScreen()),
    );
  }
}
