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
import 'package:validatorless/validatorless.dart';

class ExpenseEntryPage extends StatefulWidget {
  const ExpenseEntryPage({Key? key}) : super(key: key);

  @override
  _ExpenseEntryPageState createState() => _ExpenseEntryPageState();
}

class _ExpenseEntryPageState
    extends ModularState<ExpenseEntryPage, ExpenseEntryController> {
  final _controllerMoney =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  final dateFormat = DateFormat('dd/MM/y');
  bool switchButton = false;
  final _descriptionEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
    _descriptionEC.dispose();
    _controllerMoney.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entradas / Saídas'),
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
                    const Icon(Icons.remove),
                    Expanded(
                      child: DentrodobolsoTextFormField(
                        controller: _controllerMoney,
                        label: 'valor',
                        textInputType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator:
                            Validatorless.required('Valor é obrigatório'),
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
                DentrodobolsoTextFormField(
                  label: 'Descrição',
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final formValid = _formKey.currentState?.validate() ?? false;
          if (formValid) {
            controller.saveExpense(
              _descriptionEC.text,
              _controllerMoney.numberValue,
            );
          }
        },
        child: const Icon(Icons.payment),
      ),
    );
  }

  // _showDialogQrcode() {
  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(
  //             16,
  //           ),
  //         ),
  //         content: SingleChildScrollView(
  //           child: Observer(
  //             builder: (BuildContext context) {
  //               if (controller.isLoadingQrCode) {
  //                 return Center(
  //                   child: CircularProgressIndicator(),
  //                 );
  //               } else if (controller.qrFuture.error != null) {
  //                 return Center(
  //                   child: Text(
  //                     "Ops... \n ${controller.qrFuture.error}",
  //                     textAlign: TextAlign.center,
  //                     style: TextStyle(
  //                       fontWeight: FontWeight.w900,
  //                       fontSize: 25,
  //                     ),
  //                   ),
  //                 );
  //               } else {
  //                 List<int> img = controller
  //                     .gerarImg(controller.qrFuture.value.imagemBase64);
  //                 return Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Center(
  //                       child: Container(
  //                         decoration: ConstsApp.caixaAredondadaBranca,
  //                         height: 250,
  //                         width: 250,
  //                         child: Padding(
  //                           padding: const EdgeInsets.all(6.0),
  //                           child: Image.memory(
  //                             Uint8List.fromList(
  //                               img,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(vertical: 16.0),
  //                       child: Center(
  //                         child: Text(
  //                           "Valor (R\$): ${controllerMoney.text}",
  //                           style: ConstsApp.estiloTituloAzulUm,
  //                         ),
  //                       ),
  //                     ),
  //                     Text.rich(
  //                       TextSpan(
  //                         text: "Identificador: ",
  //                         style: ConstsApp.estiloNegritoBlack87,
  //                         children: [
  //                           TextSpan(
  //                             text: controller.qrFuture.value.identificador,
  //                             style: ConstsApp.estiloNeutro,
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: 4,
  //                     ),
  //                     Text.rich(
  //                       TextSpan(
  //                         text: "Descrição: ",
  //                         style: ConstsApp.estiloNegritoBlack87,
  //                         children: [
  //                           TextSpan(
  //                             text: controller.qrFuture.value.descricao,
  //                             style: ConstsApp.estiloNeutro,
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: 4,
  //                     ),
  //                     ElevatedButton(
  //                       style: ElevatedButton.styleFrom(
  //                         primary: ConstsApp.azulPadraoUniprime,
  //                       ),
  //                       onPressed: () => Modular.to.pop(),
  //                       child: Center(
  //                         child: Text("Sair"),
  //                       ),
  //                     ),
  //                   ],
  //                 );
  //               }
  //             },
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
