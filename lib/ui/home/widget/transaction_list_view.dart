import 'package:flutter/material.dart';

import '../../../const/image_const.dart';
import '../../../model/transaction_model.dart';

class TransactionListView extends StatelessWidget {
  final GestureTapCallback? onTap;
  final TransactionModel transaction;

  const TransactionListView({super.key, this.onTap, required this.transaction});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: InkWell(
          onTap: onTap,
          child: Card(
            elevation: 3,
            child: Container(
              width: w,
              height: 100.0,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 20.0,
                      child: Text(
                        transaction.transactionNumber,
                        style: const TextStyle(
                            fontFamily: "FiraSans",
                            fontWeight: FontWeight.w100,
                            fontSize: 12.0),
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Text(
                              transaction.type.substring(0, 1).toUpperCase(),
                              style: const TextStyle(
                                  fontFamily: "Lora",
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  fontSize: 16.0),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding:
                                  const EdgeInsets.only(left: 5.0, bottom: 5.0),
                              alignment: Alignment.bottomLeft,
                              height: 30,
                              child: Text(
                                transaction.type,
                                style: const TextStyle(
                                    fontFamily: "Lora",
                                    fontWeight: FontWeight.w800,
                                    fontSize: 12.0),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            alignment: Alignment.center,
                            height: 28.0,
                            child: Text(
                              "\$ ${transaction.amount.toStringAsFixed(2).toString()}",
                              style: const TextStyle(
                                  fontFamily: "FiraSans",
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18.0),
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              alignment: Alignment.center,
                              width: 50.0,
                              height: 100.0,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Image.asset(ImageConst.arrowImage),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
