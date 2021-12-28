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
        controller.loadAccounts();
        controller.findPeriod();
        controller.getExpenseByLocal();
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
        child: Column(
          children: [
            Observer(
              builder: (_) {
                return HeadHome(
                  value: formatter.format(DecimalIntl(
                      controller.accountInfoModel?.balance ??
                          Decimal.parse('0.0'))),
                );
              },
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
                  entry: formatter.format(
                      DecimalIntl(Decimal.parse(controller.entry.toString()))),
                  exit: formatter.format(
                      DecimalIntl(Decimal.parse(controller.exit.toString()))),
                  budgetUse: formatter.format(DecimalIntl(Decimal.parse(
                      ((controller.exit / controller.entry) * 100)
                          .toString()))),
                  entryxsaida: formatter.format(DecimalIntl(
                      Decimal.parse(controller.entry.toString()) -
                          Decimal.parse(controller.exit.toString()))),
                );
              },
            ),
            Observer(
              builder: (_) {
                if (controller.dataMap.isNotEmpty) {
                  return PieChart(
                    dataMap: controller.dataMap,
                    // chartType: ChartType.ring,
                    // ringStrokeWidth: 10,

                    // centerText: 'oi',
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
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/home/cadastar/');
          controller.loadAccounts();
          controller.loadExpense();
          controller.findPeriod();
        },
        child: const Icon(Icons.payment),
      ),
    );
  }
}
