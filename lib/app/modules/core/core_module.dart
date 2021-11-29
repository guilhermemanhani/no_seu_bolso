import 'package:dentro_do_bolso/app/core/database/sqlite_connection_factory.dart';
import 'package:dentro_do_bolso/app/repositories/entry/entry_repository.dart';
import 'package:dentro_do_bolso/app/repositories/entry/entry_repository_impl.dart';
import 'package:dentro_do_bolso/app/services/entry/entry_service.dart';
import 'package:dentro_do_bolso/app/services/entry/entry_service_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CoreModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SqliteConnectionFactory(), export: true),
    Bind.lazySingleton<EntryRepository>(
        (i) => EntryRepositoryImpl(sqliteConnectionFactory: i()),
        export: true),
    Bind.lazySingleton<EntryService>(
        (i) => EntryServiceImpl(entryRepository: i()),
        export: true),
  ];
}
