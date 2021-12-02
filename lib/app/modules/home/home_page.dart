import 'package:dentro_do_bolso/app/core/ui/extensions/size_screen_extension.dart';
import 'package:dentro_do_bolso/app/core/ui/extensions/theme_extension.dart';
import 'package:dentro_do_bolso/app/core/ui/uiconfig.dart';
import 'package:dentro_do_bolso/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  final reactionDisposer = <ReactionDisposer>[];
  String dropdownValue = 'One';
  // var controllerMoney = MoneyMaskedTextController(
  //     decimalSeparator: ',', thousandSeparator: '.');
  //     controller
  //             .setValor(Decimal.parse(controllerMoney.numberValue.toString())),
  @override
  void initState() {
    super.initState();
    final autoRunDisposer = autorun(
      (_) {
        controller.loadAccounts();
        controller.loadExpense();
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
      body: SingleChildScrollView(
        child: SizedBox(
          width: 1.sw,
          height: 1.sh - 1.statusBarHeight - kToolbarHeight,
          child: Column(
            children: [
              Observer(
                builder: (_) {
                  return Container(
                    color: context.primaryColor,
                    height: 280.h,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            top: 1.statusBarHeight + 30,
                          ),
                          height: 120.h,
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.white),
                            underline: Container(
                              height: 2,
                              color: Colors.white,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: <String>['One', 'Two', 'Free', 'Four']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            top: 16,
                          ),
                          height: 80.h,
                          child: Observer(
                            builder: (_) {
                              return Text(
                                controller.accountInfoModel?.balance == null
                                    ? 'Não Informado'
                                    : controller.accountInfoModel!.balance
                                        .toString(),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 80.h,
                          child: Observer(
                            builder: (_) {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: controller
                                    .accountInfoModel?.listAccount.length,
                                itemBuilder: (context, index) {
                                  final account = controller
                                      .accountInfoModel?.listAccount[index];
                                  if (controller
                                          .accountInfoModel?.listAccount ==
                                      null) {
                                    return Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: const [
                                            Text('nao informado'),
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      color: Colors.white,
                                      width: 160.w,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(account!.instituicao!),
                                          Text(account.saldo.toString()),
                                        ],
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.saveExpense(),
        // Navigator.pushNamed(context, '/home/cadastar'),
        child: const Icon(Icons.payment),
      ),
    );
  }
}
