import 'package:dentro_do_bolso/app/core/ui/extensions/size_screen_extension.dart';
import 'package:dentro_do_bolso/app/core/ui/extensions/theme_extension.dart';
import 'package:dentro_do_bolso/app/core/ui/widgets/calendar_button.dart';
import 'package:dentro_do_bolso/app/core/ui/widgets/dentrodobolso_drop_down_button.dart';
import 'package:dentro_do_bolso/app/core/ui/widgets/dentrodobolso_text_form_field.dart';
import 'package:dentro_do_bolso/app/models/account_model.dart';
import 'package:dentro_do_bolso/app/models/bank_model.dart';
import 'package:dentro_do_bolso/app/models/local_model.dart';
import 'package:dentro_do_bolso/app/models/reasons_model.dart';
import 'package:dentro_do_bolso/app/modules/home/expense/expense_entry_controller.dart';
import 'package:dentro_do_bolso/app/modules/home/expense/widget/dialog_account.dart';
import 'package:dentro_do_bolso/app/modules/home/expense/widget/dialog_reasons_add.dart';
import 'package:dentro_do_bolso/app/modules/home/expense/widget/dialog_simple_register.dart';
import 'package:dentro_do_bolso/app/core/ui/widgets/text_icon_button.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:validatorless/validatorless.dart';

class ExpenseEntryPage extends StatefulWidget {
  const ExpenseEntryPage({Key? key}) : super(key: key);

  @override
  _ExpenseEntryPageState createState() => _ExpenseEntryPageState();
}

class _ExpenseEntryPageState
    extends ModularState<ExpenseEntryPage, ExpenseEntryController> {
  final _controllerMoneyExpense =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  final _controllerMoneyAccount =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  final dateFormat = DateFormat('dd/MM/y');
  final _descriptionEC = TextEditingController();
  final _numAccountEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formKeyPopup = GlobalKey<FormState>();

  final reactionDisposer = <ReactionDisposer>[];
  @override
  void initState() {
    super.initState();
    final autoRunDisposer = autorun(
      (_) {
        controller.loadAccounts();
        controller.loadReasons();
        controller.loadLocal();
        controller.loadBank();
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
    _descriptionEC.dispose();
    _controllerMoneyExpense.dispose();
    _controllerMoneyAccount.dispose();
    _numAccountEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entradas / Sa??das'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding:
                EdgeInsets.only(top: 1.statusBarHeight, left: 16, right: 16),
            width: 1.sw,
            height: 1.sh - 1.statusBarHeight - kToolbarHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.add),
                    Observer(
                      builder: (_) {
                        return CupertinoSwitch(
                          activeColor: context.red,
                          trackColor: context.green,
                          value: controller.operationType,
                          onChanged: (value) => controller.setOperation(value),
                        );
                      },
                    ),
                    const Icon(Icons.remove),
                    Expanded(
                      child: DentrodobolsoTextFormField(
                        controller: _controllerMoneyExpense,
                        label: 'valor',
                        textInputType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator:
                            Validatorless.required('Valor ?? obrigat??rio'),
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
                      width: double.infinity,
                      buttonLabel: 'Selecione uma data',
                    );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                DentrodobolsoTextFormField(
                  label: 'Descri????o',
                  controller: _descriptionEC,
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
                            isExpanded: true,
                            underline: Container(
                              width: double.infinity,
                            ),
                            icon: const Icon(
                              Icons.keyboard_arrow_down_sharp,
                            ),
                            hint: const Text('Conta'),
                            value: controller.selectedAccount,
                            onChanged: (value) =>
                                controller.setSelectedAccount(value),
                            items: controller.listAccount.map(
                              (AccountModel map) {
                                return DropdownMenuItem<String>(
                                  value: map.id.toString(),
                                  onTap: () => controller.setIdAcccount(map.id),
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
                      onPressed: () => _showDialogAccount(),
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
                            onChanged: (value) =>
                                controller.setSelectedLocal(value),
                            items: controller.listLocal.map(
                              (LocalModel map) {
                                return DropdownMenuItem<String>(
                                  onTap: () => controller.setIdLocal(map.id),
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
                    Observer(
                      builder: (_) {
                        return DialogReasonsAdd(
                          message: 'Local j?? cadastrados:',
                          messageHighlighted: controller.listLocal
                              .map((local) => local.local)
                              .join(', '),
                          nameForm: 'Local',
                          title: 'Adicione um novo local',
                          saveController: (val) {
                            controller.saveLocal(val);
                          },
                        );
                      },
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
                            onChanged: (value) =>
                                controller.setSelectedReasons(value),
                            items: controller.listReasons.map(
                              (ReasonsModel map) {
                                return DropdownMenuItem<String>(
                                  onTap: () => controller.setIdReasonst(map.id),
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
                    Observer(
                      builder: (_) {
                        return DialogReasonsAdd(
                          message: 'Motivo j?? cadastrados:',
                          messageHighlighted: controller.listReasons
                              .map((reasons) => reasons.motivo)
                              .join(', '),
                          nameForm: 'Motivo',
                          title: 'Adicione um novo motivo',
                          saveController: (val) {
                            controller.saveReasons(val);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final formValid = _formKey.currentState?.validate() ?? false;
          if (formValid) {
            controller.saveExpense(
              _descriptionEC.text,
              _controllerMoneyExpense.numberValue,
            );
          }
        },
        child: const Icon(Icons.payment),
      ),
    );
  }

  _showDialogAccount() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogAccount(
          message: 'Bancos j?? cadastrados:',
          messageHighlighted:
              controller.listBank.map((bank) => bank.instituicao).join(', '),
          title: 'Deseja adicionar uma conta ou um banco?',
          onTapBanco: () => _dialogSimpleRegisterBank(),
          onTapConta: () => _showDialogRegisterAccount(),
        );
      },
    );
  }

  _showDialogRegisterAccount() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              16,
            ),
          ),
          content: Form(
            key: _formKeyPopup,
            child: Container(
              width: MediaQuery.of(context).size.width,
              constraints: const BoxConstraints(minHeight: 200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  DentrodobolsoTextFormField(
                    label: 'conta',
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    controller: _numAccountEC,
                    textInputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: Validatorless.required('Valor ?? obrigat??rio'),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
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
                          hint: const Text('Banco'),
                          value: controller.selectedBank,
                          // isDense: true,
                          onChanged: (value) =>
                              controller.setSelectedBank(value),
                          items: controller.listBank.map(
                            (BankModel map) {
                              return DropdownMenuItem<String>(
                                onTap: () => controller.setIdBank(map.id),
                                value: map.id.toString(),
                                child: Text(
                                  map.instituicao,
                                ),
                              );
                            },
                          ).toList(),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  DentrodobolsoTextFormField(
                    label: 'Valor',
                    controller: _controllerMoneyAccount,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    validator: Validatorless.required('Valor ?? obrigat??rio'),
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
                final formValid =
                    _formKeyPopup.currentState?.validate() ?? false;
                if (formValid) {
                  Navigator.pop(context);
                  controller.saveAccont(
                      _numAccountEC.text, _controllerMoneyAccount.numberValue);
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
          actionsPadding: const EdgeInsets.only(bottom: 12),
          actionsAlignment: MainAxisAlignment.center,
          title: Text(
            'Adicionar um nova conta:',
            style: TextStyle(
              color: context.darkBlue,
            ),
          ),
        );
      },
    );
  }

  _dialogSimpleRegisterBank() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogSimpleRegister(
          message: 'Bancos j?? cadastrados:',
          messageHighlighted:
              controller.listBank.map((bank) => bank.instituicao).join(', '),
          ontap: (val) {
            controller.saveBank(val);
          },
          nameForm: 'Institui????o',
          title: 'Adicione um novo banco',
        );
      },
    );
  }
}
