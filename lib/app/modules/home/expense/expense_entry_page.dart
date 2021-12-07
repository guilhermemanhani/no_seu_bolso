import 'package:dentro_do_bolso/app/core/ui/extensions/size_screen_extension.dart';
import 'package:dentro_do_bolso/app/core/ui/widgets/calendar_button.dart';
import 'package:dentro_do_bolso/app/core/ui/widgets/dentrodobolso_drop_down_button.dart';
import 'package:dentro_do_bolso/app/core/ui/widgets/dentrodobolso_text_form_field.dart';
import 'package:dentro_do_bolso/app/models/account_model.dart';
import 'package:dentro_do_bolso/app/models/local_model.dart';
import 'package:dentro_do_bolso/app/models/reasons_model.dart';
import 'package:dentro_do_bolso/app/modules/home/expense/expense_entry_controller.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

class ExpenseEntryPage extends StatefulWidget {
  const ExpenseEntryPage({Key? key}) : super(key: key);

  @override
  _ExpenseEntryPageState createState() => _ExpenseEntryPageState();
}

class _ExpenseEntryPageState
    extends ModularState<ExpenseEntryPage, ExpenseEntryController> {
  var controllerMoney = new MoneyMaskedTextController(
      decimalSeparator: ',', thousandSeparator: '.');
  final dateFormat = DateFormat('dd/MM/y');
  bool switchButton = false;

  final reactionDisposer = <ReactionDisposer>[];
  @override
  void initState() {
    super.initState();
    final autoRunDisposer = autorun(
      (_) {
        controller.loadAccounts();
        controller.loadReasons();
        controller.loadLocal();
      },
    );
    reactionDisposer.add(autoRunDisposer);
  }

  @override
  void dispose() {
    super.dispose();
    reactionDisposer.forEach((element) => element());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entradas / Saídas'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 1.statusBarHeight, left: 16, right: 16),
          width: 1.sw,
          height: 1.sh - 1.statusBarHeight - kToolbarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.add),
                  CupertinoSwitch(
                    activeColor: Colors.red,
                    trackColor: Colors.green,
                    value: switchButton,
                    onChanged: (value) {
                      setState(() {
                        switchButton = value;
                      });
                    },
                  ),
                  Icon(Icons.remove),
                  Expanded(
                    child: DentrodobolsoTextFormField(
                      controller: controllerMoney,
                      label: 'valor',
                      textInputType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Observer(
                builder: (_) {
                  return CalendarButton(
                    onChanged: (val) => controller.setSelectedDate(val),
                    selectdDate: controller.selectedDate,
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              DentrodobolsoTextFormField(label: 'Descrição'),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  DentrodobolsoDropDownButton(
                    widget: Observer(
                      builder: (_) {
                        return DropdownButton<String>(
                          isExpanded: true,
                          underline: Container(
                            width: double.infinity,
                          ),
                          icon: const Icon(
                            Icons.keyboard_arrow_down_sharp,
                          ),
                          hint: const Text('Conta'),
                          value: controller.selectedAccount,
                          onChanged: (value) {
                            controller.setSelectedAccount(value);
                          },
                          items: controller.listAccount.map(
                            (AccountModel map) {
                              return DropdownMenuItem<String>(
                                value: map.id.toString(),
                                child: Text(
                                  '${map.instituicao} ${map.conta}',
                                ),
                              );
                            },
                          ).toList(),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  DentrodobolsoDropDownButton(
                    widget: Observer(
                      builder: (_) {
                        return DropdownButton<String>(
                          underline: Container(
                            width: double.infinity,
                          ),
                          isExpanded: true,
                          icon: const Icon(
                            Icons.keyboard_arrow_down_sharp,
                          ),
                          hint: const Text('Local'),
                          value: controller.selectedLocal,
                          // isDense: true,
                          onChanged: (value) {
                            controller.setSelectedLocal(value);
                          },
                          items: controller.listLocal.map(
                            (LocalModel map) {
                              return DropdownMenuItem<String>(
                                value: map.id.toString(),
                                child: Text(
                                  map.local,
                                ),
                              );
                            },
                          ).toList(),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  DentrodobolsoDropDownButton(
                    widget: Observer(
                      builder: (_) {
                        return DropdownButton<String>(
                          underline: Container(
                            width: double.infinity,
                          ),
                          isExpanded: true,
                          icon: const Icon(
                            Icons.keyboard_arrow_down_sharp,
                          ),
                          hint: const Text('Motivo'),
                          value: controller.selectedReasons,
                          // isDense: true,
                          onChanged: (value) {
                            controller.setSelectedReasons(value);
                          },
                          items: controller.listReasons.map(
                            (ReasonsModel map) {
                              return DropdownMenuItem<String>(
                                value: map.id.toString(),
                                child: Text(
                                  map.motivo,
                                ),
                              );
                            },
                          ).toList(),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
