import 'package:dentro_do_bolso/app/core/ui/extensions/size_screen_extension.dart';
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
      appBar: AppBar(
        title: Text(
          UiConfig.title,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(top: 1.statusBarHeight + 30, left: 16, right: 16),
          height: 1.sh - 1.statusBarHeight - kToolbarHeight,
          width: 1.sw,
          child: Column(
            children: [
              Observer(
                builder: (_) {
                  return Container(
                    width: double.infinity,
                    color: Colors.red,
                    child: Text('Criar lista observable'),
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
