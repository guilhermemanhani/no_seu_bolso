import 'package:decimal/decimal.dart';
import 'package:decimal/intl.dart';
import 'package:dentro_do_bolso/app/core/ui/extensions/size_screen_extension.dart';
import 'package:dentro_do_bolso/app/core/ui/extensions/theme_extension.dart';
import 'package:dentro_do_bolso/app/models/account_model.dart';
import 'package:dentro_do_bolso/app/modules/home/home_controller.dart';
import 'package:dentro_do_bolso/app/modules/home/widget/container_budget.dart';
import 'package:dentro_do_bolso/app/modules/home/widget/head_home.dart';
import 'package:dentro_do_bolso/app/modules/home/widget/line_account.dart';
import 'package:dentro_do_bolso/app/modules/home/widget/row_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

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
        child: SizedBox(
          width: 1.sw,
          height: 1.sh - 1.statusBarHeight - kToolbarHeight,
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
                    entry: formatter.format(DecimalIntl(
                        Decimal.parse(controller.entry.toString()))),
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
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: 16.0,
              //     vertical: 4.0,
              //   ),
              //   child: Container(
              //     padding: const EdgeInsets.all(8),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(15),
              //       color: Colors.white,
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.grey.withOpacity(0.5),
              //           spreadRadius: 1,
              //           blurRadius: 3,
              //           offset: const Offset(
              //             0,
              //             3,
              //           ),
              //         ),
              //       ],
              //     ),
              //     child: Column(
              //       children: [
              //         const SizedBox(
              //           height: 8,
              //         ),
              //         const Text(
              //           'Orçamento mensal',
              //           style: TextStyle(fontWeight: FontWeight.w600),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.symmetric(vertical: 4.0),
              //           child: Divider(
              //             color: context.grey,
              //             thickness: 1,
              //           ),
              //         ),
              //         Observer(
              //           builder: (_) {
              //             return RowInfo(
              //               colorText: Colors.green,
              //               title: 'Entrada',
              //               value:
              //                   'R\$: ${formatter.format(DecimalIntl(Decimal.parse(controller.entry.toString())))}',
              //             );
              //           },
              //         ),
              //         const SizedBox(
              //           height: 16,
              //         ),
              //         Observer(
              //           builder: (_) {
              //             return RowInfo(
              //               colorText: Colors.red,
              //               title: 'Saída',
              //               value:
              //                   'R\$: ${formatter.format(DecimalIntl(Decimal.parse(controller.exit.toString())))}',
              //             );
              //           },
              //         ),
              //         const SizedBox(
              //           height: 16,
              //         ),
              //         Observer(
              //           builder: (_) {
              //             return RowInfo(
              //                 colorText: controller.exit < controller.entry
              //                     ? Colors.green
              //                     : Colors.red,
              //                 title: 'Orçamento usado do mês',
              //                 value:
              //                     '% ${formatter.format(DecimalIntl(Decimal.parse(((controller.exit / controller.entry) * 100).toString())))}'
              //                 // '${((controller.exit / controller.entry))}',
              //                 );
              //           },
              //         ),
              //         const SizedBox(
              //           height: 16,
              //         ),
              //         Observer(
              //           builder: (_) {
              //             return RowInfo(
              //                 colorText: Colors.green,
              //                 title: 'Balanço entra/saída',
              //                 value: 'R\$: ${formatter.format(
              //                   DecimalIntl(Decimal.parse(
              //                           controller.entry.toString()) -
              //                       Decimal.parse(controller.exit.toString())),
              //                 )}');
              //           },
              //         ),
              //         const SizedBox(
              //           height: 16,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
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
