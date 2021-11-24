import 'package:dentro_do_bolso/app/modules/home/cadastrar/cadastrar_gasto_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CadastrarGastoModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const CadastrarGastoPage(),
    ),
  ];
}
