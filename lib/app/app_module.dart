import 'package:dentro_do_bolso/app/modules/core/core_module.dart';
import 'package:dentro_do_bolso/app/modules/home/cadastrar/cadastrar_gasto_module.dart';
import 'package:dentro_do_bolso/app/modules/home/home_module.dart';
// import 'package:dentro_do_bolso/app/modules/home/home_controller.dart';
import 'package:dentro_do_bolso/app/modules/home/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    // Bind.lazySingleton((i) => HomeController()),
  ];

  @override
  List<Module> get imports => [
        CoreModule(),
      ];
  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const HomePage(),
    ),
    ModuleRoute('/home', module: HomeModule())
  ];
}
