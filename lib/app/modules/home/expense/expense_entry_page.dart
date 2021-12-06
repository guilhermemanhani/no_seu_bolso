import 'package:dentro_do_bolso/app/core/ui/extensions/size_screen_extension.dart';
import 'package:dentro_do_bolso/app/core/ui/widgets/calendar_button.dart';
import 'package:dentro_do_bolso/app/core/ui/widgets/dentrodobolso_drop_down_button.dart';
import 'package:dentro_do_bolso/app/core/ui/widgets/dentrodobolso_text_form_field.dart';
import 'package:dentro_do_bolso/app/modules/home/expense/expense_entry_controller.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
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
        title: const Text('Entradas'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(top: 1.statusBarHeight + 30, left: 16, right: 16),
          width: 1.sw,
          height: 1.sh - 1.statusBarHeight - kToolbarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DentrodobolsoTextFormField(
                controller: controllerMoney,
                label: 'valor',
                textInputType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 12,
              ),
              // InkWell(
              //   onTap: () async {
              //     var lastDate = DateTime.now();
              //     lastDate.add(
              //       const Duration(days: 10 * 365),
              //     );
              //     final DateTime? selectedDate = await showDatePicker(
              //       context: context,
              //       initialDate: DateTime.now(),
              //       firstDate: DateTime(2000),
              //       lastDate: DateTime(2025),
              //     );
              //     controller.setSelectedDate(selectedDate);
              //   },
              //   borderRadius: BorderRadius.circular(15),
              //   child: Container(
              //     width: double.infinity,
              //     height: 64.h,
              //     padding: const EdgeInsets.all(10),
              //     decoration: BoxDecoration(
              //       border: Border.all(color: Colors.grey),
              //       borderRadius: BorderRadius.circular(15),
              //     ),
              //     child: Row(
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         const Icon(
              //           Icons.today,
              //           color: Colors.grey,
              //         ),
              //         const SizedBox(
              //           width: 10,
              //         ),
              //         Observer(builder: (_) {
              //           return Text(
              //             controller.selectedDate != null
              //                 ? dateFormat.format(controller.selectedDate!)
              //                 : 'SELECIONE UMA DATA',
              //           );
              //         }),
              //       ],
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 12,
              ),
              DentrodobolsoTextFormField(label: 'Descrição'),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  DentrodobolsoDropDownButton(
                    onChange: () {},
                    selectValue: 'Jan',
                    valueList: ['Jan', 'Fev', 'Mar'],
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
