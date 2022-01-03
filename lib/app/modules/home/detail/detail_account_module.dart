import 'package:dentro_do_bolso/app/modules/home/detail/detail_account_controller.dart';
import 'package:dentro_do_bolso/app/modules/home/detail/detail_account_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DetailAccountModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => DetailAccountController(entryService: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const DetailAccountPage(),
    ),
  ];
}
