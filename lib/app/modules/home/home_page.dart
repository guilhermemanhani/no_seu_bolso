import 'package:dentro_do_bolso/app/core/ui/extensions/size_screen_extension.dart';
import 'package:dentro_do_bolso/app/core/ui/extensions/theme_extension.dart';
import 'package:dentro_do_bolso/app/core/ui/uiconfig.dart';
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
        controller.loadAccount();
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
        child: Container(
          width: 1.sw,
          height: 1.sh,
          child: Column(
            children: [
              Observer(
                builder: (_) {
                  return Container(
                    color: context.primaryColor,
                    height: 150.w,
                    width: double.infinity,
                    child: Observer(
                      builder: (_) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.account.length,
                          itemBuilder: (context, index) {
                            final account = controller.account[index];
                            return Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(account.instituicao!),
                                  Text(account.saldo.toString()),
                                ],
                              ),
                            );
                          },
                        );
                      },
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
