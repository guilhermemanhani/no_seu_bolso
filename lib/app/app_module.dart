import 'package:dentro_do_bolso/app/modules/core/core_module.dart';
import 'package:dentro_do_bolso/app/modules/home/home_module.dart';
// import 'package:dentro_do_bolso/app/core/database/sqlite_connection_factory.dart';
import 'package:dentro_do_bolso/app/modules/home/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    // Bind((i) => SqliteConnectionFactory()),
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
