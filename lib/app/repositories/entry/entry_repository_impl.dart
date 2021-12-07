import 'package:dentro_do_bolso/app/core/database/sqlite_connection_factory.dart';
import 'package:dentro_do_bolso/app/models/bank_model.dart';
import 'package:dentro_do_bolso/app/models/account_model.dart';
import 'package:dentro_do_bolso/app/models/expense_model.dart';
import 'package:dentro_do_bolso/app/models/local_model.dart';
import 'package:dentro_do_bolso/app/models/reasons_model.dart';
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
  Future<List<AccountModel>> loadAccounts() async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final result = await conn.rawQuery('''
      select C.*, B.instituicao from conta C
      inner join BANCO B on B.id = C.idbanco
    ''');
    return result.map((e) => AccountModel.fromMap(e)).toList();
  }

  @override
  Future<AccountModel> loadAccount(int idconta) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final result = await conn.rawQuery(
      '''
      select * from conta
      where id = ?
    ''',
      [idconta],
    );
    // final AccountModel accountModel = AccountModel.fromJson(result);
    return result.map((e) => AccountModel.fromMap(e)).toList().first;
  }

  @override
  Future<List<LocalModel>> loadLocal() async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final result = await conn.rawQuery(
      '''
      select * from local      
    ''',
    );
    return result.map((e) => LocalModel.fromMap(e)).toList();
  }

  @override
  Future<List<ReasonsModel>> loadReasons() async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final result = await conn.rawQuery(
      '''
      select * from motivo
    ''',
    );
    return result.map((e) => ReasonsModel.fromMap(e)).toList();
  }

  @override
  Future<List<ExpenseModel>> loadExpense() async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final result = await conn.rawQuery('''
      select E.*, M.motivo, L.local, B.instituicao from lancamento E
      inner join MOTIVO M on M.id = E.motivoid
      inner join LOCAL L on L.id = E.localid
      inner join CONTA C on C.id = E.idconta
      inner join BANCO B on B.id = C.idbanco
    ''');
    return result.map((e) => ExpenseModel.fromMap(e)).toList();
  }

  @override
  Future<void> saveAccont(AccountModel accountModel) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    await conn.insert(
      'conta',
      {
        'id': null,
        'conta': accountModel.conta,
        'saldo': accountModel.saldo,
        'idbanco': accountModel.idbanco,
      },
    );
  }

  @override
  Future<void> saveLocal(String local) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    await conn.insert(
      'local',
      {
        'id': null,
        'local': local,
      },
    );
  }

  @override
  Future<void> saveReason(String reason) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    await conn.insert(
      'motivo',
      {
        'id': null,
        'motivo': reason,
      },
    );
  }

  @override
  Future<void> saveExpense(ExpenseModel expenseModel, double balanceAtt) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    await conn.insert(
      'lancamento',
      {
        'idlancamento': null,
        'datahora': expenseModel.datahora.toIso8601String(),
        'valor': expenseModel.valor,
        'descricao': expenseModel.descricao,
        'idconta': expenseModel.idconta,
        'localid': expenseModel.localid,
        'motivoid': expenseModel.motivoid,
      },
    );

    await conn.rawUpdate(
      'update conta set saldo = ? where id = ?',
      [balanceAtt, expenseModel.idconta],
    );
  }

  // final result = await conn.rawQuery('''
  //   select *
  //   from todo
  //   where data_hora between ? and ?
  //   order by data_hora
  //   ''', [
  //     startFilter.toIso8601String(),
  //     endFilter.toIso8601String(),
  //   ]);
}
