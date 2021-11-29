import 'package:dentro_do_bolso/app/core/database/sqlite_connection_factory.dart';
import 'package:dentro_do_bolso/app/models/bank_model.dart';
import 'package:dentro_do_bolso/app/models/conta_model.dart';
import 'package:dentro_do_bolso/app/repositories/entry/entry_repository.dart';

class EntryRepositoryImpl implements EntryRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;

  EntryRepositoryImpl({
    required SqliteConnectionFactory sqliteConnectionFactory,
  }) : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<void> saveBank(String nomeBanco) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    await conn.insert(
      'banco',
      {
        'id': null,
        'instituicao': nomeBanco,
      },
    );
  }

  @override
  Future<List<BankModel>> loadBanks() async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final result = await conn.rawQuery('''
      select * from banco
    ''');
    return result.map((e) => BankModel.fromMap(e)).toList();
  }

  @override
  Future<void> saveAccont(ContaModel contaModel) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    await conn.insert(
      'banco',
      {
        'id': null,
        'conta': contaModel.conta,
        'saldo': contaModel.saldo,
        'idbanco': contaModel.idbanco,
      },
    );
  }
}
