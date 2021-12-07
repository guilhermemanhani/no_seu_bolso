import 'package:dentro_do_bolso/app/core/ui/extensions/size_screen_extension.dart';
import 'package:dentro_do_bolso/app/core/ui/widgets/calendar_button.dart';
import 'package:dentro_do_bolso/app/core/ui/widgets/dentrodobolso_drop_down_button.dart';
import 'package:dentro_do_bolso/app/core/ui/widgets/dentrodobolso_text_form_field.dart';
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
        controller.loadBanks();
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
                height: 12,
              ),
              Observer(
                builder: (_) {
                  return CalendarButton(
                    onPressed: controller,
                    selectdDate: controller.selectedDate,
                  );
                },
              ),
              const SizedBox(
                height: 12,
              ),
              DentrodobolsoTextFormField(label: 'Descrição'),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Observer(
                    builder: (_) {
                      return DentrodobolsoDropDownButton(
                        onChange: () {},
                        selectValue: controller.listAccount.first,
                        valueList: controller.listAccount,
                      );
                    },
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              DentrodobolsoTextFormField(label: 'Local'),
              const SizedBox(
                height: 12,
              ),
              DentrodobolsoTextFormField(label: 'Motivo'),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
