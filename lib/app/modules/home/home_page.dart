import 'package:dentro_do_bolso/app/core/ui/extensions/size_screen_extension.dart';
import 'package:dentro_do_bolso/app/core/ui/widgets/dentrodobolso_drop_down_button.dart';
import 'package:dentro_do_bolso/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
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
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.blue,
                          Colors.blueGrey,
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 1.statusBarHeight + 30,
                          ),
                          // child: DentrodobolsoDropDownButton(
                          //   onChange: () {},
                          //   selectValue: 'Jan',
                          //   valueList: const [
                          //     'Jan',
                          //     'Fev',
                          //     'Mar',
                          //   ],
                          // ),
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
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: 80.h,
                child: Observer(
                  builder: (_) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          controller.accountInfoModel?.listAccount.length,
                      itemBuilder: (context, index) {
                        final account =
                            controller.accountInfoModel?.listAccount[index];
                        if (controller.accountInfoModel?.listAccount == null) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('nao informado'),
                            ],
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              width: 160.w,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    account!.instituicao!,
                                  ),
                                  Text(
                                    account.saldo.toString(),
                                    style: TextStyle(
                                      color:
                                          account.saldo.toString().contains('-')
                                              ? Colors.red
                                              : Colors.green,
                                    ),
                                  ),
                                ],
                              ),
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            // controller.saveExpense(),
            Navigator.pushNamed(context, '/home/cadastar'),
        child: const Icon(Icons.payment),
      ),
    );
  }
}
