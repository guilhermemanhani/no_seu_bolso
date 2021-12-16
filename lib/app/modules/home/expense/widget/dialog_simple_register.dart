import 'package:dentro_do_bolso/app/core/ui/extensions/theme_extension.dart';
import 'package:dentro_do_bolso/app/core/ui/widgets/dentrodobolso_text_form_field.dart';
import 'package:dentro_do_bolso/app/modules/home/expense/expense_entry_controller.dart';
import 'package:dentro_do_bolso/app/modules/home/expense/widget/text_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

class DialogSimpleRegister extends StatefulWidget {
  final String title;
  final String nameForm;
  final Function ontap;

  const DialogSimpleRegister({
    Key? key,
    required this.title,
    required this.nameForm,
    required this.ontap,
  }) : super(key: key);

  @override
  State<DialogSimpleRegister> createState() => _DialogSimpleRegisterState();
}

class _DialogSimpleRegisterState
    extends ModularState<DialogSimpleRegister, ExpenseEntryController> {
  final _formKey = GlobalKey<FormState>();
  final _simplesTextEC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          16,
        ),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DentrodobolsoTextFormField(
                label: widget.nameForm,
                controller: _simplesTextEC,
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                validator: Validatorless.required('Valor é obrigatório'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextIconButton(
          icon: Icons.check_circle_outline,
          title: 'Salvar',
          color: context.green,
          width: 100,
          onTap: () {
            final formValid = _formKey.currentState?.validate() ?? false;
            if (formValid) {
              Navigator.pop(context);
              widget.ontap(_simplesTextEC.text);
            }

            // widget.onTapSave();
          },
        ),
        TextIconButton(
          icon: Icons.cancel_outlined,
          title: 'Cancelar',
          color: context.red,
          width: 100,
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
      title: Text(
        widget.title,
        style: TextStyle(
          color: context.darkBlue,
        ),
      ),
    );
  }
}
