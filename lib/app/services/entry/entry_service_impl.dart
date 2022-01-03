import 'package:decimal/decimal.dart';
import 'package:dentro_do_bolso/app/models/account_info_model.dart';
import 'package:dentro_do_bolso/app/models/bank_model.dart';
import 'package:dentro_do_bolso/app/models/account_model.dart';
import 'package:dentro_do_bolso/app/models/expense_by_local_model.dart';
import 'package:dentro_do_bolso/app/models/expense_model.dart';
import 'package:dentro_do_bolso/app/models/reasons_model.dart';
import 'package:dentro_do_bolso/app/models/local_model.dart';
import 'package:dentro_do_bolso/app/repositories/entry/entry_repository.dart';
import 'package:dentro_do_bolso/app/services/entry/entry_service.dart';

class EntryServiceImpl implements EntryService {
  final EntryRepository _entryRepository;

  EntryServiceImpl({
    required EntryRepository entryRepository,
  }) : _entryRepository = entryRepository;

  @override
  Future<void> saveBank(String bancoNome) =>
      _entryRepository.saveBank(bancoNome);

  @override
  Future<List<BankModel>> loadBanks() => _entryRepository.loadBanks();

  @override
  Future<void> saveAccont(AccountModel accountModel) =>
      _entryRepository.saveAccont(accountModel);

  @override
  Future<void> saveLocal(String local) => _entryRepository.saveLocal(local);

  @override
  Future<void> saveReason(String reason) => _entryRepository.saveReason(reason);

  @override
  Future<void> saveExpense(ExpenseModel expenseModel) async {
    AccountModel account =
        await _entryRepository.loadAccount(expenseModel.idconta);
    // print(account);
    Decimal balanceAtt;
    if (expenseModel.tpagamento == 0) {
      balanceAtt = Decimal.parse(account.saldo.toString()) -
          Decimal.parse(expenseModel.valor.toString());
    } else {
      balanceAtt = Decimal.parse(account.saldo.toString()) +
          Decimal.parse(expenseModel.valor.toString());
    }

    await _entryRepository.saveExpense(
      expenseModel,
      double.parse(balanceAtt.toString()),
    );
  }

  @override
  Future<AccountInfoModel> loadAccounts() async {
    List<AccountModel> listAccount = await _entryRepository.loadAccounts();
    Decimal balance = Decimal.parse('0.0');
    for (var element in listAccount) {
      balance += Decimal.parse(element.saldo.toString());
    }
    AccountInfoModel accountInfoModel =
        AccountInfoModel(listAccount: [], balance: balance);
    accountInfoModel.listAccount.addAll(listAccount);
    return accountInfoModel;
  }

  @override
  Future<List<ExpenseModel>> loadExpense() => _entryRepository.loadExpense();

  @override
  Future<List<AccountModel>> loadAccountsList() =>
      _entryRepository.loadAccounts();

  @override
  Future<List<LocalModel>> loadLocal() => _entryRepository.loadLocal();

  @override
  Future<List<ReasonsModel>> loadReasons() => _entryRepository.loadReasons();

  @override
  Future<List<ExpenseModel>> getMonth() {
    final today = DateTime.now();
    var start = DateTime(today.year, today.month - 1, 1, 0, 0, 0);
    var end = DateTime(today.year, today.month + 1, 0, 0, 0, 0);
    return _entryRepository.getExpenseByPeriod(start, end);
  }

  @override
  Future<List<ExpenseByLocalModel>> getExpenseByLocal() {
    final today = DateTime.now();
    var start = DateTime(today.year, today.month - 1, 1, 0, 0, 0);
    var end = DateTime(today.year, today.month + 1, 0, 0, 0, 0);
    return _entryRepository.getExpenseByLocal(start, end);
  }

  @override
  Future<List<ExpenseModel>> getExpenseByPeriodByAccount(
      int idAccount, DateTime? start, DateTime? end) {
    final today = DateTime.now();
    start = start ?? DateTime(today.year, today.month - 1, 1, 0, 0, 0);
    end = end ?? DateTime(today.year, today.month + 1, 0, 0, 0, 0);
    return _entryRepository.getExpenseByPeriodByAccount(idAccount, start, end);
  }
}
