import 'package:dentro_do_bolso/app/modules/home/detail/detail_account_module.dart';
import 'package:dentro_do_bolso/app/modules/home/expense/expense_entry_module.dart';
import 'package:dentro_do_bolso/app/modules/home/home_controller.dart';
import 'package:dentro_do_bolso/app/modules/home/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeController(entryService: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const HomePage(),
    ),
    ModuleRoute('/cadastar/', module: ExpenseEntryModule()),
    ModuleRoute('/detail/', module: DetailAccountModule()),
  ];
}
