import 'package:dentro_do_bolso/app/modules/home/cadastrar/cadastrar_gasto_module.dart';
import 'package:dentro_do_bolso/app/modules/home/cadastrar/cadastrar_gasto_page.dart';
import 'package:dentro_do_bolso/app/modules/home/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  List<Module> get imports => [
        // CoreModule(),
      ];
  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const HomePage(),
    ),
    ModuleRoute('/cadastar', module: CadastrarGastoModule())
  ];
}
