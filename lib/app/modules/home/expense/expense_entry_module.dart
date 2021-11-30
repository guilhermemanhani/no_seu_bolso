import 'package:dentro_do_bolso/app/modules/home/expense/expense_entry_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ExpenseEntryModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const ExpenseEntryPage(),
    ),
  ];
}
