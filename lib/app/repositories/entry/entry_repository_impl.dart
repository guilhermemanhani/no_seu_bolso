import 'package:dentro_do_bolso/app/core/database/sqlite_connection_factory.dart';
import 'package:dentro_do_bolso/app/models/bank_model.dart';
import 'package:dentro_do_bolso/app/models/account_model.dart';
import 'package:dentro_do_bolso/app/models/expense_by_local_model.dart';
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
        'tpagamento': expenseModel.tpagamento,
      },
    );

    await conn.rawUpdate(
      'update conta set saldo = ? where id = ?',
      [balanceAtt, expenseModel.idconta],
    );
  }

  @override
  Future<List<ExpenseModel>> getExpenseByPeriod(
      DateTime start, DateTime end) async {
    final startFilter = DateTime(start.year, start.month, start.day, 0, 0, 0);
    final endFilter = DateTime(end.year, end.month, end.day, 23, 59, 59);

    final conn = await _sqliteConnectionFactory.openConnection();
    final result = await conn.rawQuery(
      ''' 
      select E.*, L.local, B.instituicao from lancamento E   
      inner join LOCAL L on L.id = E.localid
      inner join CONTA C on C.id = E.idconta
      inner join BANCO B on B.id = C.idbanco
      where datahora between ? and ?
      ''',
      [
        startFilter.toIso8601String(),
        endFilter.toIso8601String(),
      ],
    );
    return result.map((e) => ExpenseModel.fromMap(e)).toList();
  }

  @override
  Future<List<ExpenseByLocalModel>> getExpenseByLocal(
      DateTime start, DateTime end) async {
    final startFilter = DateTime(start.year, start.month, start.day, 0, 0, 0);
    final endFilter = DateTime(end.year, end.month, end.day, 23, 59, 59);

    final conn = await _sqliteConnectionFactory.openConnection();
    final result = await conn.rawQuery(
      ''' 
      SELECT COUNT(*) as contador, SUM(la.valor) as soma, la.tpagamento, lo.local as local FROM lancamento la
      inner join  local lo on la.localid = lo.id
      where datahora between ? and ?
      group by lo.local
      ''',
      [
        startFilter.toIso8601String(),
        endFilter.toIso8601String(),
      ],
    );
    return result.map((e) => ExpenseByLocalModel.fromMap(e)).toList();
  }

  @override
  Future<List<ExpenseModel>> getExpenseByPeriodByAccount(
      int idAccount, DateTime start, DateTime end) async {
    final startFilter = DateTime(start.year, start.month, start.day, 0, 0, 0);
    final endFilter = DateTime(end.year, end.month, end.day, 23, 59, 59);

    final conn = await _sqliteConnectionFactory.openConnection();
    final result = await conn.rawQuery(
      ''' 
      select E.*, L.local, B.instituicao from lancamento E   
      inner join LOCAL L on L.id = E.localid
      inner join CONTA C on C.id = E.idconta
      inner join BANCO B on B.id = C.idbanco
      where e.idconta = ?
      and datahora between ? and ?
      order by e.datahora
      ''',
      [
        idAccount,
        startFilter.toIso8601String(),
        endFilter.toIso8601String(),
      ],
    );
    return result.map((e) => ExpenseModel.fromMap(e)).toList();
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

// SELECT SUM(la.valor), lo.local FROM lancamento la
// inner join  local lo on la.localid = lo.id
// where la.tpagamento = 0
// group by lo.local

//   select count(*), sum(vl_lancamento), upper(tl.ds_lancamento )
// from lancamento_diario l
// inner join tipo_lancamento tl on tl.cd_tp_lancamento = l.cd_tp_lancamento
// where l.cd_coop = 1040
// 	and l.dt_lancamento = '20211221'
// 	and cd_posto = 0
// 	group by tl.ds_lancamento
}
