import 'package:dentro_do_bolso/app/modules/home/expense/expense_entry_controller.dart';
import 'package:dentro_do_bolso/app/modules/home/expense/widget/dialog_simple_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DialogReasonsAdd extends StatefulWidget {
  const DialogReasonsAdd({Key? key}) : super(key: key);

  @override
  _DialogReasonsAddState createState() => _DialogReasonsAddState();
}

class _DialogReasonsAddState
    extends ModularState<DialogReasonsAdd, ExpenseEntryController> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return DialogSimpleRegister(
              ontap: (val) {
                controller.saveReasons(val);
              },
              nameForm: 'Motivo',
              title: 'Adicione um novo motivo',
            );
          },
        );
      },
      icon: const Icon(Icons.add),
    );
  }
}
