import 'package:decimal/decimal.dart';
import 'package:decimal/intl.dart';
import 'package:dentro_do_bolso/app/core/ui/extensions/size_screen_extension.dart';
import 'package:dentro_do_bolso/app/core/ui/extensions/theme_extension.dart';
import 'package:dentro_do_bolso/app/core/ui/widgets/calendar_button.dart';
import 'package:dentro_do_bolso/app/modules/home/detail/detail_account_controller.dart';
import 'package:dentro_do_bolso/app/modules/home/detail/widget/line_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

class DetailAccountPage extends StatefulWidget {
  const DetailAccountPage({Key? key}) : super(key: key);

  @override
  _DetailAccountPageState createState() => _DetailAccountPageState();
}

class _DetailAccountPageState
    extends ModularState<DetailAccountPage, DetailAccountController> {
  final reactionDisposer = <ReactionDisposer>[];
  final formatDate = DateFormat('dd-MM-yyyy');

  var formatter = NumberFormat.decimalPattern('pt-BR');
  @override
  void initState() {
    super.initState();
    final autoRunDisposer = autorun(
      (_) {
        controller.findPeriod();
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
      appBar: AppBar(
        title: const Text('Extrato'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Observer(
            builder: (_) {
              return Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CalendarButton(
                      onChanged: (val) =>
                          controller.setSelectedInitialDate(val),
                      selectdDate: controller.selectedInitialDate,
                      width: 150.w,
                      buttonLabel: 'Data início',
                    ),
                  ),
                  CalendarButton(
                    onChanged: (val) => controller.setSelectedFinalDate(val),
                    selectdDate: controller.selectedFinalDate,
                    width: 150.w,
                    buttonLabel: 'Data final',
                  ),
                  IconButton(
                    color: context.darkBlue,
                    padding: const EdgeInsets.only(left: 8),
                    onPressed: () => controller.findPeriod(),
                    icon: const Icon(Icons.search),
                  ),
                ],
              );
            },
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: Observer(
              builder: (_) {
                return Container(
                  child: controller.expenseObs == null
                      ? Container()
                      : ListView.builder(
                          itemCount: controller.expenseObs!.length,
                          itemBuilder: (context, index) {
                            var expense = controller.expenseObs![index];
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        LineInfo(
                                          iconOne:
                                              Icons.monetization_on_outlined,
                                          iconTwo: Icons.description,
                                          textOne: controller.dealMoneyValue(
                                              formatter.format(DecimalIntl(
                                                  Decimal.parse(expense.valor
                                                      .toString())))),
                                          textTwo: expense.descricao ?? "",
                                        ),
                                        LineInfo(
                                          iconOne: Icons.pin_drop_outlined,
                                          iconTwo: Icons.date_range_outlined,
                                          textOne: expense.local!,
                                          textTwo: formatDate
                                              .format(expense.datahora),
                                        ),
                                        expense.tpagamento == 0
                                            ? Container(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: Colors.red[100],
                                                ),
                                                child: Icon(
                                                  Icons.arrow_circle_down_sharp,
                                                  color: context.red,
                                                ),
                                              )
                                            : Container(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: Colors.green[100],
                                                ),
                                                child: Icon(
                                                  Icons.arrow_circle_up_sharp,
                                                  color: context.green,
                                                ),
                                              )
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: context.darkBlue,
                                ),
                              ],
                            );
                          },
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
