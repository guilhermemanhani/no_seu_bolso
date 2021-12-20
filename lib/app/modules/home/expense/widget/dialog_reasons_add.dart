import 'package:dentro_do_bolso/app/modules/home/expense/widget/dialog_simple_register.dart';
import 'package:flutter/material.dart';

class DialogReasonsAdd extends StatelessWidget {
  final Function saveController;
  final String nameForm;
  final String title;

  const DialogReasonsAdd({
    Key? key,
    required this.saveController,
    required this.nameForm,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return DialogSimpleRegister(
              ontap: (val) {
                saveController(val);
              },
              nameForm: nameForm,
              title: title,
            );
          },
        );
      },
      icon: const Icon(Icons.add),
    );
  }
}
