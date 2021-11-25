import 'package:dentro_do_bolso/app/core/ui/uiconfig.dart';
import 'package:dentro_do_bolso/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  void initState() {
    super.initState();
    controller.loadTotalTasks();
    // DefaultListenerNotifier(changeNotifier: widget._homeController).listener(
    //   context: context,
    //   successCallback: (notifier, listenerInstance) {
    //     listenerInstance.dispose();
    //   },
    // );
    // WidgetsBinding.instance?.addPostFrameCallback(
    //   (timeStamp) {
    //     widget._homeController.loadTotalTasks();
    //     widget._homeController.findTasks(filter: TaskFilterEnum.today);
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          UiConfig.title,
        ),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/cadastar'),
        child: const Icon(Icons.payment),
      ),
    );
  }
}
