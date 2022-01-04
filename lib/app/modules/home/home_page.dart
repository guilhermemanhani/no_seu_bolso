import 'package:decimal/decimal.dart';
import 'package:decimal/intl.dart';
import 'package:dentro_do_bolso/app/models/account_model.dart';
import 'package:dentro_do_bolso/app/modules/home/home_controller.dart';
import 'package:dentro_do_bolso/app/modules/home/widget/container_budget.dart';
import 'package:dentro_do_bolso/app/modules/home/widget/head_home.dart';
import 'package:dentro_do_bolso/app/modules/home/widget/line_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:pie_chart/pie_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  final reactionDisposer = <ReactionDisposer>[];
  var formatter = NumberFormat.decimalPattern('pt-BR');
  @override
  void initState() {
    super.initState();
    final autoRunDisposer = autorun(
      (_) {
        controller.loadHome();
        // controller.loadAccounts();
        // controller.findPeriod();
        // controller.getExpenseByLocal();
      },
    );
    reactionDisposer.add(autoRunDisposer);
  }

  @override
  void dispose() {
    super.dispose();
    for (var element in reactionDisposer) {
      element();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Observer(
          builder: (_) {
            return Column(
              children: [
                Observer(
                  builder: (_) {
                    return HeadHome(
                      value: controller.dealMoneyValue(formatter.format(
                          DecimalIntl(controller.accountInfoModel?.balance ??
                              Decimal.parse('0.0')))),
                    );
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                Observer(
                  builder: (_) {
                    return LineAccount(
                      accountList: controller.accountInfoModel?.listAccount ??
                          <AccountModel>[],
                    );
                  },
                ),
                Observer(
                  builder: (_) {
                    return ContainerBudget(
                      entryD: controller.entry,
                      exitD: controller.exit,
                      entry: controller.dealMoneyValue(formatter.format(
                          DecimalIntl(
                              Decimal.parse(controller.entry.toString())))),
                      exit: controller.dealMoneyValue(formatter.format(
                          DecimalIntl(
                              Decimal.parse(controller.exit.toString())))),
                      budgetUse: controller
                          .dealMoneyValue(controller.mathValueBudget()),
                      entryxsaida: controller.dealMoneyValue(formatter.format(
                          DecimalIntl(
                              Decimal.parse(controller.entry.toString()) -
                                  Decimal.parse(controller.exit.toString())))),
                    );
                  },
                ),
                Observer(
                  builder: (_) {
                    if (controller.dataMapExit.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: PieChart(
                          dataMap: controller.dataMapExit,
                          chartType: ChartType.ring,
                          centerText: 'Saídas',
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValueBackground: true,
                            showChartValues: true,
                            chartValueBackgroundColor: Colors.transparent,
                            decimalPlaces: 0,
                            showChartValuesInPercentage: true,
                            showChartValuesOutside: false,
                          ),
                        ),
                      );
                    } else if (controller.expenseLocalObs == null ||
                        controller.expenseLocalObs!.isEmpty) {
                      return Container(
                        color: Colors.grey,
                      );
                    } else {
                      return Container(
                        color: Colors.red,
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Observer(
                  builder: (_) {
                    if (controller.dataMapEntry.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: PieChart(
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValueBackground: true,
                            showChartValues: true,
                            chartValueBackgroundColor: Colors.transparent,
                            decimalPlaces: 0,
                            showChartValuesInPercentage: true,
                            showChartValuesOutside: false,
                          ),
                          dataMap: controller.dataMapEntry,
                          chartType: ChartType.ring,
                          centerText: 'Entradas',
                        ),
                      );
                    } else if (controller.expenseLocalObs == null ||
                        controller.expenseLocalObs!.isEmpty) {
                      return Container(
                        color: Colors.grey,
                      );
                    } else {
                      return Container(
                        color: Colors.red,
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/home/cadastar/');
          controller.loadHome();
        },
        child: const Icon(Icons.payment),
      ),
    );
  }
}
